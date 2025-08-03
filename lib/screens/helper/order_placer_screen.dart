import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/lottie_files.dart' show LottieFiles;
import '../../config/typo_config.dart';
import '../../helper/controllers.dart';
import '../../providers/global_provider.dart';
import '../../widgets/generic/overlay_widget.dart';

class OrderPlacedScreen {
  OrderPlacedScreen._();
  static final OrderPlacedScreen instance = OrderPlacedScreen._();

  GenericController? _controller;

  void show( BuildContext context, WidgetRef ref) {
    _controller = _createOverlay(context, ref);
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  GenericController _createOverlay(BuildContext context, WidgetRef ref) {
    final overlayState = Overlay.of(context);
    final size = MediaQuery.of(context).size;

    late final OverlayEntry overlay;

    overlay = OverlayEntry(
      builder: (_) => OverlayWidget(
        size: size,
        center: true,
        children: [
          SizedBox(height: 160, child: LottieFiles.orderPlacedSuccessfully),
          const SizedBox(height: 20),
          Text(
            'Woohoo! Order Placed',
            style: typoConfig.textStyle.largeHeaderH5Regular.copyWith(
              color: Colors.green,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Your order has been placed successfully! You\'ll be getting a confirmation call very soon. For more details check My Orders inside profile.',
            textAlign: TextAlign.center,
            maxLines: 5,
            style: typoConfig.textStyle.smallCaptionLabelsmall.copyWith(
              color: Colors.green,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => ref.read(orderPlacedProvider.notifier).state =false,
            child: Container(
              height: 36,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                'Okk',
                style: typoConfig.textStyle.smallCaptionLabelsmall.copyWith(
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      overlayState.insert(overlay);
    });

    return GenericController(
      close: () {
        overlay.remove();
        return true;
      },
      update: (_) => true,
    );
  }
}
