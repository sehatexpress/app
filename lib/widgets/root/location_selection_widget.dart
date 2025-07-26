import 'package:app/config/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/string_constants.dart';
import '../../config/typo_config.dart';
import '../../helper/helper.dart';
import '../../providers/auth_provider.dart';
import '../../providers/basket_provider.dart';
import '../../providers/lists_provider.dart';
import '../../providers/location_provider.dart';
import '../../screens/location/search_location_screen.dart';
import '../generic/loader_widget.dart';

class LocationSelectionWidget extends HookConsumerWidget {
  const LocationSelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: <Widget>[
        _ListTileWidget(
          leading: const Icon(Icons.my_location_rounded),
          title: LocationStrings.useMyCurrentLocationTitle,
          subtitle: LocationStrings.useMyCurrentLocationDesc,
          onTap: () async {
            await ref.read(locationProvider.notifier).init(load: true);
            context.pop();
          },
        ),
        _ListTileWidget(
          leading: const Icon(Icons.near_me_rounded),
          title: LocationStrings.useManualLocationTitle,
          subtitle: LocationStrings.useMManualLocationDesc,
          onTap: () async {
            context.pop();
            context.push(const SearchLocationScreen());
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            var user = ref.watch(authProvider);
            if (user != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ListTileWidget(
                    leading: const Icon(Icons.add),
                    title: 'Add New Address',
                    subtitle: 'Add new address to view',
                    onTap: () {
                      Navigator.pop(context);
                      Future.delayed(
                        Duration(milliseconds: 250),
                        () => openBottombarForAddress(
                          context: context,
                          model: null,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Divider(height: 0)),
                      SizedBox(width: 6),
                      Text(
                        'SAVED ADDRESS',
                        style: typoConfig.textStyle.smallCaptionSubtitle2,
                      ),
                      SizedBox(width: 6),
                      Expanded(child: Divider(height: 0)),
                    ],
                  ),
                  _AddressListWidget(ref: ref),
                ],
              );
            }
            return const SizedBox();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _AddressListWidget extends StatelessWidget {
  final WidgetRef ref;
  const _AddressListWidget({required this.ref});

  @override
  Widget build(BuildContext context) {
    final addressListAsyncValue = ref.watch(addressListProvider);
    return addressListAsyncValue.when(
      data: (lists) {
        return lists.isEmpty
            ? Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text('No address found!'),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  final e = lists[index];
                  return _ListTileWidget(
                    leading: Text(
                      '${lists.indexOf(e) + 1}',
                      style: typoConfig.textStyle.smallBodyBodyText1,
                    ),
                    title:
                        '${e.addressType?.toUpperCase()} - ${e.name}, ${e.mobile}',
                    subtitle: e.street,
                    onTap: () async {
                      await ref
                          .read(locationProvider.notifier)
                          .updateCords(
                            latitude: e.position.geopoint.latitude,
                            longitude: e.position.geopoint.longitude,
                          );
                      ref.read(basketProvider.notifier).selectAddress(e);
                      Navigator.pop(context);
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 6),
              );
      },
      error: (err, context) => Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(err.toString()),
      ),
      loading: () => Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: const LoaderWidget(),
      ),
    );
  }
}

class _ListTileWidget extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ListTileWidget({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: .5, color: Colors.grey.shade300),
        ),
        alignment: Alignment.center,
        child: leading,
      ),
      title: Text(title, style: typoConfig.textStyle.largeCaptionLabel3Bold),
      subtitle: Text(subtitle, style: typoConfig.textStyle.smallSmall),
      minVerticalPadding: 0,
      onTap: onTap,
    );
  }
}
