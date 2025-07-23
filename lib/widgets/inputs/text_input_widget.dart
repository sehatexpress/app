import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/utils.dart' show textDecorationTextStyle;

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  const TextInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
      ),
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (val) =>
          val!.isEmpty && val.length < 20 ? "Field is empty!" : null,
    );
  }
}
