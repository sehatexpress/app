import 'package:flutter/material.dart';
import '../../config/extensions.dart';

import '../../config/typo_config.dart' show typoConfig;
import '../../models/category_model.dart';
import '../../screens/restaurant/filtered_restuarant_screen.dart';
import '../generic/custom_image_provider.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(FilteredRestaurantScreen(
        category: category.name,
      )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomImageProvider(image: category.image),
          ),
          const SizedBox(height: 4),
          Text(
            category.name.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: typoConfig.textStyle.smallSmall.copyWith(
              height: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
