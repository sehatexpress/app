import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/location_provider.dart';

import '../../models/voucher_model.dart';
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../providers/voucher_provider.dart'
    show getVouchersListByCityProvider;
import '../generic/loader_widget.dart';
import 'voucher_list_widget.dart';

class VoucherListByCityWidget extends ConsumerWidget {
  const VoucherListByCityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authUidProvider);
    final city = ref.watch(locationProvider.select((state) => state.city));
    return ref
        .watch(getVouchersListByCityProvider(city!))
        .when(
          data: (data) {
            List<VoucherModel> vouchers = data.isNotEmpty
                ? data.where((e) => !e.users.contains(uid)).toList()
                : [];
            return VoucherListsWidget(vouchers: vouchers);
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: LoaderWidget()),
        );
  }
}
