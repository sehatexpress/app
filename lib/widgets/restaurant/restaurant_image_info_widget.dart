import 'dart:ui';

import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;
import '../../models/reataurant_model.dart';
import 'favourite_button_widget.dart';
import '../generic/custom_image_provider.dart';
import 'timer_widget.dart';

class RestaurantImageInfoWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantImageInfoWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    var splited = restaurant.openingTime.split(':');
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          child: CustomImageProvider(
            image: restaurant.image,
          ),
        ),
        if (!restaurant.isOpen || restaurant.isClosed)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (restaurant.isOpen == false) ...[
                      Text(
                        'OPENS IN',
                        style: typoConfig.textStyle.largeHeaderH3Bold.copyWith(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TimerWidget(
                        hour: int.parse(splited[0]),
                        minute: int.parse(splited[1]),
                      ),
                    ],
                    if (restaurant.isClosed)
                      Text(
                        'The restaurant is closed now!',
                        style: typoConfig.textStyle.largeHeaderH3Bold.copyWith(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        Positioned(
          right: 12,
          top: 12,
          child: FavouriteButtonWidget(
            padding: 10,
            restaurant: restaurant,
          ),
        ),
      ],
    );
  }
}
