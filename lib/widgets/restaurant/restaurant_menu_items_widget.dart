import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../config/extensions.dart' show StringExtensions;
import '../generic/loader_widget.dart';
import '../../config/enums.dart' show FilterEnum;
import '../../models/product_model.dart';
import '../../models/reataurant_model.dart';
import '../../providers/lists_provider.dart'
    show productsListByRestaurantProvider;
import '../../providers/value_provider.dart' show valueProvider;
import 'product_expansion_list_widget.dart';

class RestaurantMenuItemsWidget extends ConsumerWidget {
  final RestaurantModel restaurant;
  const RestaurantMenuItemsWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var search = ref.watch(valueProvider.select((state) => state.search));
    var filter = ref.watch(valueProvider.select((state) => state.filter));
    return ref.watch(productsListByRestaurantProvider(restaurant.id)).when(
          data: (data) {
            List<ProductModel> products = [];
            if (filter != null) {
              if (filter == FilterEnum.veg) {
                products = data.where((e) => e.type == FilterEnum.veg).toList();
              } else if (filter == FilterEnum.nonVeg) {
                products =
                    data.where((e) => e.type == FilterEnum.nonVeg).toList();
              } else if (filter == FilterEnum.bestSeller) {
                products = data.where((e) => e.bestSeller == true).toList();
              } else {
                products = data;
              }
            } else {
              products = data;
            }
            if (search != null) {
              products = data
                  .where((doc) =>
                      doc.name.toLowerCase().contains(search.toLowerCase()))
                  .toList();
            }
            List<ProductModel> bestSeller =
                products.where((e) => e.bestSeller == true).toList();
            List<ProductModel> recommended =
                products.where((e) => e.recommended == true).toList();
            var lists = groupBy(products, (ProductModel doc) => doc.category)
                .entries
                .toList();
            if (products.isNotEmpty) {
              return ListView(
                primary: false,
                shrinkWrap: true,
                children: [
                  if (bestSeller.isNotEmpty)
                    ProductsExpansionListWidget(
                      initiallyExpanded: true,
                      title: 'Best Seller',
                      restaurant: restaurant,
                      products: bestSeller,
                    ),
                  if (recommended.isNotEmpty)
                    ProductsExpansionListWidget(
                      initiallyExpanded: bestSeller.isEmpty,
                      title: 'Recommended',
                      restaurant: restaurant,
                      products: recommended,
                    ),
                  ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: lists
                        .map((e) => ProductsExpansionListWidget(
                              title: e.key.capitalize,
                              products: e.value,
                              restaurant: restaurant,
                            ))
                        .toList(),
                  ),
                ],
              );
            }
            return Center(
              child: Text('No data found'),
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
