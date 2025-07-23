import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/dialogs/alert_dialog_model.dart';
import '../../widgets/dialogs/app_exit_dialog.dart';
import '../../providers/basket_provider.dart';
import '../../providers/value_provider.dart' show valueProvider;
import '../../widgets/home/floating_action_button_widget.dart';
import '../../widgets/root/bottom_navbar_widget.dart';
import '../../widgets/root/custom_appbar.dart';
import '../profile/profile_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(valueProvider.select((state) => state.index));
    final restaurant = ref.watch(
      basketProvider.select((state) => state.restaurant),
    );

    return PopScope(
      onPopInvokedWithResult: (x, _) async {
        if (index != 0) {
          ref.read(valueProvider.notifier).changeIndex(0);
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
        body: _pageItems[index],
        floatingActionButton: restaurant != null
            ? const FloatingActionButtonWidget()
            : null,
        bottomNavigationBar: const ButtomNavbarWidget(),
      ),
    );
  }
}

final _pageItems = const [
  HomeScreen(),
  SearchScreen(),
  FavouriteScreen(),
  ProfileScreen(),
];
