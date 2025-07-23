import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../providers/global_provider.dart' show globalProvider;
import '../../config/typo_config.dart' show typoConfig;
import '../../providers/lists_provider.dart' show citySettingsListProvider;
import '../../providers/location_provider.dart' show locationProvider;
import '../../widgets/generic/custom_image_provider.dart';
import '../../widgets/generic/loader_widget.dart';
import '../../widgets/startup/startup_widget.dart';

class SelectCityScreen extends ConsumerWidget {
  const SelectCityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final loading = ref.watch(globalProvider.select((state) => state.loading));
    final error = ref.watch(globalProvider.select((state) => state.message));
    final cities = ref.watch(citySettingsListProvider);
    if (loading || error != null) {
      return StartupWidget(
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (loading) ...[
              LoaderWidget(color: Colors.white),
              Text(
                'Please wait\nwhile fetching location',
                textAlign: TextAlign.center,
                style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                  color: Colors.white,
                ),
              ),
            ] else ...[
              Text(
                error.toString(),
                maxLines: 5,
                textAlign: TextAlign.center,
                style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref.read(globalProvider.notifier).updateMessage(null);
                  ref.read(globalProvider.notifier).updateLoading(false);
                },
                child: const Text('Try Again'),
              ),
            ],
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select City'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: cities.when(
          data: (data) => Wrap(
            spacing: 16,
            runSpacing: 16,
            children: data
                .map((e) => GestureDetector(
                      onTap: () => ref
                          .read(locationProvider.notifier)
                          .updateCity(e.id.toLowerCase()),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: (size.width / 2) - 24,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: CustomImageProvider(
                                image: e.imgURL,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                e.id,
                                style: typoConfig.textStyle.smallCaptionCaption,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Something went wrong...'),
          ),
          loading: () => Center(
            child: LoaderWidget(),
          ),
        ),
      ),
    );
  }
}
