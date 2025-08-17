import 'package:flutter/material.dart';

import '../../widgets/home/menu_list_widget.dart';
import '../../widgets/home/search_menu_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
