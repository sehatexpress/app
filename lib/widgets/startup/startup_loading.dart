import 'package:flutter/material.dart';

import '../../config/constants.dart';
import 'startup_widget.dart';

class StartupLoading extends StatelessWidget {
  const StartupLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return StartupWidget(
      widget: Center(
        child: Image.asset(
          ImageConstant.logoAdaptive,
          height: 150,
        ),
      ),
    );
  }
}
