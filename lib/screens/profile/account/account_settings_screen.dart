import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show HookConsumerWidget, WidgetRef;

import '../../../widgets/profile/update_password_widget.dart';
import '../../../widgets/profile/update_profile_widget.dart';

class AccountSettingsScreen extends HookConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = useTabController(
      initialLength: 2,
      vsync: useSingleTickerProvider(),
    );
    return PopScope(
      onPopInvokedWithResult: (x, _) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: TabBar(
              controller: controller,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              indicator: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: [
                Tab(text: 'Account Settings'),
                Tab(text: 'Password'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: const [
            UpdateProfileWidget(),
            UpdatePasswordWidget(),
          ],
        ),
      ),
    );
  }
}
