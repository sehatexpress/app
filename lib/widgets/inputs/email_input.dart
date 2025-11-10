import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  const EmailInput({super.key, required this.controller, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Email Address*',
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 16, right: 10),
          child: const Icon(Icons.email_rounded),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 40),
      ),
      validator: (val) {
        if (val != null) {
          if (RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
          ).hasMatch(val)) {
            return null;
          }
        }
        return 'Please enter a valid email address';
      },
    );
  }
}
