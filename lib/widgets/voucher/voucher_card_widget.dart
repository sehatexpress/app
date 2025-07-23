import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/voucher_model.dart';
import '../../providers/basket_provider.dart' show basketProvider;
import '../../providers/global_provider.dart' show globalProvider;
import '../dialogs/voucher_applied_dialog.dart';
import '../generic/dashed_line_divider_widget.dart';
import 'terms_condition_list_widget.dart';
import 'voucher_expiry_status_widget.dart';

class VoucherCardWidget extends ConsumerWidget {
  final VoucherModel voucher;
  const VoucherCardWidget({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subTotal = ref.watch(basketProvider.select((state) => state.subTotal));
    var discount = ref.watch(basketProvider.select((state) => state.discount));
    var basketVoucher =
        ref.watch(basketProvider.select((state) => state.voucher));
    return GestureDetector(
      onTap: () {
        if (voucher.minimumOrder > subTotal) {
          ref.read(globalProvider.notifier).updateMessage(
              'Please add more items worth रु${voucher.minimumOrder - subTotal} to avail this offer.');
        } else {
          ref.read(basketProvider.notifier).applyVoucher(voucher);
          Navigator.pop(context, voucher);
          Future.delayed(
            Duration.zero,
            () => voucherAppliedDialog(
              context: context,
              discount: discount,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 10,
              color: Colors.grey.shade100,
              offset: const Offset(3, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VoucherExpiryStatusWidget(
                expiryDate: voucher.expiryDate,
                selected: basketVoucher?.id == voucher.id,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    voucher.type == '%'
                        ? '${voucher.value.toStringAsFixed(0)}% off'
                        : 'रु.${voucher.value.toStringAsFixed(0)} off',
                    style: typoConfig.textStyle.smallHeaderHeadline1.copyWith(
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          voucher.code,
                          style:
                              typoConfig.textStyle.largeHeaderH5Bold.copyWith(
                            height: 1,
                            fontSize: 20,
                            color: ColorConstants.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '(UPTO रु.${voucher.upto})',
                          style: typoConfig.textStyle.largeCaptionLabel3Bold
                              .copyWith(
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'Minimum Order: रु${voucher.minimumOrder}',
                style: typoConfig.textStyle.smallSmall.copyWith(
                  fontSize: 11,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const DashedLineDividerWidget(),
              Text(
                'Terms & Conditions:',
                style: typoConfig.textStyle.largeCaptionLabel3Regular.copyWith(
                  color: ColorConstants.primary,
                ),
              ),
              TermsConditionListWidget(
                conditions: voucher.conditions,
              ),
              if (voucher.minimumOrder > subTotal)
                Text(
                  'Add more items worth रु${voucher.minimumOrder - subTotal} to apply this coupon.',
                  style: typoConfig.textStyle.smallSmall.copyWith(
                    fontSize: 11,
                    color: ColorConstants.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
