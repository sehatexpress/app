import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/typo_config.dart' show typoConfig;
import '../../providers/basket_provider.dart' show basketProvider;

class BasketAppbarWidget extends ConsumerWidget {
  const BasketAppbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var address = ref.watch(basketProvider.select((state) => state.address));
    return address != null
        ? ListTile(
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero.copyWith(right: 16),
            title: Text(
              'Delivery to ${address.addressType?.toUpperCase() ?? 'Home'} - ${address.name}, ${address.mobile}',
              maxLines: 1,
              style: typoConfig.textStyle.smallCaptionSubtitle1.copyWith(
                height: 1,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              address.street,
              maxLines: 1,
              style: typoConfig.textStyle.smallSmall.copyWith(
                height: 1,
                color: Colors.white,
              ),
            ),
          )
        : Text(
            'My Basket',
            style: typoConfig.textStyle.largeCaptionLabel2Bold
                .copyWith(color: Colors.white),
          );
  }
}
