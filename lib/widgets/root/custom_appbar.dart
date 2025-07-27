import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/typo_config.dart' show typoConfig;
import '../../helper/helper.dart';
import '../../providers/location_provider.dart' show locationProvider;
import 'location_selection_widget.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var city = ref.watch(locationProvider).city;
    var address = ref.watch(locationProvider).location;

    return AppBar(
      titleSpacing: 16,
      title: city != null && address != null
          ? InkWell(
              onTap: () {
                genericDialogTransitionForTopBar(
                  context: context,
                  widget: SafeArea(
                    bottom: false,
                    child: const LocationSelectionWidget(),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 24),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${address.city}\n${address.displayName}',
                      style: typoConfig.textStyle.smallCaptionSubtitle2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
