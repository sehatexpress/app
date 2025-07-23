import 'package:flutter/material.dart';
import '../../config/typo_config.dart';

import '../../models/product_model.dart';
import '../../models/reataurant_model.dart';
import 'product_card_widget.dart';

class ProductsExpansionListWidget extends StatelessWidget {
  final bool initiallyExpanded;
  final String title;
  final RestaurantModel restaurant;
  final List<ProductModel> products;
  const ProductsExpansionListWidget({
    super.key,
    this.initiallyExpanded = false,
    required this.title,
    required this.restaurant,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      initiallyExpanded: initiallyExpanded,
      title: Text(
        '$title(${products.length})',
        style: typoConfig.textStyle.largeCaptionLabel3Bold,
      ),
      children: products.isNotEmpty
          ? products
              .map((e) => ProductCardWidget(
                    product: e,
                    restaurant: restaurant,
                  ))
              .toList()
          : [],
    );
  }
}
