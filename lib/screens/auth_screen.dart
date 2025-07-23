import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'
    show HookWidget, useSingleTickerProvider, useTabController;

import '../config/typo_config.dart';
import '../widgets/auth/auth_tabbar_slider_widget.dart';
import '../widgets/auth/login_card_widget.dart';
import '../widgets/auth/register_card_widget.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tabController = useTabController(
      initialIndex: 0,
      initialLength: 2,
      vsync: useSingleTickerProvider(),
    );

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                AuthTabbarSliderWidget(
                  tabController: tabController,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      LoginCardWidget(),
                      RegisterCardWidget(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              right: 16,
              child: SizedBox(
                width: 50,
                height: 24,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: const Color.fromARGB(30, 53, 72, 93),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'SKIP',
                    style: typoConfig.textStyle.smallSmall.copyWith(
                      height: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
