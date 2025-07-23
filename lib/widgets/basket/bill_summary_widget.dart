import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../models/voucher_model.dart';
import '../../providers/basket_provider.dart';
import '../../providers/lists_provider.dart';
import 'basket_item_text_widget.dart';
import 'bill_summary_title_widget.dart';

class BillSummaryWidget extends ConsumerWidget {
  const BillSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    final citySettings = ref.watch(citySettingsListProvider).value ?? [];
    final city = citySettings.firstWhereOrNull(
      (e) => e.id.toLowerCase() == basket.restaurant?.city.toLowerCase(),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BillSummaryTitleWidget(
          title: 'Bill Summary',
          desc:
              'Bill details with sub total, discount, tip and delivery charges.',
          widget: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
            child: Column(
              children: [
                const SizedBox(height: 6),
                BasketItemTextWidget(
                  title: 'Item Total',
                  val: 'रु${basket.subTotalString}',
                  color: Colors.black,
                ),
                if (basket.voucher != null) ...[
                  const SizedBox(height: 6),
                  BasketItemTextWidget(
                    title: 'Coupon - (${basket.voucher!.code})',
                    val:
                        '-रु${_getVoucherValue(basket.subTotal, basket.voucher!)}',
                    color: Colors.red,
                  ),
                ],
                const SizedBox(height: 6),
                _buildDeliveryChargeRow(context, basket, city),
                if ((basket.tip ?? 0) > 0) ...[
                  const SizedBox(height: 6),
                  BasketItemTextWidget(
                    title: 'Tip',
                    val: '+रु${basket.tip}',
                    color: Colors.green,
                  ),
                ],
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Grand Total'),
                    Text('रु${basket.totalString}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryChargeRow(BuildContext context, basket, city) {
    return Row(
      children: [
        Expanded(
          child: BasketItemTextWidget(
            title: 'Delivery Charge',
            val: '+रु${basket.deliveryCharge.toStringAsFixed(2)}',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 2),
        GestureDetector(
          onTap: () => _showDeliveryInfoDialog(context, city),
          child: const Icon(
            Icons.info_outline,
            size: 18,
            color: ColorConstants.primary,
          ),
        ),
      ],
    );
  }

  void _showDeliveryInfoDialog(BuildContext context, city) {
    final baseCharge = city?.baseDeliveryCharge ?? 20;
    final baseKM = city?.baseDeliveryKM ?? 2;
    final perKM = city?.perKM ?? 20;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delivery Charge Distribution'),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: Text(
          'You\'ll get free delivery if your basket total is more than रु2499 and your delivery address is within 2km.\n\n'
          'You\'ll be charged रु$baseCharge within $baseKM km. After $baseKM km, रु$perKM will be charged per km.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  static String _getVoucherValue(double subTotal, VoucherModel voucher) {
    if (voucher.type == '%') {
      final discount = subTotal * (voucher.value / 100);
      return (discount < voucher.upto ? discount : voucher.upto)
          .toStringAsFixed(2);
    }
    return voucher.value.toStringAsFixed(2);
  }
}
