import 'package:flutter/material.dart';

import '../../models/voucher_model.dart';
import 'voucher_card_widget.dart';

class VoucherListsWidget extends StatelessWidget {
  final List<VoucherModel> vouchers;

  const VoucherListsWidget({super.key, required this.vouchers});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => VoucherCardWidget(
        voucher: vouchers[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: vouchers.length,
    );
  }
}
