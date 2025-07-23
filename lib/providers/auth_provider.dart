import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/enums.dart' show MessageType;
import '../config/extensions.dart' show StringExtensions;
import '../config/string_constants.dart' show Strings;
import '../services/address_service.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../services/user_service.dart';
import 'global_provider.dart' show globalProvider;
import 'location_provider.dart' show locationProvider;

class AuthStateNotifier extends StateNotifier<User?> {
  final Ref ref;

  // Initializing notifier
  AuthStateNotifier(this.ref)
      : super(ref.read(authServiceProvider).currentUser);

  // 🔹 Utility function for reducing redundant try-catch blocks
  Future<void> _performSafeOperation(Future<void> Function() operation) async {
    try {
      ref.read(globalProvider.notifier).updateLoading(true);
      await operation();
    } catch (e) {
      ref.read(globalProvider.notifier).updateMessage(e.toString());
    } finally {
      ref.read(globalProvider.notifier).updateLoading(false);
      state = ref.read(authServiceProvider).currentUser;
    }
  }

  // 🔹 Login with email & password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _performSafeOperation(() async {
      var user = await ref.read(authServiceProvider).loginWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (user == null) {
        ref.read(globalProvider.notifier).updateMessage(Strings.error);
        return;
      }

      final token = await notificationService.getDeviceToken();
      if (token != null) {
        await ref
            .read(userServiceProvider)
            .updateDeviceToken(token: token, uid: user.uid);
      }

      if (!kIsWeb) {
        final name = (user.displayName ?? '').split(' ').first.capitalize;
        notificationService.sendLocalNotification(
          'Welcome back, $name!',
          'Your recent orders are ready to view. Let\'s find your next meal.',
        );
      }
    });
  }

  // 🔹 Register user with email & password
  Future<void> register({
    required String email,
    required String password,
    required String name,
    int? gender,
    required String mobile,
    String? type,
  }) async {
    await _performSafeOperation(() async {
      var isUserExistWithMobile =
          await ref.read(userServiceProvider).checkRegisteredUser(mobile);
      if (isUserExistWithMobile) {
        ref
            .read(globalProvider.notifier)
            .updateMessage(Strings.duplicateMobile);
        return;
      }
      var user =
          await ref.read(authServiceProvider).registerWithEmailAndPassword(
                email: email,
                password: password,
                name: name,
              );

      if (user == null) {
        ref.read(globalProvider.notifier).updateMessage(Strings.error);
        return;
      }

      final deviceToken = await notificationService.getDeviceToken();
      var location = ref.read(locationProvider);
      var uid = user.uid;

      await ref.read(userServiceProvider).saveNewUser(
            uid: uid,
            name: name,
            gender: gender,
            email: email,
            mobile: mobile,
            deviceToken: deviceToken,
          );

      if (location.location != null && type != null) {
        await ref.read(addressServiceProvider).addAddress(
              uid: uid,
              name: name,
              mobile: mobile,
              email: user.email,
              type: type,
              address: location.location!.displayName,
              latitude: location.location!.latitude,
              longitude: location.location!.longitude,
            );
      }

      if (!kIsWeb) {
        final n = name.split(' ').first.capitalize;
        notificationService.sendLocalNotification(
          'Welcome, $n!',
          'Your favorite restaurants are waiting. Dive into the delicious world of food.',
        );
      }
    });
  }

  // 🔹 Update profile
  Future<void> updateProfile({
    required String name,
    required int gender,
    required String phone,
  }) async {
    if (state == null) {
      ref
          .read(globalProvider.notifier)
          .updateMessage(Strings.loginBeforeProceeding);
      return;
    }

    await _performSafeOperation(() async {
      await ref
          .read(authServiceProvider)
          .updateCurrentProfile(name: name, gender: gender, phone: phone);
    });
  }

  // 🔹 Logout
  Future<void> logout() async {
    if (state == null) {
      ref
          .read(globalProvider.notifier)
          .updateMessage(Strings.loginBeforeProceeding);
      return;
    }

    await _performSafeOperation(() async {
      if (!kIsWeb) {
        final name = (state?.displayName ?? '').split(' ').first.capitalize;
        notificationService.sendLocalNotification(
          'Logged out!',
          'We\'ll miss you, $name! Come back soon.',
        );
      }
      await ref.read(authServiceProvider).logout();
      state = null; // Explicitly setting state to null after logout
    });
  }

  // 🔹 Update password
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (state == null) {
      ref
          .read(globalProvider.notifier)
          .updateMessage(Strings.loginBeforeProceeding);
      return;
    }

    await _performSafeOperation(() async {
      await ref.read(authServiceProvider).changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          );
      ref.read(globalProvider.notifier).updateMessage(
            Strings.passwordUpdated,
            type: MessageType.success,
          );
    });
  }

  // 🔹 Send password reset link
  Future<void> sendPasswordResetLink(String email) async {
    await _performSafeOperation(() async {
      await ref.read(authServiceProvider).sendPasswordResetLink(email);
    });
  }
}

// 🔹 StateNotifierProvider
final authProvider = StateNotifierProvider<AuthStateNotifier, User?>(
  (ref) => AuthStateNotifier(ref),
);

// 🔹 Provider to get the user UID
final authUidProvider =
    Provider<String?>((ref) => ref.watch(authProvider)?.uid);
