import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/utils.dart' show textDecorationTextStyle;

class CustomInputWidget extends StatelessWidget {
  final String hintText;
  final IconData? leadingIcon;
  final TextEditingController controller;
  final bool enabled;
  final Widget? suffixIcon;
  const CustomInputWidget({
    super.key,
    required this.hintText,
    this.leadingIcon,
    required this.controller,
    this.enabled = true,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
        suffixIcon: suffixIcon,
      ),
      validator: (x) => x != null && x.isNotEmpty ? null : '',
    );
  }
}
