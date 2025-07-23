import 'package:flutter/material.dart';

import 'checkbox_widget.dart';
import '../../models/gender_model.dart';

class SelectGenderWidget extends StatelessWidget {
  final int gender;
  final Function(int) onTap;
  const SelectGenderWidget({
    super.key,
    required this.gender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: genders
          .map((e) => CheckboxWidget(
                title: e.title,
                value: gender == e.value ? true : false,
                onTap: () => onTap(e.value),
              ))
          .toList(),
    );
  }
}
