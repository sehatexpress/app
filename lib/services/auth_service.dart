import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler;

final _auth = FirebaseAuth.instance;

@immutable
class AuthService {
  const AuthService();
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> verifyPhone({
    required String phone,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(PhoneAuthCredential) onVerified,
    required Function(FirebaseAuthException) onFailed,
    required Function(String) onAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: onVerified,
        verificationFailed: onFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: onAutoRetrievalTimeout,
        forceResendingToken: forceResendingToken,
      );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  Future<User?> signInWithCredential(AuthCredential credential) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final authServiceProvider = Provider<AuthService>((_) => AuthService());
