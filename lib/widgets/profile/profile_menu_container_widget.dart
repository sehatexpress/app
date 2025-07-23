import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;

class ProfileMenuContainerWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  const ProfileMenuContainerWidget({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: typoConfig.textStyle.largeCaptionLabel2Bold.copyWith(
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          widget,
        ],
      ),
    );
  }
}
