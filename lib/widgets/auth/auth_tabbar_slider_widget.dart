import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../config/lottie_files.dart';

class AuthTabbarSliderWidget extends StatelessWidget {
  final TabController tabController;
  const AuthTabbarSliderWidget({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          if (!kIsWeb) ...[
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: LottieFiles.logImage,
            ),
            const SizedBox(height: 8),
          ],
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            tabs:
                ['Login', 'Register'].map((e) => Tab(child: Text(e))).toList(),
          ),
        ],
      ),
    );
  }
}
