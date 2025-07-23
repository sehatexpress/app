import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/enums.dart' show FilterEnum;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/product_model.dart';
import '../../models/reataurant_model.dart';
import '../basket/add_remove_button_widget.dart';
import '../generic/custom_image_provider.dart';

class ProductCardWidget extends StatelessWidget {
  final RestaurantModel restaurant;
  final ProductModel product;
  const ProductCardWidget({
    super.key,
    required this.restaurant,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ).copyWith(bottom: 16),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      style: typoConfig.textStyle.largeCaptionLabel3Bold,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: typoConfig.textStyle.smallSmall,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 X रु.${product.sellingPrice}',
                          style: typoConfig.textStyle.smallSmall.copyWith(
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 110,
                height: 90,
                color: Colors.white,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImageProvider(
                          image: product.image,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -12,
                      child: SizedBox(
                        width: 80,
                        height: 28,
                        child: AddRemoveButtonWidget(
                          product: product,
                          restaurant: restaurant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: product.type == FilterEnum.veg
                      ? Colors.green
                      : ColorConstants.primary,
                ),
                color: Colors.white,
              ),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                    color: product.type == FilterEnum.veg
                        ? Colors.green
                        : ColorConstants.primary,
                    shape: BoxShape.circle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
