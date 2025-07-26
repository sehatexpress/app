import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

import '../../config/string_constants.dart' show Strings;
import '../../widgets/dialogs/generic_dialog.dart';
import '../../widgets/profile/contactus_widget.dart';
import '../../widgets/profile/profile_menu_container_widget.dart';
import 'account/account_settings_screen.dart';
import '../../config/constants.dart'
    show ColorConstants, RemoteConfigConstant, SocialURLConstant;
import '../../config/extensions.dart'
    show ScreenTypeExtension, StringExtensions;
import '../../providers/auth_provider.dart' show authProvider;
import '../../providers/lists_provider.dart' show userDetailProvider;
import '../../widgets/auth/auth_button_widget.dart';
import '../../widgets/dialogs/alert_dialog_model.dart';
import '../../widgets/generic/loader_widget.dart';
import '../../widgets/profile/profile_menu_tile_widget.dart';
import 'account/delivery_addresses_screen.dart';
import 'account/my_orders_screen.dart';
import 'service/customer_support_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final detail = ref.watch(userDetailProvider);
    return detail.when(
      data: (data) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: [
            data != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ProfileMenuTileWidget(
                      isProfile: true,
                      leading: Text(data.name.toString().initialLetters),
                      title: '${data.name.capitalize}, ${data.mobile}',
                      subtitle: data.email,
                      trailing: IconButton(
                        onPressed: () async {
                          var result = await GenericDialog(
                            Strings.logout,
                          ).present(context).then((val) => val ?? false);
                          if (result) {
                            ref.read(authProvider.notifier).signOut();
                          }
                        },
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    ),
                  )
                : const AuthButtonWidget(),
            const SizedBox(height: 16),
            // account service
            if (data != null) ...[
              ProfileMenuContainerWidget(
                title: 'accounts',
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    _accountTitles.length,
                    (i) => ProfileMenuTileWidget(
                      onTap: () => context.push(_accountsFunctions[i]),
                      leading: Icon(
                        _accountsIcons[i],
                        color: ColorConstants.textColor,
                      ),
                      title: _accountTitles[i],
                      subtitle: _accountSubtitles[i],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            // services
            ProfileMenuContainerWidget(
              title: 'services',
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileMenuTileWidget(
                    leading: Icon(
                      Icons.support_agent,
                      color: ColorConstants.textColor,
                    ),
                    title: 'Contact Us',
                    subtitle: 'Contact our support team',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SafeArea(child: const ContactusWidget());
                        },
                      );
                    },
                  ),
                  ProfileMenuTileWidget(
                    leading: Icon(
                      Icons.privacy_tip,
                      color: ColorConstants.textColor,
                    ),
                    title: 'Privacy Policy',
                    subtitle: 'Get help and assistance from our support team',
                    onTap: () =>
                        launchUrl(Uri.parse(RemoteConfigConstant.privacy)),
                  ),
                  ProfileMenuTileWidget(
                    leading: Icon(
                      Icons.star_border_rounded,
                      color: ColorConstants.textColor,
                    ),
                    title: 'Rate Us',
                    subtitle: 'Get help and assistance from our support team',
                    onTap: () => launchUrl(
                      Uri.parse(RemoteConfigConstant.playStoreURL),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // socila options
            ProfileMenuContainerWidget(
              title: 'social touch',
              widget: GridView.count(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: (size.width / 2) / 50,
                padding: EdgeInsets.zero,
                children: List.generate(
                  _socialIcons.length,
                  (i) => TextButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse(_socialUrls[i]),
                      mode: LaunchMode.externalApplication,
                    ),
                    label: Text(_socialTitles[i]),
                    icon: Icon(_socialIcons[i]),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (e, _) => Center(child: Text(e.toString())),
      loading: () => Center(child: LoaderWidget()),
    );
  }
}

// accounts
List<String> _accountTitles = [
  'My Orders',
  'Delivery Addresses',
  'Account Settings',
  'My Customer Support',
];
List<String> _accountSubtitles = [
  'View and track your past and current orders',
  'Manage your delivery addresses',
  'Manage your personal information and password',
  'Get help and assistance from our support team',
];
List<IconData> _accountsIcons = [
  Icons.shopping_cart_rounded,
  Icons.location_on_rounded,
  Icons.person_rounded,
  Icons.help_outline_rounded,
];
List<Widget> _accountsFunctions = [
  MyOrdersScreen(),
  DeliveryAddressesScreen(),
  AccountSettingsScreen(),
  CustomerSupportScreen(),
];

// socials
List<String> _socialTitles = ['YouTube', 'Instagram', 'Facebook', 'Twitter'];
List<String> _socialUrls = [
  SocialURLConstant.youtube,
  SocialURLConstant.instagram,
  SocialURLConstant.facebook,
  SocialURLConstant.twitter,
];
List<IconData> _socialIcons = [
  Icons.youtube_searched_for_rounded,
  Icons.code_rounded,
  Icons.facebook_rounded,
  Icons.close_rounded,
];
