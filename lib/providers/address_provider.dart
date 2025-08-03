import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/string_constants.dart' show Strings;
import '../services/address_service.dart';
import 'auth_provider.dart';
import 'global_provider.dart';

class AddressStateNotifier extends StateNotifier<void> {
  final Ref ref;
  AddressStateNotifier(this.ref) : super(null); // Initial state: Not loading

  // 🔹 Helper function to reduce redundancy in async calls
  Future<void> _performSafeOperation(
      Future<void> Function(String uid) operation) async {
    try {
      var uid = ref.read(authUidProvider);
      if (uid == null) throw Strings.loginBeforeProceeding;

      ref.read(loadingProvider.notifier).state =true;
      await operation(uid);
    } catch (e) {
      ref.read(messageProvider.notifier).state = e.toString();
    } finally {
      ref.read(loadingProvider.notifier).state =false;
    }
  }

  // 🔹 Add address
  Future<void> addAddress({
    required String name,
    required String mobile,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    await _performSafeOperation((uid) {
      return ref.read(addressServiceProvider).addAddress(
            uid: uid,
            name: name,
            mobile: mobile,
            type: type,
            address: address,
            latitude: latitude,
            longitude: longitude,
          );
    });
  }

  // 🔹 Update address
  Future<void> updateAddress({
    required String addressId,
    required String name,
    required String mobile,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    await _performSafeOperation((uid) {
      return ref.read(addressServiceProvider).updateAddress(
            addressId: addressId,
            uid: uid,
            name: name,
            mobile: mobile,
            type: type,
            address: address,
            latitude: latitude,
            longitude: longitude,
          );
    });
  }

  // 🔹 Delete address
  Future<void> deleteAddress(String id) async {
    await _performSafeOperation((uid) {
      return ref.read(addressServiceProvider).deleteAddress(
            uid: uid,
            addressId: id,
          );
    });
  }
}

// 🔹 StateNotifierProvider with `bool` state (tracks loading status)
final addressProvider = StateNotifierProvider<AddressStateNotifier, void>(
  (ref) => AddressStateNotifier(ref),
);
