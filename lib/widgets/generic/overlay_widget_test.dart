import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomOverlay extends HookWidget {
  final String message;

  const CustomOverlay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final overlayEntry = useState<OverlayEntry?>(null);

    void showOverlay() {
      final overlayState = Overlay.of(context);
      final entry = OverlayEntry(
        builder: (context) => Positioned(
          top: 100,
          left: 50,
          right: 50,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      overlayEntry.value?.remove();
                      overlayEntry.value = null;
                    },
                    child: const Text("Close"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      overlayEntry.value = entry;
      overlayState.insert(entry);
    }

    return ElevatedButton(
      onPressed: showOverlay,
      child: const Text("Show Overlay"),
    );
  }
}
