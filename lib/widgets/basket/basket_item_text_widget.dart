import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;

class BasketItemTextWidget extends StatelessWidget {
  final String title;
  final String val;
  final Color color;
  const BasketItemTextWidget({
    super.key,
    required this.title,
    required this.val,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: typoConfig.textStyle.largeCaptionLabel3Bold.copyWith(
            color: color,
          ),
        ),
        Text(
          val,
          style: typoConfig.textStyle.largeCaptionLabel3Bold.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
