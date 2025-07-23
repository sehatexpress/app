import 'package:flutter/material.dart';
import '../../config/typo_config.dart';

import '../../config/constants.dart';

class UpdateCartButtonWidget extends StatelessWidget {
  const UpdateCartButtonWidget({
    super.key,
    this.height = 30,
    this.width = 86,
    this.color,
    required this.quantity,
    required this.remove,
    required this.add,
  });
  final double height;
  final double width;
  final Color? color;
  final int quantity;
  final Function() remove;
  final Function() add;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? ColorConstants.primary.withAlpha(25),
        border: Border.all(
          color: ColorConstants.primary,
          width: .5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IconButton(
              onPressed: remove,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(
                Icons.remove,
                size: 16,
                color: ColorConstants.primary,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: typoConfig.textStyle.smallSmall.copyWith(
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: add,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(
                Icons.add,
                size: 16,
                color: ColorConstants.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
