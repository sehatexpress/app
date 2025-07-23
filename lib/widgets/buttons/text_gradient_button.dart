import 'package:app/config/constants.dart';
import 'package:app/config/typo_config.dart';
import 'package:flutter/material.dart';

class TextGradientButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final IconData? leftIcon;
  final IconData? rightIcon;
  const TextGradientButton({
    super.key,
    required this.title,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [ColorConstants.secondary, ColorConstants.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leftIcon != null) ...[
            Icon(leftIcon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: typoConfig.textStyle.buttonsButtonSmall.copyWith(
              color: Colors.white,
            ),
          ),
          if (rightIcon != null) ...[
            const SizedBox(width: 8),
            Icon(rightIcon, color: Colors.white, size: 18),
          ],
        ],
      ),
    );
  }
}
