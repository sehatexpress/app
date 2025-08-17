import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/bottombar_model.dart';
import '../../providers/value_provider.dart';

class ButtomNavbarWidget extends ConsumerWidget {
  const ButtomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => ref.read(navIndexProvider.notifier).state = i,
      items: bottomBarLists
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.title,
              activeIcon: Icon(e.selectedIcon),
            ),
          )
          .toList(),
    );
  }
}
