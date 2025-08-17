import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/dialogs/alert_dialog_model.dart';
import '../../widgets/dialogs/app_exit_dialog.dart';
import '../../providers/value_provider.dart';
import '../../widgets/root/bottom_navbar_widget.dart';
import '../../widgets/root/custom_appbar.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navIndexProvider);

    return PopScope(
      onPopInvokedWithResult: (x, _) async {
        if (index != 0) {
          ref.read(navIndexProvider.notifier).state = 0;
        } else {
          var result = await AppExitDialog()
              .present(context)
              .then((val) => val ?? false);
          if (result) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        extendBody: true,
        appBar: const CustomAppBar(),
        body: SafeArea(child: _pageItems[index]),
        bottomNavigationBar: const ButtomNavbarWidget(),
      ),
    );
  }
}

final _pageItems = const [HomeScreen(), ProfileScreen()];
