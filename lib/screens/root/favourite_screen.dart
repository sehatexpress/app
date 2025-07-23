import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../config/typo_config.dart' show typoConfig;
import '../../helper/helper.dart' show getSortedRestaurantByAvailability;
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../providers/lists_provider.dart'
    show favouriteRestaurantListProvider;
import '../../widgets/auth/auth_button_widget.dart';
import '../../widgets/generic/loader_widget.dart';
import '../../widgets/generic/no_items_found_widget.dart';
import '../../widgets/restaurant/favourite_restaurant_card.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var uid = ref.watch(authUidProvider);
    if (uid == null) {
      return const Center(
        child: AuthButtonWidget(),
      );
    }
    return ref.watch(favouriteRestaurantListProvider).when(
          data: (restaurants) {
            if (restaurants.isNotEmpty) {
              restaurants = getSortedRestaurantByAvailability(restaurants);
            }
            return restaurants.isEmpty
                ? const NoItemsFoundWidget()
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16).copyWith(bottom: 66),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) => FavouriteRestaurantCard(
                      restaurant: restaurants[i],
                    ),
                    separatorBuilder: (_, i) => const SizedBox(height: 16),
                    itemCount: restaurants.length,
                  );
          },
          error: (err, stack) => Center(
            child: Text(
              'Something went wrong.\nPlease try again',
              maxLines: 2,
              style: typoConfig.textStyle.smallCaptionSubtitle2,
            ),
          ),
          loading: () => Center(
            child: const LoaderWidget(),
          ),
        );
  }
}
