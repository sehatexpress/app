import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/utils.dart' show textDecorationTextStyle;

class MessageInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const MessageInputWidget({
    super.key,
    required this.controller,
    this.hintText = 'Write your query...',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 10,
      maxLines: 10,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
      ),
      controller: controller,
      keyboardType: TextInputType.text,
      validator: (val) =>
          val!.isEmpty && val.length < 20 ? "Please write your query..." : null,
    );
  }
}
