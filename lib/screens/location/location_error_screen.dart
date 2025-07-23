import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/string_constants.dart' show LocationStrings;
import '../../config/typo_config.dart';
import '../../providers/location_provider.dart' show locationProvider;

class LocationErrorScreen extends ConsumerWidget {
  const LocationErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Error'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              LocationStrings.enablelocation,
              style: typoConfig.textStyle.smallHeaderHeadline6,
            ),
            const SizedBox(height: 10),
            Text(
              LocationStrings.genericMessage,
              style: typoConfig.textStyle.smallCaptionLabelsmall.copyWith(
                color: ColorConstants.textColor.withAlpha(190),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                ref.read(locationProvider.notifier).requestLocation();
              },
              child: Text(
                'Retry',
                style: typoConfig.textStyle.largeCaptionLabel3Bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
