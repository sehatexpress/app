import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/constants.dart' show ColorConstants;
import '../../../config/extensions.dart';
import '../../../config/typo_config.dart';
import '../../../helper/helper.dart' show openBottombarForAddress;
import '../../../providers/address_provider.dart' show addressProvider;
import '../../../providers/lists_provider.dart' show addressListProvider;
import '../../../widgets/generic/loader_widget.dart';

class DeliveryAddressesScreen extends ConsumerWidget {
  const DeliveryAddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(addressListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Address'),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: OutlinedButton.icon(
              style: TextButton.styleFrom(
                side: BorderSide(width: .75, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                openBottombarForAddress(context: context, model: null);
              },
              label: Text(
                'New',
                style: typoConfig.textStyle.largeCaptionLabel3Bold.copyWith(
                  color: Colors.white,
                ),
              ),
              icon: Icon(Icons.add_rounded, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
      body: address.when(
        data: (lists) {
          if (lists.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                onTap: () {
                  openBottombarForAddress(context: context, model: lists[i]);
                },
                leading: CircleAvatar(
                  child: Text(lists[i].name.initialLetters),
                ),
                title: Text(
                  '${lists[i].name}, ${lists[i].phone}',
                  style: typoConfig.textStyle.smallCaptionSubtitle1,
                ),
                subtitle: Text(
                  lists[i].street,
                  style: typoConfig.textStyle.smallSmall,
                ),
                trailing: SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton(
                    onPressed: () async {
                      var result = await context.showGenericDialog(
                        title: 'Delete Address?',
                        content:
                            'Are you sure, you want to delete the address?',
                      );
                      if (result == true) {
                        ref
                            .read(addressProvider.notifier)
                            .deleteAddress(lists[i].id!);
                      }
                    },
                    icon: const Icon(
                      Icons.delete_rounded,
                      size: 16,
                      color: ColorConstants.textColor,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, i) => const Divider(height: 0),
              itemCount: lists.length,
            );
          }
          return Center(child: Text('No address found'));
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: LoaderWidget()),
      ),
    );
  }
}
