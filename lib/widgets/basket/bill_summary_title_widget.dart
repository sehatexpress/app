import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;

class BillSummaryTitleWidget extends StatelessWidget {
  final String title;
  final String desc;
  final Widget widget;
  final Color? color;
  const BillSummaryTitleWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.widget,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                height: 32,
                width: 5,
                margin: const EdgeInsets.only(right: 11),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: typoConfig.textStyle.smallCaptionLabelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      maxLines: 5,
                      style: typoConfig.textStyle.smallSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          widget,
        ],
      ),
    );
  }
}
