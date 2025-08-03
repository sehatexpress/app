import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/auth_service.dart';
import 'global_provider.dart';

class AuthStateNotifier extends StateNotifier<User?> {
  final Ref ref;
  final AuthService _authService;

  // Initializing notifier
  AuthStateNotifier(this.ref, this._authService)
    : super(_authService.currentUser) {
    _authService.authStateChanges.listen((user) => state = user);
  }

  String? _verificationId;
  int? _resendToken;

  // ✅ Send OTP to phone number
  Future<void> sendOTP({
    required String phoneNumber,
    required VoidCallback onCodeSent,
  }) async {
    await _performSafeOperation(() async {
      await _authService.verifyPhone(
        phone: '+91$phoneNumber',
        forceResendingToken: _resendToken,
        onCodeSent: (verificationId, resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          onCodeSent();
          _showMessage("OTP sent successfully");
          ref.read(isOTPSentProvider.notifier).state = true;
        },
        onVerified: (credential) async {
          final user = await signInWithCredential(credential);
          if (user != null) {
            _showMessage("Phone auto-verified");
          }
        },
        onFailed: (e) {
          _showMessage(e.message ?? "OTP verification failed");
        },
        onAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    });
  }

  // ✅ Manually verify OTP
  Future<void> verifyOTP(String otp) async {
    if (_verificationId == null) {
      _showMessage("Verification code expired or invalid");
      return;
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );

    await _performSafeOperation(() async {
      final user = await signInWithCredential(credential);
      if (user != null) {
        _showMessage("Phone verified successfully");
      }
    });
  }

  // ✅ Sign in using phone auth credential
  Future<User?> signInWithCredential(AuthCredential credential) async {
    final userCredential = await _authService.signInWithCredential(credential);
    state = userCredential;
    return state;
  }

  // ✅ Sign out
  Future<void> signOut() async {
    await _authService.logout();
    state = null;
  }

  // ✅ Helper for loading + try/catch
  Future<void> _performSafeOperation(Future<void> Function() operation) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      await operation();
    } catch (e) {
      _showMessage(e.toString());
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  void _showMessage(String message) {
    ref.read(messageProvider.notifier).state = message;
  }
}

final isOTPSentProvider = StateProvider((_) => false);

// 🔹 StateNotifierProvider
final authProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthStateNotifier(ref, authService);
});

// 🔹 Provider to get the user UID
final authUidProvider = Provider<String?>(
  (ref) => ref.watch(authProvider)?.uid,
);
