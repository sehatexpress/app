import 'package:flutter/material.dart';

import '../../config/extensions.dart' show DateDifferenceInDays;
import '../../config/typo_config.dart' show typoConfig;

class VoucherExpiryStatusWidget extends StatelessWidget {
  final bool selected;
  final String expiryDate;
  const VoucherExpiryStatusWidget({
    super.key,
    required this.selected,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.timer_rounded,
                color: color.primary,
                size: 12,
              ),
              const SizedBox(width: 3),
              Text(
                '${expiryDate.split(' ').first}(${expiryDate.getDifferenceInDays()})',
                style: typoConfig.textStyle.smallSmall.copyWith(
                  height: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        if (selected)
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 12,
          ),
      ],
    );
  }
}
