import 'package:flutter/foundation.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import '../config/extensions.dart' show FirebaseErrorHandler;
import '../config/string_constants.dart' show CollectionConstants, Fields;
import '../models/address_model.dart';
import '../models/position_model.dart';
import 'geo_position_service.dart' show geoPositionService;

final _colRef = CollectionConstants.users;

@immutable
class AddressService {
  const AddressService();

  // 🔹 Get all addresses for a user (optimized)
  Stream<List<AddressModel>> getAddress(String uid) {
    try {
      return _colRef
          .doc(uid)
          .collection('address')
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) =>
                docs.docs.map((doc) => AddressModel.fromSnapshot(doc)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Get position (extracted helper)
  Future<PositionModel> _getPosition(double latitude, double longitude) async {
    return await geoPositionService.getPosition(
      latitude: latitude,
      longitude: longitude,
    );
  }

  // 🔹 Add new address
  Future<void> addAddress({
    required String uid,
    required String name,
    required String phone,
    String? email,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    try {
      PositionModel position = await _getPosition(latitude, longitude);

      final map = {
        Fields.name: name,
        Fields.phone: phone,
        Fields.addressType: type,
        Fields.email: email,
        Fields.street: address,
        Fields.position: position.toDocument(),
        Fields.status: true,
        Fields.createdAt: DateTime.now().millisecondsSinceEpoch,
        Fields.updatedAt: null,
      };

      await _colRef.doc(uid).collection('address').add(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Update address
  Future<void> updateAddress({
    required String uid,
    required String addressId,
    required String name,
    required String phone,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    try {
      PositionModel position = await _getPosition(latitude, longitude);

      final map = {
        Fields.name: name,
        Fields.phone: phone,
        Fields.addressType: type,
        Fields.street: address,
        Fields.position: position.toDocument(),
        Fields.updatedAt: DateTime.now().millisecondsSinceEpoch,
      };

      await _colRef.doc(uid).collection('address').doc(addressId).update(map);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Validate phone number (optimized)
  Future<bool> validatephone({
    required String uid,
    required String phone,
  }) async {
    try {
      var res = await _colRef
          .doc(uid)
          .collection('address')
          .where(Fields.phone, isEqualTo: phone)
          .limit(1)
          .get();

      return res.docs.isNotEmpty;
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Delete address
  Future<void> deleteAddress({
    required String uid,
    required String addressId,
  }) async {
    try {
      await _colRef.doc(uid).collection('address').doc(addressId).delete();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final addressServiceProvider = Provider((_) => AddressService());
