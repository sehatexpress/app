import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/constants.dart' show ColorConstants;
import '../../models/reataurant_model.dart';
import '../../providers/address_provider.dart' show addressProvider;
import '../../providers/auth_provider.dart' show authUidProvider;

class FavouriteButtonWidget extends ConsumerWidget {
  final RestaurantModel restaurant;
  final Color? color;
  final double padding;
  const FavouriteButtonWidget({
    super.key,
    this.color = Colors.white,
    required this.restaurant,
    this.padding = 6,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var uid = ref.watch(authUidProvider);
    return uid != null
        ? IconButton(
            onPressed: () =>
                ref.read(addressProvider.notifier).addRemoveFromFavorite(
                      likes: restaurant.likes,
                      docId: restaurant.id,
                    ),
            icon: Icon(
              restaurant.likes.contains(uid)
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: ColorConstants.primary,
            ),
          )
        : const SizedBox();
  }
}
