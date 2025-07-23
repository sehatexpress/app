import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/extensions.dart'
    show StringExtensions, StringTimeExtensions;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/reataurant_model.dart';
import '../generic/custom_ratingbar_widget.dart';
import 'distance_widget.dart';

class RestaurantAdditionalInfoWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantAdditionalInfoWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Opening Time: ${restaurant.openingTime.formattedTimeFromString}',
                style: typoConfig.textStyle.smallSmall,
              ),
              Text(
                'Closing Time: ${restaurant.closingTime.formattedTimeFromString}',
                style: typoConfig.textStyle.smallSmall,
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: ColorConstants.textColor,
              ),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  '${restaurant.street}, ${restaurant.city}',
                  style: typoConfig.textStyle.smallSmall,
                ),
              ),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name.capitalize,
                style: typoConfig.textStyle.largeCaptionLabel2Regular,
              ),
              const SizedBox(height: 4),
              Text(
                restaurant.categories.join(', ').capitalize,
                style: typoConfig.textStyle.smallSmall,
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'MIN ORDER',
                    style: typoConfig.textStyle.smallSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'रु${restaurant.minimumOrder}',
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      color: ColorConstants.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'DELIVERY TIME',
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  DistanceWidget(
                    fontSize: 11,
                    time: restaurant.deliveryTime,
                    latitude: restaurant.position.geopoint.latitude,
                    longitude: restaurant.position.geopoint.longitude,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'RATING',
                    style: typoConfig.textStyle.smallSmall,
                  ),
                  const SizedBox(height: 4),
                  CustomRatingBar(
                    initial: restaurant.averageRating,
                    onRatingUpdate: (val) {},
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Text(
            restaurant.description,
            style: typoConfig.textStyle.smallSmall,
          ),
        ],
      ),
    );
  }
}
