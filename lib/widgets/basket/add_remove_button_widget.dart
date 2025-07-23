import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/constants.dart';
import '../../config/typo_config.dart';
import '../../models/product_model.dart';
import '../../models/reataurant_model.dart';
import '../../providers/basket_provider.dart' show basketProvider;
import '../dialogs/show_change_restaurant_in_cart_dialog.dart';
import 'update_cart_button_widget.dart';

class AddRemoveButtonWidget extends ConsumerWidget {
  final ProductModel product;
  final RestaurantModel restaurant;
  const AddRemoveButtonWidget({
    super.key,
    required this.product,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(basketProvider.select((state) => state.items));
    final basketRestaurant =
        ref.watch(basketProvider.select((state) => state.restaurant));
    final exist = items.where((e) => e.id == product.id);
    if (exist.isNotEmpty) {
      var item = items.firstWhere((element) => element.id == product.id);
      return UpdateCartButtonWidget(
        height: 32,
        width: 100,
        color: Colors.white,
        quantity: item.quantity,
        remove: () => ref
            .read(basketProvider.notifier)
            .updateItemQuantity(item.id, quantityChange: -1),
        add: () =>
            ref.read(basketProvider.notifier).updateItemQuantity(item.id),
      );
    } else {
      return ElevatedButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () async {
          if (basketRestaurant == null) {
            ref.read(basketProvider.notifier).init(restaurant, product);
          } else if (restaurant != basketRestaurant) {
            await showChangeRestaurantInCartDialog(
              context: context,
              text: restaurant.name,
            ).then((val) {
              if (val == true) {
                ref.read(basketProvider.notifier).init(restaurant, product);
              }
            });
          } else {
            ref.read(basketProvider.notifier).addItem(product);
          }
        },
        child: Text(
          'ADD',
          style: typoConfig.textStyle.smallSmall.copyWith(
            height: 1,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primary,
          ),
        ),
      );
    }
  }
}
