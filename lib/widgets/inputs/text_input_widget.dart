import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/utils.dart' show textDecorationTextStyle;

class TextInputWidget extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final String hintText;
  final bool enabled;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  const TextInputWidget({
    super.key,
    this.initialValue,
    this.controller,
    required this.hintText,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(isDense: true, hintText: hintText),
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: (val) =>
          val!.isEmpty && val.length < 20 ? "Field is empty!" : null,
    );
  }
}
