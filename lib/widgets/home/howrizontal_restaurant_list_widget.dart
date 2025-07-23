import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;
import '../../models/reataurant_model.dart';
import '../restaurant/restaurant_card_small_widget.dart';

class HomeHorizontalRestaurantList extends StatelessWidget {
  final String title;
  final List<RestaurantModel> restaurants;
  const HomeHorizontalRestaurantList({
    super.key,
    required this.title,
    required this.restaurants,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$title Restaurants',
            style: typoConfig.textStyle.smallBodyBodyText2,
          ),
        ),
        SizedBox(
          height: 162,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            itemBuilder: (context, index) => RestaurantCardSmallWidget(
              restaurant: restaurants[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: restaurants.length,
          ),
        ),
      ],
    );
  }
}
