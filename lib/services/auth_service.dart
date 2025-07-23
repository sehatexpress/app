import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler;
import 'user_service.dart';

final _auth = FirebaseAuth.instance;
final _userService = UserService();

@immutable
class AuthService {
  const AuthService();
  User? get currentUser => _auth.currentUser;

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

  // 🔹 Register with email & password
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCred.user != null) {
        await userCred.user!.updateDisplayName(name);
        await userCred.user!.reload();
      }
      return userCred.user;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Update current user profile (Firebase + Firestore)
  Future<void> updateCurrentProfile({
    required String name,
    required int gender,
    required String phone,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw 'No authenticated user found';

    try {
      await user.updateDisplayName(name);
      await _userService.updateUser(
          uid: user.uid, name: name, gender: gender, phone: phone);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Change password (Re-authentication required)
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw 'No authenticated user found';

    try {
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
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

  // 🔹 Send password reset link
  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final authServiceProvider = Provider<AuthService>((_) => AuthService());
