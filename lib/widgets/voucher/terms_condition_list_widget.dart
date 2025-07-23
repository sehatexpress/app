import 'package:flutter/material.dart';

import '../../config/typo_config.dart' show typoConfig;

class TermsConditionListWidget extends StatelessWidget {
  final List<String> conditions;
  const TermsConditionListWidget({
    super.key,
    required this.conditions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => Row(
        children: [
          Text(
            '-',
            style: typoConfig.textStyle.smallSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            conditions[i],
            maxLines: 5,
            style: typoConfig.textStyle.smallSmall,
          ),
        ],
      ),
      separatorBuilder: (_, i) => const SizedBox(),
      itemCount: conditions.length,
    );
  }
}
