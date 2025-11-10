import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/utils.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const PasswordInput({
    super.key,
    required this.controller,
    this.hintText = 'Enter Password*',
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hide,
      autocorrect: false,
      enableSuggestions: false,
      style: textDecorationTextStyle(ColorConstants.textColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 16, right: 10),
          child: const Icon(Icons.lock_rounded),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 40),
        suffixIconConstraints: const BoxConstraints(maxHeight: 40),
        suffixIcon: Container(
          margin: const EdgeInsets.only(left: 10, right: 16),
          child: GestureDetector(
            onTap: () {
              setState(() => hide = !hide);
            },
            child: Icon(
              !hide ? Icons.visibility_off : Icons.visibility,
              size: 20,
              color: ColorConstants.primary,
            ),
          ),
        ),
      ),
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      validator: (val) =>
          val!.length < 6 ? 'Please enter 6 digit password' : null,
    );
  }
}
