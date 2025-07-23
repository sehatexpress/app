import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/enums.dart' show FilterEnum;
import '../../config/extensions.dart'
    show RestaurantTimeStatus, ScreenTypeExtension;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/reataurant_model.dart';
import '../../screens/restaurant/restaurant_detail_screen.dart';
import 'favourite_button_widget.dart';
import '../generic/custom_image_provider.dart';
import '../generic/custom_ratingbar_widget.dart';
import 'distance_widget.dart';

class RestaurantCardSmallWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  final double width;
  const RestaurantCardSmallWidget({
    super.key,
    required this.restaurant,
    this.width = 170,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(RestaurantDetailsScreen(
        restaurantId: restaurant.id,
      )),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: typoConfig.shadow.neoElevationsElevation2,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  child: CustomImageProvider(
                    image: restaurant.image,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: restaurant.type == FilterEnum.veg
                        ? Colors.green.withAlpha(190)
                        : Colors.black.withAlpha(127),
                    padding: const EdgeInsets.all(4),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (restaurant.type == FilterEnum.veg)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.energy_savings_leaf,
                                size: 10,
                                color: Colors.white,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Pure Veg',
                                style: typoConfig.textStyle.smallSmall,
                              )
                            ],
                          )
                        else
                          const SizedBox(),
                        CustomRatingBar(
                          itemSize: 11,
                          initial: restaurant.averageRating,
                          isWhite: true,
                          onRatingUpdate: (val) {},
                        )
                      ],
                    ),
                  ),
                ),
                if (restaurant.isOpen == false) ...[
                  Positioned(
                    top: 0,
                    child: Container(
                      // width: 140,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.primary.withAlpha(180),
                      ),
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
                  Container(
                    height: 100,
                    color: Colors.white30,
                  ),
                ],
                Positioned(
                  top: -4,
                  right: 0,
                  child: FavouriteButtonWidget(
                    restaurant: restaurant,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: typoConfig.textStyle.smallCaptionSubtitle1.copyWith(
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DistanceWidget(
                        time: restaurant.deliveryTime,
                        latitude: restaurant.position.geopoint.latitude,
                        longitude: restaurant.position.geopoint.longitude,
                      ),
                      Text(
                        'Min रु.${restaurant.minimumOrder}'.toUpperCase(),
                        style: typoConfig.textStyle.smallSmall.copyWith(
                          height: 1,
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
