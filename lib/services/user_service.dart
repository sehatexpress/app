import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler, StringExtensions;
import '../config/string_constants.dart'
    show CollectionConstants, Fields, Strings;
import '../models/user_model.dart';

final _userRef = CollectionConstants.users;

class UserService {
  const UserService();

  // get user details as a stream
  Stream<UserModel> getUserStreamDetail(String uid) {
    try {
      return _userRef
          .doc(uid)
          .snapshots(includeMetadataChanges: true)
          .map((doc) => UserModel.fromSnapshot(doc));
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get user details by email or phone
  Future<UserModel> getUserDetail(String data) async {
    try {
      final field = data.isEmail ? Fields.email : Fields.phone;
      var docs = await _userRef.where(field, isEqualTo: data).get();
      if (docs.docs.isNotEmpty) {
        return UserModel.fromSnapshot(docs.docs.first);
      } else {
        throw Strings.userNotFound;
      }
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // update user details
  Future<void> updateUser({
    required String uid,
    required String name,
    required int gender,
    required String phone,
  }) async {
    try {
      await _userRef.doc(uid).update({
        Fields.name: name,
        Fields.gender: gender,
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
    int? gender,
    required String email,
    required String phone,
    String? deviceToken,
  }) async {
    try {
      final map = {
        Fields.name: name,
        Fields.gender: gender,
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
