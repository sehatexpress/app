import 'package:cloud_firestore/cloud_firestore.dart' show Query;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show StringExtensions;
import '../config/string_constants.dart'
    show CollectionConstants, FirestoreFields;
import '../models/voucher_model.dart';

final _ref = CollectionConstants.vouchers;

class VoucherService {
  const VoucherService();

  // Common query builder
  Query _buildBaseQuery({
    required DateTime now,
    String? userId,
    String? restaurantId,
    String? city,
    bool includeGeneral = false,
  }) {
    Query query = _ref
        .where(FirestoreFields.expiryDate,
            isGreaterThan:
                now.millisecondsSinceEpoch) // Fix: Use Timestamp format
        .where(FirestoreFields.status, isEqualTo: true);

    if (includeGeneral) {
      return query
          .where(FirestoreFields.userId, isNull: true)
          .where(FirestoreFields.restaurantId, isNull: true);
    }
    if (userId != null) {
      query = query.where(FirestoreFields.userId, isEqualTo: userId);
    }
    if (restaurantId != null) {
      query =
          query.where(FirestoreFields.restaurantId, isEqualTo: restaurantId);
    }
    if (city != null) {
      query = query.where(FirestoreFields.city, isEqualTo: city.translatedCity);
    }

    return query;
  }

  // Generic method to map Firestore snapshots to a list of VoucherModel
  Stream<List<VoucherModel>> _executeQuery(Query query) {
    return query.snapshots(includeMetadataChanges: true).map(
          (snapshot) => snapshot.docs
              .map((doc) => VoucherModel.fromSnapshot(doc))
              .toList(),
        );
  }

  // Get vouchers for user
  Stream<List<VoucherModel>> getVouchersByUser(String? uid) {
    return uid == null
        ? Stream.value([])
        : _executeQuery(_buildBaseQuery(now: DateTime.now(), userId: uid));
  }

  // Get vouchers by restaurant
  Stream<List<VoucherModel>> getVouchersByRestaurant(String rid) {
    return _executeQuery(
        _buildBaseQuery(now: DateTime.now(), restaurantId: rid));
  }

  // Get general vouchers
  Stream<List<VoucherModel>> getGeneralVouchers() {
    return _executeQuery(
        _buildBaseQuery(now: DateTime.now(), includeGeneral: true));
  }

  // Get vouchers by city
  Stream<List<VoucherModel>> getVouchersByCity(String city) {
    return _executeQuery(_buildBaseQuery(now: DateTime.now(), city: city));
  }
}

final voucherServiceProvider =
    Provider<VoucherService>((_) => VoucherService());
