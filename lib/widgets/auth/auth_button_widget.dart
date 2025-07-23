import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/typo_config.dart';
import '../../screens/auth_screen.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        'Login',
        style: typoConfig.textStyle.largeCaptionLabel3Bold
            .copyWith(color: Colors.white),
      ),
      icon: Icon(
        Icons.login_rounded,
        color: Colors.white,
      ),
      style: TextButton.styleFrom(
        backgroundColor: ColorConstants.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
          fullscreenDialog: true,
        ),
      ),
    );
  }
}
