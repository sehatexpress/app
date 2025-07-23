import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;
import '../../providers/lists_provider.dart';

import '../../models/product_model.dart';
import '../../models/reataurant_model.dart';
import '../../providers/basket_provider.dart' show basketProvider;
import '../generic/loader_widget.dart';
import 'product_item_widget.dart';

class AddMoreItemWidget extends ConsumerWidget {
  final RestaurantModel restaurant;
  const AddMoreItemWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(productsListByRestaurantProvider(restaurant.id)).when(
          data: (lists) {
            final items =
                ref.watch(basketProvider.select((state) => state.items));
            List<ProductModel> products = lists;
            for (var item in items) {
              bool x =
                  products.where((e) => e.id == item.id).toList().isNotEmpty;
              if (x) {
                products.removeWhere((e) => e.id == item.id);
              }
            }
            items.map((i) => products.removeWhere((e) => e.id == i.id));
            if (products.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 0),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Add more item(${products.length})'),
                ),
                SizedBox(
                  height: 175,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => ProductItemWidget(
                      product: products[i],
                      restaurant: restaurant,
                    ),
                    separatorBuilder: (_, i) => const SizedBox(width: 16),
                    itemCount: products.length,
                  ),
                )
              ],
            );
          },
          error: (err, stack) => Center(
            child: Text(err.toString()),
          ),
          loading: () => Center(
            child: LoaderWidget(),
          ),
        );
  }
}
