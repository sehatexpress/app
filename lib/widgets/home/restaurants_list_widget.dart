import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../config/enums.dart';
import '../../config/typo_config.dart';
import '../../models/reataurant_model.dart';
import '../../providers/lists_provider.dart';
import '../generic/loader_widget.dart';
import '../restaurant/restaurant_card_widget.dart';
import 'howrizontal_restaurant_list_widget.dart';

class RestaurantListWidget extends HookConsumerWidget {
  const RestaurantListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = useState<FilterEnum?>(null);

    return ref
        .watch(restaurantListByCityProvider)
        .when(
          data: (lists) {
            // Sort open & closed restaurants
            final openRestaurants = lists.where((e) => e.isOpen).toList()
              ..sort((a, b) => a.distance.compareTo(b.distance));

            final closedRestaurants = lists.where((e) => !e.isOpen).toList()
              ..sort((a, b) => a.distance.compareTo(b.distance));

            // Merge open & closed restaurants
            var restaurants = [...openRestaurants, ...closedRestaurants];

            // Apply filter
            switch (filter.value) {
              case FilterEnum.veg:
                restaurants = restaurants
                    .where((e) => e.type == FilterEnum.veg)
                    .toList();
                break;
              case FilterEnum.nonVeg:
                restaurants = restaurants
                    .where(
                      (e) =>
                          e.type == FilterEnum.nonVeg ||
                          e.type == FilterEnum.both,
                    )
                    .toList();
                break;
              case FilterEnum.bestSeller:
                restaurants = restaurants.where((e) => e.bestSeller).toList();
                break;
              case null:
              case FilterEnum.both:
              case FilterEnum.all:
                break;
            }

            // Get new & featured restaurants
            final newRestaurants = restaurants.where((e) => e.isNew).toList();
            final featuredRestaurants = restaurants
                .where((e) => e.featured)
                .toList();

            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (newRestaurants.isNotEmpty) ...[
                  HomeHorizontalRestaurantList(
                    title: 'New',
                    restaurants: newRestaurants,
                  ),
                  const SizedBox(height: 10),
                ],
                if (featuredRestaurants.isNotEmpty) ...[
                  HomeHorizontalRestaurantList(
                    title: 'Featured',
                    restaurants: featuredRestaurants,
                  ),
                  const SizedBox(height: 10),
                ],
                _buildHeader(context, restaurants.length, filter),
                const SizedBox(height: 10),
                restaurants.isNotEmpty
                    ? _buildRestaurantList(restaurants)
                    : const Center(child: Text('No restaurant found!')),
              ],
            );
          },
          error: (err, stack) => Center(child: Text('ERROR: $err')),
          loading: () => const Center(child: LoaderWidget()),
        );
  }

  /// Builds the header section with filter button.
  Widget _buildHeader(
    BuildContext context,
    int count,
    ValueNotifier<FilterEnum?> filter,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            count > 0 ? '$count Restaurants' : 'Restaurants',
            style: typoConfig.textStyle.smallCaptionSubtitle1,
          ),
          PopupMenuButton<FilterEnum>(
            initialValue: filter.value,
            icon: const Icon(Icons.filter_list),
            itemBuilder: (_) => FilterEnum.values
                .where((e) => e != FilterEnum.both)
                .map((e) => PopupMenuItem(value: e, child: Text(e.value)))
                .toList(),
            onSelected: (x) => filter.value = x,
            onCanceled: () => filter.value = null,
          ),
        ],
      ),
    );
  }

  /// Builds the list of restaurants.
  Widget _buildRestaurantList(List<RestaurantModel> restaurants) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) => RestaurantCard(restaurant: restaurants[i]),
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemCount: restaurants.length,
    );
  }
}
