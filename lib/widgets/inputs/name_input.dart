import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show
        FilteringTextInputFormatter,
        TextCapitalization,
        TextInputFormatter,
        TextInputType;

import '../../config/constants.dart' show ColorConstants;
import '../../config/utils.dart' show textDecorationTextStyle;

class NameInput extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  const NameInput({super.key, required this.controller, this.enabled = true});

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
        hintText: 'Full Name*',
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 16, right: 10),
          child: const Icon(Icons.person_rounded),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 40),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;
          return newValue.copyWith(
            text: text.replaceAllMapped(
              RegExp(r'\b\w'),
              (match) => match.group(0)!.toUpperCase(),
            ),
          );
        }),
      ],
      validator: (val) {
        if (val != null) {
          if (RegExp(
            r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
          ).hasMatch(val)) {
            return null;
          }
        }
        return 'Please enter your full name';
      },
    );
  }
}
