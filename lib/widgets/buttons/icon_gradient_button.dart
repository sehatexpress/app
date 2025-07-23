import 'package:app/config/constants.dart';
import 'package:flutter/material.dart';

class IconGradientButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Function()? onPressed;

  const IconGradientButton({
    super.key,
    required this.icon,
    this.size = 40,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [ColorConstants.secondary, ColorConstants.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
