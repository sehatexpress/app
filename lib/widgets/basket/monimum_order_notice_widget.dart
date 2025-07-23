import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;
import '../../providers/basket_provider.dart' show basketProvider;

class MinimumOrderNoticeWidget extends ConsumerWidget {
  const MinimumOrderNoticeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subTotal = ref.watch(basketProvider.select((state) => state.subTotal));
    var restaurant =
        ref.watch(basketProvider.select((state) => state.restaurant));
    return (subTotal < restaurant!.minimumOrder)
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 20,
                  color: ColorConstants.primary,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Note: Your basket total is less than restaurants minimum order. You\'ll be charged extra if your basket total is less than restaurant minimum order.',
                    maxLines: 5,
                    style: typoConfig.textStyle.smallCaptionSubtitle1.copyWith(
                      color: ColorConstants.primary,
                    ),
                  ),
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
