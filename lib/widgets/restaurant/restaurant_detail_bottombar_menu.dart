import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import '../../config/extensions.dart';

import '../../config/typo_config.dart' show typoConfig;
import '../../providers/basket_provider.dart' show basketProvider;
import '../../screens/root/basket_screen.dart';

class RestaurantBottomAppbarMenu extends ConsumerWidget {
  const RestaurantBottomAppbarMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(basketProvider.select((state) => state.items));
    final restaurant =
        ref.watch(basketProvider.select((state) => state.restaurant));
    final subTotal =
        ref.watch(basketProvider.select((state) => state.subTotal));
    if (items.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.all(16),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${items.length} Items | रु.$subTotal',
                    style: typoConfig.textStyle.smallCaptionSubtitle1,
                  ),
                  Text(
                    restaurant!.name,
                    style: typoConfig.textStyle.smallCaptionSubtitle1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextButton.icon(
                icon: Icon(Icons.shopping_basket),
                onPressed: () => context.push(const BasketScreen()),
                label: Text('Basket'),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
