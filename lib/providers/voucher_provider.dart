import 'package:hooks_riverpod/hooks_riverpod.dart' show StreamProvider;

import '../models/voucher_model.dart';
import '../services/voucher_service.dart';
import 'auth_provider.dart' show authUidProvider;

final getVouchersListByUserProvider =
    StreamProvider.autoDispose<List<VoucherModel>>((ref) {
  final uid = ref.watch(authUidProvider);
  if (uid != null) {
    return VoucherService().getVouchersByUser(uid);
  } else {
    return Stream.value([]);
  }
});

final getVouchersListByRestaurantProvider = StreamProvider.family
    .autoDispose<List<VoucherModel>, String?>((ref, String? rid) {
  if (rid == null) return Stream.value([]);
  return VoucherService().getVouchersByRestaurant(rid);
});

final getVouchersListByCityProvider = StreamProvider.family
    .autoDispose<List<VoucherModel>, String>((ref, String city) {
  return VoucherService().getVouchersByCity(city);
});

final getGeneralVouchersListProvider =
    StreamProvider.autoDispose<List<VoucherModel>>((ref) {
  return VoucherService().getGeneralVouchers();
});
