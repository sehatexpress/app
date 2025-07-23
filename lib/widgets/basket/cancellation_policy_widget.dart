import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;

class CancellationPolicyWidget extends StatelessWidget {
  const CancellationPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cancellation Policy',
            style: typoConfig.textStyle.largeCaptionLabel2Bold,
          ),
          const SizedBox(height: 8),
          Text(
            '100% cancellation fee will be applicable if you decide to cancel the order anytime after order placement. Avoid cancellation as it leads to food wastage.',
            maxLines: 10,
            style: typoConfig.textStyle.smallCaptionSubtitle2,
          )
        ],
      ),
    );
  }
}
