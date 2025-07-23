import 'package:flutter/material.dart';

import '../../config/lottie_files.dart' show LottieFiles;
import '../../config/typo_config.dart';

void voucherAppliedDialog({
  required BuildContext context,
  required double discount,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              child: LottieFiles.voucherApplied,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hurray! You saved',
                  style:
                      typoConfig.textStyle.largeCaptionLabel2Regular.copyWith(
                    height: 1,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'रु$discount',
                  style: typoConfig.textStyle.largeHeaderH1.copyWith(
                    height: 1,
                    fontSize: 40,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  Future.delayed(
    const Duration(seconds: 3),
    () => Navigator.of(context).pop(),
  );
}
