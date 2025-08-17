import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../config/string_constants.dart' show Strings;
import '../../providers/auth_provider.dart' show authProvider;
import '../../providers/lists_provider.dart' show userDetailProvider;
import '../../widgets/auth/auth_button_widget.dart';
import '../../widgets/dialogs/alert_dialog_model.dart';
import '../../widgets/dialogs/generic_dialog.dart';
import '../../widgets/generic/data_view_widget.dart';
import '../../widgets/profile/contactus_widget.dart';
import '../../widgets/profile/profile_menu_container_widget.dart';
import '../../widgets/profile/profile_menu_tile_widget.dart';
import 'account/account_settings_screen.dart';
import 'account/delivery_addresses_screen.dart';
import 'account/my_orders_screen.dart';
import 'service/customer_support_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataViewWidget(
      provider: userDetailProvider,
      dataBuilder: (data) => ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          data != null
              ? _buildProfileTile(context, ref, data)
              : const AuthButtonWidget(),
          if (data != null) _buildAccountSection(context),
          const SizedBox(height: 16),
          _buildServicesSection(context),
          const SizedBox(height: 16),
          _buildSocialSection(),
        ],
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context, WidgetRef ref, dynamic data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ProfileMenuTileWidget(
        isProfile: true,
        leading: Text(data.name.toString().initialLetters),
        title: '${data.name.capitalize}, ${data.mobile}',
        subtitle: data.email,
        trailing: IconButton(
          onPressed: () async {
            final result = await GenericDialog(
              Strings.logout,
            ).present(context).then((val) => val ?? false);
            if (result) ref.read(authProvider.notifier).signOut();
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return ProfileMenuContainerWidget(
      title: 'accounts',
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_accountTitles.length, (i) {
          return ProfileMenuTileWidget(
            onTap: () => context.push(_accountsFunctions[i]),
            leading: Icon(_accountsIcons[i], color: ColorConstants.textColor),
            title: _accountTitles[i],
            subtitle: _accountSubtitles[i],
          );
        }),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return ProfileMenuContainerWidget(
      title: 'services',
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _serviceTile(
            context,
            icon: Icons.support_agent,
            title: 'Contact Us',
            subtitle: 'Contact our support team',
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => const SafeArea(child: ContactusWidget()),
            ),
          ),
          _serviceTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'View our privacy policy',
            onTap: () => launchUrl(Uri.parse(RemoteConfigConstant.privacy)),
          ),
          _serviceTile(
            context,
            icon: Icons.star_border_rounded,
            title: 'Rate Us',
            subtitle: 'Rate our app on Play Store',
            onTap: () => launchUrl(
              Uri.parse(RemoteConfigConstant.playStoreURL),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ProfileMenuTileWidget(
      leading: Icon(icon, color: ColorConstants.textColor),
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }

  Widget _buildSocialSection() {
    return LayoutBuilder(
      builder: (context, constrains) {
        return ProfileMenuContainerWidget(
          title: 'social touch',
          widget: GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: (constrains.maxWidth / 2) / 42,
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
        );
      },
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
