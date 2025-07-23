import 'package:flutter/material.dart';

import '../../config/enums.dart' show FilterEnum;

class ItemTagWidget extends StatelessWidget {
  final FilterEnum type;
  const ItemTagWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = type == FilterEnum.veg ? Colors.green : Colors.red;
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 4),
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
