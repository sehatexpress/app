import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helper/helper.dart';
import '../providers/auth_provider.dart';
import '../providers/basket_provider.dart';
import '../providers/global_provider.dart';
import '../providers/location_provider.dart';
import '../providers/remote_config_provider.dart';
import '../screens/auth_screen.dart';
import '../services/notification_service.dart';
import '../services/remote_config_service.dart';
import '../states/global_state.dart';
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

    /// check for update & force user to update
    useEffect(() {
      Future.microtask(() async {
        final remoteConfig = await ref.read(remoteConfigProvider.future);
        final res = await ref.read(remoteConfigServiceProvider).getAppInfo();
        final forceUpdateVersion = remoteConfig.minimumVersion;
        final title = remoteConfig.updateTitle;
        final body = remoteConfig.updateBody;
        if (isVersionOutdated(res.version, forceUpdateVersion)) {
          showUpdateDialog(context, title, body);
        }
      });
      return null;
    }, const []);

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
    ref.listen<GlobalState>(globalProvider, (prev, next) {
      if (prev?.loading != next.loading) {
        next.loading
            ? LoadingScreen.instance().show(context: context)
            : LoadingScreen.instance().hide();
      }

      if (prev?.message != next.message) {
        next.message != null
            ? MessageScreen.instance().show(
                context: context,
                global: next,
                ref: ref,
              )
            : MessageScreen.instance().hide();
      }

      if (prev?.orderPlaced != next.orderPlaced) {
        next.orderPlaced == true
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
