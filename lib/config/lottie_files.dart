import 'package:flutter/foundation.dart' show kIsWeb, immutable;
import 'package:flutter/material.dart'
    show BoxFit, Center, Colors, Icon, Icons, SizedBox, Text, Widget;
import 'package:lottie/lottie.dart';

@immutable
class LottieFiles {
  static Widget logImage = LottieBuilder.asset(
    'assets/lottie/toeato_auth.json',
    fit: BoxFit.fitHeight,
  );

  static Widget imageLoader = kIsWeb
      ? const Center(
          child: Icon(Icons.image_rounded),
        )
      : LottieBuilder.asset(
          'assets/lottie/image_loader.json',
        );
  static Widget allowLocation = LottieBuilder.asset(
    'assets/lottie/allow_location.json',
    fit: BoxFit.fitHeight,
  );
  static Widget orderPlacedSuccessfully = kIsWeb
      ? const Center(
          child: Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 40,
          ),
        )
      : LottieBuilder.asset(
          'assets/lottie/order_placed_successfully.json',
        );
  static Widget voucherApplied = kIsWeb
      ? const Center(
          child: Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 30,
          ),
        )
      : LottieBuilder.asset(
          'assets/lottie/voucher_applied.json',
        );

  static Widget search = kIsWeb
      ? const SizedBox()
      : LottieBuilder.asset(
          'assets/lottie/search_restaurant.json',
        );

  static Widget emptyCart = kIsWeb
      ? const SizedBox()
      : LottieBuilder.asset(
          'assets/lottie/empty_cart.json',
        );

  static Widget noItemsFound = kIsWeb
      ? const Text('No items found')
      : LottieBuilder.asset(
          'assets/lottie/no_items_found.json',
        );

  const LottieFiles._();
}
