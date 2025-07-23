import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../config/typo_config.dart';
import '../../config/url_config.dart';
import '../../models/order_model.dart';
import 'order_bill_summary_widget.dart';
import 'order_items_list_widget.dart';

class OrderSummaryWidget extends ConsumerWidget {
  final OrderModel order;

  const OrderSummaryWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const Divider(height: 20),
        _buildAddressSection(
          title: order.restaurantName,
          subtitle: order.restaurantStreet,
          color: ColorConstants.primary,
          iconPath: ImageConstant.restaurant,
        ),
        const SizedBox(height: 8),
        _buildAddressSection(
          title: order.deliveryAddressPersonName,
          subtitle: order.deliveryAddressStreet,
          color: ColorConstants.textColor,
          iconPath: ImageConstant.user,
        ),
        const Divider(height: 20),
        _buildBillDetails(),
        const Divider(height: 20),
        OrderBillSummaryWidget(order: order),
        if (order.deliveryPersonId != null) ...[
          const Divider(height: 20),
          _buildAddressSection(
            title: 'Delivery Partner',
            subtitle:
                '${order.deliveryPersonName!.toUpperCase()}, ${order.deliveryPersonPhoneNumber}',
            color: Colors.green,
            iconPath: ImageConstant.delivery,
            trailing: order.status == OrderStatusEnum.picked
                ? IconButton(
                    onPressed: () =>
                        urlConfig.openCall(order.deliveryPersonPhoneNumber!),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green.withAlpha(15),
                      padding: const EdgeInsets.all(6.0),
                    ),
                    icon: const Icon(Icons.call, size: 18, color: Colors.green),
                  )
                : null,
          ),
        ],
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ORDER SUMMARY',
          style: typoConfig.textStyle.smallCaptionSubtitle1.copyWith(height: 1),
        ),
        const SizedBox(height: 2),
        Text(
          '${order.status.value.capitalize}, ${order.items.length} Items, रु${order.grandTotal.toStringAsFixed(0)}',
          style: typoConfig.textStyle.smallSmall,
        ),
      ],
    );
  }

  Widget _buildBillDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BILL DETAILS',
          style: typoConfig.textStyle.smallSmall.copyWith(
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        OrderItemsListWidget(items: order.items),
      ],
    );
  }

  Widget _buildAddressSection({
    required String title,
    required String subtitle,
    required Color color,
    required String iconPath,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withAlpha(15),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            iconPath,
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: typoConfig.textStyle.smallCaptionSubtitle1
                    .copyWith(height: 1, color: color),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: typoConfig.textStyle.smallSmall.copyWith(height: 1),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}
