import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/home/menu_list_widget.dart';
import '../../widgets/home/search_menu_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: const [
        SearchMenuWidget(),
        SizedBox(height: 12),
        MenuListWidget(),
      ],
    );
  }
}
