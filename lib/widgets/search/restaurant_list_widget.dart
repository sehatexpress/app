import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../config/typo_config.dart' show typoConfig;
import '../../helper/helper.dart' show getSortedRestaurantByAvailability;
import '../../models/reataurant_model.dart';
import '../../providers/lists_provider.dart' show restaurantListByCityProvider;
import '../generic/loader_widget.dart';
import '../generic/no_items_found_widget.dart';
import '../restaurant/favourite_restaurant_card.dart';

class SearchViewRestaurantWidget extends ConsumerWidget {
  final String? search;
  const SearchViewRestaurantWidget({super.key, this.search});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(restaurantListByCityProvider).when(
          data: (lists) {
            if (lists.isNotEmpty) {
              List<RestaurantModel> restaurants = search != null
                  ? lists
                      .where((doc) =>
                          doc.name.toLowerCase().contains(search!.toLowerCase()))
                      .toList()
                  : [];
              if (restaurants.isNotEmpty) {
                restaurants = getSortedRestaurantByAvailability(restaurants);
              }
              return restaurants.isEmpty
                  ? const NoItemsFoundWidget()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            FavouriteRestaurantCard(
                          restaurant: restaurants[index],
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: restaurants.length,
                      ),
                    );
            }
            return Center(
              child: Text(
                'No restaurant found',
                textAlign: TextAlign.center,
                style: typoConfig.textStyle.largeCaptionLabel3Regular,
              ),
            );
          },
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => Center(
            child: LoaderWidget(),
          ),
        );
  }
}
