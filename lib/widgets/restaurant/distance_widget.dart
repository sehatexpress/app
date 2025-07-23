import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;

class DistanceWidget extends StatelessWidget {
  final double? fontSize;
  final String time;
  final double latitude;
  final double longitude;
  const DistanceWidget({
    super.key,
    this.fontSize = 10,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer_outlined,
              size: 12,
              color: ColorConstants.textColor,
            ),
            const SizedBox(width: 2),
            Text(
              '$time min'.toUpperCase(),
              style: typoConfig.textStyle.smallBodyBodyText1.copyWith(
                height: 1,
                color: ColorConstants.textColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
