import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show WidgetRef;

import '../../config/string_constants.dart' show Strings;
import '../../config/typo_config.dart';
import '../../helper/controllers.dart';
import '../../providers/global_provider.dart';
import '../../widgets/generic/overlay_widget.dart';

class MessageScreen {
  MessageScreen._sharedInstance();
  static final MessageScreen _shared = MessageScreen._sharedInstance();
  factory MessageScreen.instance() => _shared;

  GenericController? _controller;

  void show({required BuildContext context, required WidgetRef ref}) {
    if (_controller != null) {
      final message = ref.read(messageProvider);
      _controller!.update(message ?? Strings.error);
    } else {
      _controller = showOverlay(context: context, ref: ref);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  GenericController? showOverlay({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final message = ref.read(messageProvider);
    final overlayState = Overlay.of(context);

    final textController = StreamController<String>();
    textController.add(message ?? Strings.error);

    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? MediaQuery.of(context).size;

    final overlay = OverlayEntry(
      builder: (context) {
        return OverlayWidget(
          size: size,
          children: [
            StreamBuilder<String>(
              stream: textController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data ?? Strings.error,
                    style: typoConfig.textStyle.smallCaptionSubtitle2,
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ref.read(messageProvider.notifier).state = null;
                  hide();
                },
                child: Text(
                  Strings.dismiss,
                  style: typoConfig.textStyle.smallCaptionSubtitle1,
                ),
              ),
            ),
          ],
        );
      },
    );

    overlayState.insert(overlay);

    return GenericController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        if (!textController.isClosed) {
          textController.add(text);
        }
        return true;
      },
    );
  }
}
