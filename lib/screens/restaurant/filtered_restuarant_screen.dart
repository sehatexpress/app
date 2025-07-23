import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../config/extensions.dart' show StringExtensions;
import '../../helper/helper.dart' show getSortedRestaurantByAvailability;
import '../../models/reataurant_model.dart';
import '../../providers/lists_provider.dart' show restaurantListByCityProvider;
import '../../widgets/basket/basket_button_widget.dart';
import '../../widgets/generic/loader_widget.dart';
import '../../widgets/restaurant/favourite_restaurant_card.dart';

class FilteredRestaurantScreen extends ConsumerWidget {
  final String category;
  const FilteredRestaurantScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.capitalize),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: const BasketButtonWidget(),
      body: ref.watch(restaurantListByCityProvider).when(
            data: (restaurants) {
              List<RestaurantModel> lists = restaurants
                  .where((e) => e.categories.contains(category))
                  .toList();
              if (lists.isNotEmpty) {
                lists = getSortedRestaurantByAvailability(lists);
              }
              return lists.isEmpty
                  ? const Center(
                      child: Text('No restaurant found!'),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${lists.length} restaurants found',
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            itemBuilder: (context, index) =>
                                FavouriteRestaurantCard(
                              restaurant: lists[index],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemCount: lists.length,
                          ),
                        ),
                      ],
                    );
            },
            error: (err, stack) => const Text('ERROR'),
            loading: () => Center(
              child: LoaderWidget(),
            ),
          ),
    );
  }
}
