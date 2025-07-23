import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/typo_config.dart' show typoConfig;
import '../../providers/basket_provider.dart' show basketProvider;
import 'add_more_items_widget.dart';
import 'bill_summary_title_widget.dart';
import 'item_tag_widget.dart';
import 'update_cart_button_widget.dart';

class BasketItemsWidget extends ConsumerWidget {
  const BasketItemsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(basketProvider.select((state) => state.items));
    return BillSummaryTitleWidget(
      title: 'Your Order',
      desc: 'Your basket menu list',
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          items.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, i) {
                    var item = items[i];
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ItemTagWidget(type: item.type!),
                                  Expanded(
                                    child: Text(item.name),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.quantity}xरु${item.sellingPrice} = रु${item.sellingPrice * item.quantity}',
                                style: typoConfig.textStyle.smallSmall
                                    .copyWith(height: 1),
                              ),
                            ],
                          ),
                        ),
                        UpdateCartButtonWidget(
                          quantity: item.quantity,
                          remove: () => ref
                              .read(basketProvider.notifier)
                              .updateItemQuantity(item.id, quantityChange: -1),
                          add: () => ref
                              .read(basketProvider.notifier)
                              .updateItemQuantity(item.id),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: items.length,
                )
              : Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('Empty basket'),
                ),
          AddMoreItemWidget(
            restaurant:
                ref.read(basketProvider.select((state) => state.restaurant!)),
          ),
        ],
      ),
    );
  }
}
