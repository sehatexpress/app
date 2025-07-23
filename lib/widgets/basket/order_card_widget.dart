import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/value_provider.dart';
import '../../config/enums.dart';
import '../../config/extensions.dart';
import '../../config/typo_config.dart';
import '../../models/order_model.dart';
import '../generic/custom_image_provider.dart';
import 'order_items_list_widget.dart';
import 'order_summary_widget.dart';

class OrderCardWidget extends ConsumerWidget {
  final OrderModel order;

  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: typoConfig.shadow.neoElevationsElevation1,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, ref),
          const Divider(height: 20),
          _buildOrderDetails(context),
          if (order.status == OrderStatusEnum.cancelled) ...[
            const Divider(height: 20),
            Text(
              'Cancellation Reason:- ${order.cancellationReason}',
              style: typoConfig.textStyle.smallSmall.copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomImageProvider(image: order.restaurantImage),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              ref.read(valueProvider.notifier).clear();
              // context.push(RestaurantDetailsScreen(
              //   restaurantId: order.restaurantId,
              // ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.restaurantName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typoConfig.textStyle.smallCaptionSubtitle1,
                ),
                Text(
                  order.restaurantStreet,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typoConfig.textStyle.smallSmall,
                ),
                Text(
                  'VIEW MENU',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typoConfig.textStyle.smallSmall.copyWith(
                    fontSize: 8,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final time = _getFormattedStatusTime();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: order.status.color,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            order.status.value.toUpperCase(),
            style: typoConfig.textStyle.smallSmall.copyWith(
              fontSize: 8,
              height: 1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            time,
            style: typoConfig.textStyle.smallSmall.copyWith(
              fontSize: 8,
              height: 1,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => SafeArea(
            child: DraggableScrollableSheet(
              minChildSize: 1.0,
              maxChildSize: 1.0,
              initialChildSize: 1.0,
              builder: (_, _) => Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: OrderSummaryWidget(order: order),
              ),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderItemsListWidget(items: order.items),
          const Divider(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Order placed on ${order.orderedDate!.formatDateTime}',
                  style: typoConfig.textStyle.smallSmall.copyWith(height: 1),
                ),
              ),
              Row(
                children: [
                  Text(
                    'रु${order.grandTotal}',
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      height: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getFormattedStatusTime() {
    switch (order.status) {
      case OrderStatusEnum.ordered:
        return order.orderedDate?.formattedTime ?? '';
      case OrderStatusEnum.accepted:
        return order.acceptedDate?.formattedTime ?? '';
      case OrderStatusEnum.confirmed:
        return order.confirmedDate?.formattedTime ?? '';
      case OrderStatusEnum.picked:
        return order.pickedDate?.formattedTime ?? '';
      case OrderStatusEnum.delivered:
        return order.deliveredDate?.formattedTime ?? '';
      case OrderStatusEnum.cancelled:
        return order.cancelledDate?.formattedTime ?? '';
    }
  }
}
