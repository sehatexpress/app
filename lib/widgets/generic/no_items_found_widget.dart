import 'package:flutter/material.dart';

import '../../config/lottie_files.dart';

class NoItemsFoundWidget extends StatelessWidget {
  const NoItemsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieFiles.noItemsFound,
    );
  }
}
