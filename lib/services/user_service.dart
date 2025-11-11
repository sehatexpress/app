import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart';
import '../config/string_constants.dart';

final _userRef = CollectionConstants.users;

class UserService {
  const UserService();

  // update user details
  Future<void> updateUser({
    required String uid,
    required String name,
    required String phone,
  }) async {
    try {
      await _userRef.doc(uid).update({
        Fields.name: name,
        Fields.phone: phone,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedBy: uid,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // check if user exists
  Future<bool> checkRegisteredUser(String data) async {
    try {
      final field = data.contains('@') ? Fields.email : Fields.phone;
      var res = await _userRef.where(field, isEqualTo: data).get();
      return res.docs.isNotEmpty;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // save new user information
  Future<void> saveNewUser({
    required String uid,
    required String name,
    required String email,
    required String phone,
    String? deviceToken,
  }) async {
    try {
      final map = {
        Fields.name: name,
        Fields.phone: phone,
        Fields.email: email,
        Fields.points: 50,
        Fields.status: true,
        Fields.createdAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
        Fields.deviceToken: deviceToken,
        Fields.freeDelivery: 0,
      };
      await _userRef.doc(uid).set(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // update device token
  Future<void> updateDeviceToken({
    required String token,
    required String uid,
  }) async {
    try {
      await _userRef.doc(uid).update({
        Fields.deviceToken: token,
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final userServiceProvider = Provider((_) => UserService());
