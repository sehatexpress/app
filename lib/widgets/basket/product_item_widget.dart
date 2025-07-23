import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/enums.dart' show FilterEnum;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/product_model.dart';
import '../../providers/basket_provider.dart' show basketProvider;
import '../generic/custom_image_provider.dart';
import '../generic/custom_ratingbar_widget.dart';

class ProductItemWidget extends ConsumerWidget {
  final double? width;
  final ProductModel product;
  const ProductItemWidget({
    super.key,
    this.width,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width ?? 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            spreadRadius: 20,
            blurRadius: 20,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 90,
                child: CustomImageProvider(
                  image: product.image,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 6,
                  ),
                  decoration: BoxDecoration(
                    color: product.type == FilterEnum.veg
                        ? Colors.green
                        : ColorConstants.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    product.type == FilterEnum.veg ? 'VEG' : 'NON-VEG',
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  style: typoConfig.textStyle.smallSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'रु${product.sellingPrice}',
                            style: typoConfig.textStyle.smallSmall,
                          ),
                          Row(
                            children: [
                              CustomRatingBar(
                                itemSize: 11,
                                initial: product.averageRating ?? 0,
                                onRatingUpdate: (val) {},
                              ),
                              Text(
                                '(${product.totalUsers})',
                                style: typoConfig.textStyle.smallSmall,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          ref.read(basketProvider.notifier).addItem(product),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
