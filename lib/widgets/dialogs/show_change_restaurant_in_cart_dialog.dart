import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;

Future<bool> showChangeRestaurantInCartDialog({
  required BuildContext context,
  required String text,
  bool isClear = false,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isClear ? 'Clear Basket' : 'Change Restaurant',
                  style: typoConfig.textStyle.smallBodyBodyText1,
                ),
                const SizedBox(height: 8),
                Text(
                  'You have items added in the cart from $text restaurant. Do you want to ${isClear ? 'clear' : 'replace'} items?',
                  maxLines: 5,
                  style: typoConfig.textStyle.smallCaptionSubtitle2,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ) ??
      false;
}
