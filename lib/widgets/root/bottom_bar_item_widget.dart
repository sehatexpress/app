import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/bottombar_model.dart' show bottomBarLists;
import '../../providers/value_provider.dart';

class BottomBarItemWidget extends ConsumerWidget {
  final int index;
  const BottomBarItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navIndexProvider);
    var data = bottomBarLists[index];
    bool selected = selectedIndex == index;
    Color color = selected ? ColorConstants.primary : ColorConstants.textColor;
    return InkWell(
      onTap: () => ref.read(navIndexProvider.notifier).state = index,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(selected ? data.selectedIcon : data.icon, color: color),
          Text(
            data.title,
            style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
              color: color,
              fontWeight: selectedIndex == index
                  ? FontWeight.w500
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
