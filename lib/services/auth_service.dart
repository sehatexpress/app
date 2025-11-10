import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler;
import '../config/string_constants.dart';

final _auth = FirebaseAuth.instance;

@immutable
class AuthService {
  const AuthService();
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // reload user
  Future<User?> reloadUser() async {
    try {
      if (_auth.currentUser == null) throw Strings.loginBeforeProceeding;
      await _auth.currentUser!.reload();
      return _auth.currentUser;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 login with custom token
  Future<User?> loginWithToken(String token) async {
    try {
      final userCred = await _auth.signInWithCustomToken(token);
      return userCred.user;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Login with email & password
  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred.user;
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
