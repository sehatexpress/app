import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/enums.dart' show FilterEnum;
import '../../config/extensions.dart'
    show RestaurantTimeStatus, ScreenTypeExtension, StringExtensions;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/reataurant_model.dart';
import '../../screens/restaurant/restaurant_detail_screen.dart';
import 'favourite_button_widget.dart';
import '../generic/custom_image_provider.dart';
import '../generic/custom_ratingbar_widget.dart';
import 'distance_widget.dart';
import 'restaurant_card_bottom_info_widget.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        RestaurantDetailsScreen(
          restaurantId: restaurant.id,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: typoConfig.shadow.neoElevationsElevation4,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: CustomImageProvider(
                    image: restaurant.image,
                  ),
                ),
                if (restaurant.type == FilterEnum.veg)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    color: Colors.green.withAlpha(190),
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
                          'Pure Vegetarian',
                          style: typoConfig.textStyle.smallSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                if (restaurant.isOpen == false)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      // width: 140,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      width: MediaQuery.of(context).size.width - 32,
                      color: ColorConstants.primary.withAlpha(180),
                      alignment: Alignment.center,
                      child: Text(
                        restaurant.openingTime
                            .getRestaurantStatus(restaurant.closingTime),
                        style: typoConfig.textStyle.smallSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (restaurant.isOpen == false)
                  Container(
                    height: 200,
                    color: Colors.white30,
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: typoConfig.textStyle.smallBodyBodyText1,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              restaurant.categories.join(', ').capitalize,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: typoConfig.textStyle.smallSmall.copyWith(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FavouriteButtonWidget(
                        restaurant: restaurant,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RestaurantCardBottomInfoWidget(
                        title: 'MIN ORDER',
                        widget: Text(
                          'रु.${restaurant.minimumOrder}',
                          style: typoConfig.textStyle.smallSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.textColor,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Text('DELIVERY TIME'),
                          const SizedBox(height: 3),
                          DistanceWidget(
                            time: restaurant.deliveryTime,
                            latitude: restaurant.position.geopoint.latitude,
                            longitude: restaurant.position.geopoint.longitude,
                          ),
                        ],
                      ),
                      RestaurantCardBottomInfoWidget(
                        title: 'RATING',
                        widget: CustomRatingBar(
                          color: ColorConstants.textColor,
                          initial: restaurant.averageRating,
                          onRatingUpdate: (val) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
