import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/voucher_model.dart';
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../providers/voucher_provider.dart'
    show getGeneralVouchersListProvider;
import '../generic/loader_widget.dart';
import 'voucher_list_widget.dart';

class VoucherListByAllWidget extends ConsumerWidget {
  const VoucherListByAllWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authUidProvider);
    return ref.watch(getGeneralVouchersListProvider).when(
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
