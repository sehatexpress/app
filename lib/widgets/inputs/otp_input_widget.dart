import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../config/utils.dart';

class OTPInputWidget extends HookWidget {
  final void Function(String otp) onSubmit;

  const OTPInputWidget({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    const length = 6;
    final controllers = useMemoized(
      () => List.generate(length, (_) => TextEditingController()),
      [],
    );
    final focusNodes = useMemoized(
      () => List.generate(length, (_) => FocusNode()),
      [],
    );

    useEffect(() {
      focusNodes[0].requestFocus();
      return () {
        for (final c in controllers) {
          c.dispose();
        }
        for (final f in focusNodes) {
          f.dispose();
        }
      };
    }, []);

    void handleInput(String value, int index) {
      if (value.length == 1) {
        if (index < length - 1) {
          focusNodes[index + 1].requestFocus();
        } else {
          focusNodes[index].unfocus();
          final otp = controllers.map((c) => c.text).join();
          onSubmit(otp);
        }
      }
    }

    void handleKey(RawKeyEvent event, int index) {
      if (event.logicalKey.keyLabel == 'Backspace' &&
          controllers[index].text.isEmpty &&
          index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        return SizedBox(
          width: (context.screenWidth - 100) / length,
          child: RawKeyboardListener(
            focusNode: useFocusNode(),
            onKey: (event) => handleKey(event, index),
            child: TextFormField(
              maxLength: 1,
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                counterText: '',
                hintText: '0',
                border: OutlineInputBorder(),
              ),
              style: textDecorationTextStyle(ColorConstants.textColor),
              onChanged: (value) => handleInput(value, index),
            ),
          ),
        );
      }),
    );
  }
}
