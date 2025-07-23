import 'package:flutter/material.dart';

import '../../config/lottie_files.dart';
import '../../config/typo_config.dart' show typoConfig;

class InitialSearchWidget extends StatelessWidget {
  const InitialSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          LottieFiles.search,
          Text(
            'Search your favourite restaurant',
            textAlign: TextAlign.center,
            style: typoConfig.textStyle.largeCaptionLabel3Regular,
          ),
        ],
      ),
    );
  }
}
