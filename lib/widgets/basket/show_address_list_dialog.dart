import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;
import '../../helper/helper.dart' show openBottombarForAddress;
import 'address_lists_widget.dart';

Future showAddressList(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Container(
      constraints: const BoxConstraints(
        minHeight: 300,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Delivery Address'),
                SizedBox(
                  height: 32,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      openBottombarForAddress(
                        context: context,
                        model: null,
                      );
                    },
                    icon: const Icon(Icons.add_location_alt, size: 16),
                    label: Text(
                      'ADD',
                      style: typoConfig.textStyle.buttonsButtonSmall.copyWith(
                        color: ColorConstants.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 0),
          const AddressListsWidget(),
        ],
      ),
    ),
  );
}
