import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../models/voucher_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/basket_provider.dart' show basketProvider;
import '../../providers/voucher_provider.dart'
    show getVouchersListByRestaurantProvider;
import '../generic/loader_widget.dart';
import 'voucher_list_widget.dart';

class VoucherListByRestaurantsWidget extends ConsumerWidget {
  const VoucherListByRestaurantsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant =
        ref.watch(basketProvider.select((state) => state.restaurant));
    final uid = ref.watch(authUidProvider);
    return ref.watch(getVouchersListByRestaurantProvider(restaurant?.id)).when(
          data: (data) {
            List<VoucherModel> vouchers = data.isNotEmpty
                ? data.where((e) => !e.users.contains(uid)).toList()
                : [];
            return VoucherListsWidget(vouchers: vouchers);
          },
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: LoaderWidget(),
          ),
        );
  }
}
