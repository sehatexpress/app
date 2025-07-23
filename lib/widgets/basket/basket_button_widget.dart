import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import '../../config/extensions.dart';

import '../../providers/basket_provider.dart' show basketProvider;
import '../../screens/root/basket_screen.dart';

class BasketButtonWidget extends ConsumerWidget {
  const BasketButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(basketProvider.select((state) => state.items));
    var subTotal = ref.watch(basketProvider.select((state) => state.subTotal));
    return items.isNotEmpty
        ? TextButton(
            onPressed: () => context.push(const BasketScreen()),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${items.length} Items | रु.$subTotal\n',
                children: const [
                  TextSpan(
                    text: 'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
