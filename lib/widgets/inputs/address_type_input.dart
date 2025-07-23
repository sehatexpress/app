import 'package:flutter/material.dart';

import '../../config/enums.dart' show AddressType;
import '../../config/extensions.dart' show ScreenTypeExtension, StringExtensions;
import 'checkbox_widget.dart';

class AddressTypeInput extends StatelessWidget {
  final String? selected;
  final Function(String) onTap;
  const AddressTypeInput({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AddressType.values
          .map((e) => e.name.toLowerCase())
          .map(
            (e) => Container(
              constraints: BoxConstraints(
                maxWidth: (context.screenWidth / 4) - 20,
              ),
              child: CheckboxWidget(
                title: e.capitalize,
                value: selected == e,
                onTap: () => onTap(e),
              ),
            ),
          )
          .toList(),
    );
  }
}
