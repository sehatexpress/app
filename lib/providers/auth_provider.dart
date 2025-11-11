import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../config/extensions.dart';
import '../config/string_constants.dart';
import '../services/auth_service.dart';
import 'global_provider.dart';

class AuthStateNotifier extends StateNotifier<User?> {
  final Ref ref;
  final AuthService _auth;

  // Initializing notifier
  AuthStateNotifier(this.ref, this._auth) : super(_auth.currentUser) {
    _auth.authStateChanges.listen((user) => state = user);
  }

  // 🔹 Login with email & password
  Future<void> login({required String email, required String password}) async {
    await ref.withLoading(() async {
      var user = await _auth.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = user;
    });
  }

  // 🔹 Login with token
  Future<void> loginWithToken(String token) async {
    await ref.withLoading(() async {
      var user = await _auth.loginWithToken(token);
      state = user;
    });
  }

  // 🔹 Logout
  Future<void> logout() async {
    if (state == null) {
      ref.read(messageProvider.notifier).state = Strings.loginBeforeProceeding;
      return;
    }

    await ref.withLoading(() async {
      await _auth.logout();
      state = null;
    });
  }
}

// 🔹 StateNotifierProvider
final authProvider = StateNotifierProvider<AuthStateNotifier, User?>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthStateNotifier(ref, authService);
});

// 🔹 Provider to get the user UID
final authUidProvider = Provider<String?>(
  (ref) => ref.watch(authProvider)?.uid,
);
