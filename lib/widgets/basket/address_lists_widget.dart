import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../config/constants.dart' show ColorConstants;
import '../../config/extensions.dart' show StringExtensions;
import '../../config/typo_config.dart' show typoConfig;
import '../../providers/basket_provider.dart' show basketProvider;
import '../../providers/lists_provider.dart' show addressListProvider;
import '../generic/loader_widget.dart';

class AddressListsWidget extends ConsumerWidget {
  const AddressListsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddress =
        ref.watch(basketProvider.select((state) => state.address));
    return ref.watch(addressListProvider).when(
          data: (addresses) {
            if (addresses.isEmpty) {
              return const Text('No address found');
            }

            return ListView.separated(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                var address = addresses[i];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    ref.read(basketProvider.notifier).selectAddress(address);
                  },
                  selectedColor: ColorConstants.textColor.withAlpha(25),
                  selected: selectedAddress == address,
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: ColorConstants.primary,
                    child: Text(
                      addresses[i].name.initialLetters,
                      style:
                          typoConfig.textStyle.smallCaptionLabelMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    '${address.name.capitalize}, ${address.mobile}',
                    style: typoConfig.textStyle.largeCaptionLabel3Bold,
                  ),
                  subtitle: Text(
                    '${(address.addressType ?? 'home').toUpperCase()} - ${address.street}',
                    style: typoConfig.textStyle.smallSmall,
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemCount: addresses.length,
            );
          },
          error: (err, stack) => Center(
            child: Text(err.toString()),
          ),
          loading: () => Center(
            child: LoaderWidget(),
          ),
        );
  }
}
