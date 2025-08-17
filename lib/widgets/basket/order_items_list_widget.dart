import 'package:flutter/material.dart';

import '../../models/basket_item.dart';
import '../../config/typo_config.dart';
import 'item_tag_widget.dart';

class OrderItemsListWidget extends StatelessWidget {
  final List<BasketItem> items;

  const OrderItemsListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        final item = items[i];
        return Padding(
          padding: EdgeInsets.only(bottom: i == items.length - 1 ? 0 : 4),
          child: Row(
            children: [
              ItemTagWidget(type: item.type),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${item.quantity} x ${item.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typoConfig.textStyle.smallSmall,
                ),
              ),
              Text(
                'रु${(item.quantity * item.price).toStringAsFixed(0)}',
                style: typoConfig.textStyle.smallSmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
