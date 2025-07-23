import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import 'favourite_button_widget.dart';
import '../../config/constants.dart' show ColorConstants;
import '../../config/enums.dart' show FilterEnum;
import '../../config/extensions.dart'
    show RestaurantTimeStatus, ScreenTypeExtension, StringExtensions;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/reataurant_model.dart';
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../screens/restaurant/restaurant_detail_screen.dart';
import '../generic/custom_image_provider.dart';
import '../generic/custom_ratingbar_widget.dart';
import 'distance_widget.dart';

class FavouriteRestaurantCard extends ConsumerWidget {
  final RestaurantModel restaurant;
  const FavouriteRestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authUidProvider);
    return InkWell(
      onTap: () => context.push(RestaurantDetailsScreen(
        restaurantId: restaurant.id,
      )),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: typoConfig.shadow.neoElevationsElevation2,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CustomImageProvider(
                    image: restaurant.image,
                  ),
                ),
                if (restaurant.type == FilterEnum.veg)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(190),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.energy_savings_leaf,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'PURE VEGETARIAN',
                            style: typoConfig.textStyle.smallSmall
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                if (restaurant.isOpen == false)
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: ColorConstants.primary.withAlpha(180),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        restaurant.openingTime
                            .getRestaurantStatus(restaurant.closingTime),
                        style: typoConfig.textStyle.smallSmall
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                if (restaurant.isOpen == false)
                  Container(
                    height: 100,
                    width: 140,
                    color: Colors.white30,
                  ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name.capitalize,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: typoConfig.textStyle.largeCaptionLabel2Bold
                                  .copyWith(
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              restaurant.categories.join(', ').capitalize,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: typoConfig.textStyle.smallSmall,
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomRatingBar(
                              initial: restaurant.averageRating,
                              onRatingUpdate: (val) {},
                            ),
                            DistanceWidget(
                              time: restaurant.deliveryTime,
                              latitude: restaurant.position.geopoint.latitude,
                              longitude: restaurant.position.geopoint.longitude,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (userId != null)
                    Positioned(
                      top: 4,
                      right: 8,
                      child: FavouriteButtonWidget(
                        restaurant: restaurant,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
