import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../config/typo_config.dart';

class OrderBillSummaryWidget extends StatelessWidget {
  final OrderModel order;
  const OrderBillSummaryWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PriceTitleSummary(
          title: 'Item Total',
          price: order.itemTotal,
        ),
        const SizedBox(height: 4),
        _PriceTitleSummary(
          title: 'Delivery Fee',
          price: order.deliveryCharge,
        ),
        const SizedBox(height: 4),
        _PriceTitleSummary(
          title: order.discountVoucherCode != null
              ? 'Coupon - (${order.discountVoucherCode})'
              : 'Coupon',
          price: order.discount,
        ),
        const SizedBox(height: 4),
        _PriceTitleSummary(
          title: 'Delivery Partner Tip',
          price: order.tip ?? 0.0,
        ),
        const Divider(height: 20),
        _PriceTitleSummary(
          title: 'Grand Total',
          price: order.grandTotal,
          isBig: true,
        ),
      ],
    );
  }
}

class _PriceTitleSummary extends StatelessWidget {
  final String title;
  final num price;
  final bool isBig;
  const _PriceTitleSummary({
    required this.title,
    required this.price,
    this.isBig = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: typoConfig.textStyle.smallSmall.copyWith(
              height: 1,
              fontSize: isBig ? 12 : 10,
              fontWeight: isBig ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          'रु${price.toStringAsFixed(2)}',
          style: typoConfig.textStyle.smallSmall.copyWith(
            height: 1,
            fontSize: isBig ? 12 : 10,
            fontWeight: isBig ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
