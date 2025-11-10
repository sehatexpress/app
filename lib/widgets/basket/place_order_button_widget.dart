import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/extensions.dart';
import '../../config/typo_config.dart' show typoConfig;
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../providers/basket_provider.dart' show basketProvider;
import '../auth/auth_button_widget.dart';
import 'show_address_list_dialog.dart';

class PlaceOrderButtonWidget extends ConsumerWidget {
  const PlaceOrderButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authUidProvider);
    var address = ref.watch(basketProvider.select((state) => state.address));
    var subTotalString = ref.watch(
      basketProvider.select((state) => state.subTotalString),
    );
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                      '${address.name.capitalize}, ${address.phone}',
                                      style: typoConfig
                                          .textStyle
                                          .largeCaptionLabel3Bold
                                          .copyWith(height: 1),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      address.street.capitalize,
                                      style: typoConfig
                                          .textStyle
                                          .smallCaptionSubtitle2
                                          .copyWith(height: 1.1),
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
                                      .textStyle
                                      .smallCaptionSubtitle1
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
                                      .textStyle
                                      .smallCaptionSubtitle1
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                      onPressed: uid != null ? () {} : null,
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
