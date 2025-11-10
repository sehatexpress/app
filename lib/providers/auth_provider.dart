import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../config/extensions.dart';
import '../config/string_constants.dart';
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

  // 🔹 Login with email & password
  Future<void> login({required String email, required String password}) async {
    await ref.withLoading(() async {
      var user = await _authService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _initLogin(user);
    });
  }

  // 🔹 Login with token
  Future<void> loginWithToken(String token) async {
    await ref.withLoading(() async {
      var user = await _authService.loginWithToken(token);
      await _initLogin(user);
    });
  }

  // 🔹 init Login
  Future<void> _initLogin(User? user) async {
    if (user == null) {
      ref.read(messageProvider.notifier).state = Strings.error;
      return;
    }
    state = ref.read(authServiceProvider).currentUser;
  }

  // 🔹 Logout
  Future<void> logout() async {
    if (state == null) {
      ref.read(messageProvider.notifier).state = Strings.loginBeforeProceeding;
      return;
    }

    await ref.withLoading(() async {
      await _authService.logout();
      state = null;
    });
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
