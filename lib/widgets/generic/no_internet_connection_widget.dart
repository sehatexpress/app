import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../../config/enums.dart';
import 'notification_card_widget.dart';

final connectivityProvider = StreamProvider<List<ConnectivityResult>>(
  (_) => Connectivity().onConnectivityChanged,
);
final overlayVisibilityProvider = StateProvider<bool>((_) => false);
final overlayMessageProvider = StateProvider<NotificationEnum?>((_) => null);

class NoInternetConnectionOverlayManager extends ConsumerWidget {
  const NoInternetConnectionOverlayManager({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetStatus = ref.watch(connectivityProvider);

    internetStatus.whenData((status) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (status.first == ConnectivityResult.none) {
          ref.read(overlayMessageProvider.notifier).state =
              NotificationEnum.error;
          ref.read(overlayVisibilityProvider.notifier).state = true;
        } else {
          ref.read(overlayMessageProvider.notifier).state =
              NotificationEnum.success;
          Future.delayed(const Duration(seconds: 3), () {
            final currentStatus = ref.read(connectivityProvider).value?.first;
            if (currentStatus != ConnectivityResult.none) {
              ref.read(overlayVisibilityProvider.notifier).state = false;
            }
          });
        }
      });
    });

    final showOverlay = ref.watch(overlayVisibilityProvider);
    final messageType = ref.watch(overlayMessageProvider);

    return Stack(
      children: [
        child,
        if (showOverlay && messageType != null)
          _buildOverlay(context, messageType),
      ],
    );
  }

  Widget _buildOverlay(BuildContext context, NotificationEnum type) {
    final isOffline = type == NotificationEnum.error;

    return Positioned(
      top: 60,
      left: 16,
      right: 16,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: NotificationCardWidget(
            type: type,
            title: isOffline ? 'You are offline' : 'You are back online!',
            body: isOffline
                ? 'Please check your internet connection and try again.'
                : 'Your internet connection has been restored. Please continue.',
          ),
        ),
      ),
    );
  }
}
