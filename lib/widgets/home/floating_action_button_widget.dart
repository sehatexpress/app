import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../config/extensions.dart' show ScreenTypeExtension;
import '../../config/typo_config.dart';
import '../../config/constants.dart' show ColorConstants;
import '../../providers/basket_provider.dart' show basketProvider;
import '../../screens/restaurant/restaurant_detail_screen.dart';
import '../../screens/root/basket_screen.dart';
import '../dialogs/show_change_restaurant_in_cart_dialog.dart';

class FloatingActionButtonWidget extends ConsumerWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant =
        ref.watch(basketProvider.select((state) => state.restaurant));
    final count = ref.watch(basketProvider.notifier).itemCount;
    return Container(
      height: 44,
      width: context.screenWidth - 32,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(14, 0, 0, 0),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage:
                restaurant != null ? NetworkImage(restaurant.image) : null,
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => context.push(RestaurantDetailsScreen(
              restaurantId: restaurant!.id,
            )),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  restaurant?.name ?? 'Restaurant Name',
                  style: typoConfig.textStyle.smallSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      'VIEW MENU',
                      style: typoConfig.textStyle.smallSmall.copyWith(
                        height: 1,
                        color: ColorConstants.primary,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 8,
                      color: ColorConstants.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => context.push(const BasketScreen()),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: ColorConstants.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'VIEW CART',
                  style: typoConfig.textStyle.smallSmall.copyWith(
                    fontSize: 9,
                    height: 1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$count ITEM',
                  style: typoConfig.textStyle.smallSmall.copyWith(
                    fontSize: 9,
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            height: 36,
            child: IconButton(
              onPressed: () => showChangeRestaurantInCartDialog(
                isClear: true,
                context: context,
                text: restaurant?.name ?? 'unknown',
              ).then((val) {
                if (val == true) {
                  ref.read(basketProvider.notifier).clearBasket();
                }
              }),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: ColorConstants.textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              icon: const Icon(
                Icons.close_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
