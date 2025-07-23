import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../providers/global_provider.dart' show globalProvider;
import '../../config/string_constants.dart' show Strings;
import '../../config/constants.dart' show ColorConstants;
import '../../config/extensions.dart'
    show RestaurantTimeStatusBool, StringExtensions;
import '../../config/typo_config.dart' show typoConfig;
import '../../models/order_model.dart';
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../providers/basket_provider.dart' show basketProvider;
import '../../providers/lists_provider.dart' show userDetailProvider;
import '../auth/auth_button_widget.dart';
import 'show_address_list_dialog.dart';

class PlaceOrderButtonWidget extends ConsumerWidget {
  const PlaceOrderButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authUidProvider);
    final userDetail = ref.watch(userDetailProvider).value;
    var address = ref.watch(basketProvider.select((state) => state.address));
    var restaurant =
        ref.watch(basketProvider.select((state) => state.restaurant));
    var subTotal = ref.watch(basketProvider.select((state) => state.subTotal));
    var subTotalString =
        ref.watch(basketProvider.select((state) => state.subTotalString));
    var deliveryDistance =
        ref.watch(basketProvider.select((state) => state.deliveryDistance));
    var items = ref.watch(basketProvider.select((state) => state.items));
    var totalString =
        ref.watch(basketProvider.select((state) => state.totalString));
    var deliveryCharge =
        ref.watch(basketProvider.select((state) => state.deliveryCharge));
    var discount = ref.watch(basketProvider.select((state) => state.discount));
    var voucher = ref.watch(basketProvider.select((state) => state.voucher));
    var tip = ref.watch(basketProvider.select((state) => state.tip));
    var defaultConfirmed =
        ref.watch(basketProvider.select((state) => state.defaultConfirmed));
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uid != null
              ? address != null
                  ? Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: ColorConstants.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${address.name.capitalize}, ${address.mobile}',
                                    style: typoConfig
                                        .textStyle.largeCaptionLabel3Bold
                                        .copyWith(
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    address.street.capitalize,
                                    style: typoConfig
                                        .textStyle.smallCaptionSubtitle2
                                        .copyWith(
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => showAddressList(context),
                              icon: Icon(Icons.change_circle),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(basketProvider.notifier)
                                  .useCurrentLocation();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: Text(
                                'Use Current Address',
                                style: typoConfig
                                    .textStyle.smallCaptionSubtitle1
                                    .copyWith(
                                  height: 1,
                                  color: ColorConstants.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 32,
                          color: ColorConstants.textColor.withAlpha(50),
                          width: 2,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => showAddressList(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Select Delivery Address',
                                style: typoConfig
                                    .textStyle.smallCaptionSubtitle1
                                    .copyWith(
                                  height: 1,
                                  color: ColorConstants.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  child: const AuthButtonWidget(),
                ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total रु.$subTotalString',
                        style: typoConfig.textStyle.largeCaptionLabel3Bold,
                      ),
                      Text(
                        'Cash On Delivery',
                        style: typoConfig.textStyle.smallSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: ElevatedButton.icon(
                      label: Text('Place Order'),
                      icon: Icon(Icons.shopping_basket),
                      onPressed: uid != null
                          ? () async {
                              var open = restaurant!.openingTime
                                  .getRestaurantStatusBool(
                                      restaurant.closingTime);
                              if (open) {
                                if (subTotal >= restaurant.minimumOrder) {
                                  if (items.isNotEmpty) {
                                    if (address != null) {
                                      if (deliveryDistance < 5) {
                                        try {
                                          var notifier =
                                              ref.read(basketProvider.notifier);
                                          var rng = Random();
                                          var code =
                                              rng.nextInt(900000) + 100000;
                                          OrderModel order = OrderModel(
                                            orderOTP: code,
                                            restaurantId: restaurant.id,
                                            restaurantName: restaurant.name,
                                            restaurantImage: restaurant.image,
                                            restaurantCity: restaurant.city,
                                            restaurantStreet: restaurant.street,
                                            restaurantNumber: restaurant.mobile,
                                            restaurantPosition:
                                                restaurant.position,
                                            userId: userDetail!.uid,
                                            userName: userDetail.name,
                                            userEmail: userDetail.email,
                                            userPhoneNumber: userDetail.mobile,
                                            deliveryAddressPersonName:
                                                address.name,
                                            deliveryAddressPersonPhoneNumber:
                                                address.mobile,
                                            deliveryAddressStreet:
                                                address.street,
                                            deliveryAddressPosition:
                                                address.position,
                                            items: items,
                                            itemTotal: subTotal,
                                            deliveryCharge: deliveryCharge,
                                            discount: discount,
                                            discountVoucherId: voucher?.id,
                                            discountVoucherCode: voucher?.code,
                                            tip: tip ?? 0,
                                            grandTotal:
                                                double.parse(totalString),
                                            defaultConfirmed: defaultConfirmed,
                                          );

                                          await notifier.placeOrder(order);
                                        } catch (e) {
                                          ref
                                              .read(globalProvider.notifier)
                                              .updateMessage(
                                                  Strings.genericOrderError);
                                        }
                                      } else {
                                        ref
                                            .read(globalProvider.notifier)
                                            .updateMessage(
                                                Strings.changeDeliveryAddres);
                                      }
                                    } else {
                                      ref
                                          .read(globalProvider.notifier)
                                          .updateMessage(
                                              Strings.selectDeliveryAddres);
                                      showAddressList(context);
                                    }
                                  } else {
                                    ref
                                        .read(globalProvider.notifier)
                                        .updateMessage(Strings.emptyBasket);
                                  }
                                } else {
                                  ref
                                      .read(globalProvider.notifier)
                                      .updateMessage(
                                        'Minimum Order - Your basket total is रु${restaurant.minimumOrder - subTotal} less than restaurant minimum order. Please add more item to place order.',
                                      );
                                }
                              } else {
                                ref
                                    .read(globalProvider.notifier)
                                    .updateMessage(Strings.restaurantClosed);
                              }
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
