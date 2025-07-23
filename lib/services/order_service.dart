import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import '../providers/auth_provider.dart';

import '../config/extensions.dart';
import '../config/string_constants.dart';
import '../models/order_model.dart';

final _orderRef = CollectionConstants.orders.withConverter<OrderModel>(
  fromFirestore: (doc, _) => OrderModel.fromSnapshot(doc),
  toFirestore: (model, _) => model.toDocument(),
);

class OrderService {
  final String? userId;
  OrderService(this.userId);

  // 🔹 Get list of all orders (optimized with withConverter & error handling)
  Stream<List<OrderModel>> getOrdersStream() {
    try {
      if (userId == null) return Stream.empty();

      return _orderRef
          .where(FirestoreFields.userId, isEqualTo: userId)
          .orderBy(FirestoreFields.orderedDate, descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Get all orders with a voucher applied
  Stream<List<OrderModel>> getAllOrdersWithVoucherApplied() {
    try {
      if (userId == null) return Stream.empty();

      return _orderRef
          .where(FirestoreFields.userId, isEqualTo: userId)
          .where(FirestoreFields.discountVoucherId, isNull: false)
          .orderBy(FirestoreFields.orderedDate, descending: true)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
          .asBroadcastStream()
          .handleError((e) => throw e.firebaseErrorMessage);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Place order
  Future<void> placeOrder(OrderModel order) async {
    if (userId == null) throw Strings.loginBeforeProceeding;
    try {
      await _orderRef.add(order);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Get a single order
  Stream<OrderModel> getSingleOrder(String docId) {
    try {
      if (userId == null) return Stream.empty();

      return _orderRef
          .doc(docId)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) => snapshot.data()!)
          .asBroadcastStream()
          .handleError((e) => throw e.firebaseErrorMessage);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // 🔹 Get all orders (Future-based)
  Future<List<OrderModel>> getOrdersList() async {
    if (userId == null) return [];

    try {
      final res = await _orderRef
          .where(FirestoreFields.userId, isEqualTo: userId)
          .orderBy(FirestoreFields.orderedDate, descending: true)
          .limit(5)
          .get();
      return res.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return Future.error(e.firebaseErrorMessage);
    }
  }
}

final orderServiceProvider = Provider<OrderService>((ref) {
  final auth = ref.watch(authProvider);
  return OrderService(auth?.uid);
});
