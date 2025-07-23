import 'package:flutter/material.dart';
import '../../config/typo_config.dart';

class RestaurantCardBottomInfoWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  const RestaurantCardBottomInfoWidget({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: typoConfig.textStyle.smallCaptionSubtitle1.copyWith(
            height: 1,
          ),
        ),
        const SizedBox(height: 3),
        widget,
      ],
    );
  }
}
