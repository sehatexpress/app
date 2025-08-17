import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/basket_provider.dart';
import '../providers/global_provider.dart';
import '../providers/location_provider.dart';
import '../screens/auth_screen.dart';
import '../services/notification_service.dart';
import 'helper/loading_screen.dart';
import 'helper/message_screen.dart';
import 'helper/no_internet_screen.dart';
import 'helper/order_placer_screen.dart';
import 'root/root_screen.dart';

class Wrapper extends HookConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider);

    // Listen to connectivity changes
    ref.listen<AsyncValue<List<ConnectivityResult>>>(connectivityProvider, (
      _,
      result,
    ) {
      final hasConnection =
          result.value?.any((r) => r != ConnectivityResult.none) ?? false;
      hasConnection
          ? NoInternetScreen.instance().hide()
          : NoInternetScreen.instance().show(context: context);
    });

    // Listen to global state for loading, messages, and order placement
    ref.listen<bool>(loadingProvider, (prev, next) {
      if (prev != next) {
        next
            ? LoadingScreen.instance().show(context: context)
            : LoadingScreen.instance().hide();
      }
    });

    ref.listen<String?>(messageProvider, (prev, next) {
      if (prev != next) {
        next != null
            ? MessageScreen.instance().show(context: context, ref: ref)
            : MessageScreen.instance().hide();
      }
    });

    ref.listen<bool>(orderPlacedProvider, (prev, next) {
      if (prev != next) {
        next == true
            ? OrderPlacedScreen.instance.show(context, ref)
            : OrderPlacedScreen.instance.hide();
      }
    });

    // Subscribe user to notifications
    ref.listen<String?>(authUidProvider, (prevUid, newUid) {
      if (newUid != null && !kIsWeb) {
        notificationService.subscribeToTopic(newUid);
      }
    });

    ref.listen(locationProvider, (prevLoc, newLoc) {
      ref.watch(basketProvider);
    });

    return user != null ? const AuthScreen() : const RootScreen();
  }
}
