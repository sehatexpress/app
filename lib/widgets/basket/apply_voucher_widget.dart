import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/constants.dart' show ColorConstants;
import '../../providers/basket_provider.dart' show basketProvider;
import 'apply_voucher_button_widget.dart';

class ApplyVoucherWidget extends ConsumerWidget {
  const ApplyVoucherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucher = ref.watch(basketProvider.select((state) => state.voucher));
    final discount =
        ref.watch(basketProvider.select((state) => state.discount));
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: ColorConstants.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_outlined,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (voucher != null)
                  Text(
                    voucher.code,
                    style: TextStyle(
                      color: ColorConstants.primary,
                    ),
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        voucher == null
                            ? 'Having any voucher? '
                            : 'You\'ve successfully saved रु.$discount. ',
                        maxLines: 2,
                      ),
                    ),
                    const ApplyVoucherButton()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
