import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;

class ProfileMenuTileWidget extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Function()? onTap;
  final bool isProfile;
  const ProfileMenuTileWidget({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: isProfile
            ? ColorConstants.primary
            : ColorConstants.textColor.withAlpha(25),
        child: leading,
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: typoConfig.textStyle.largeCaptionLabel3Bold.copyWith(
          height: 1,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                height: 1,
                fontSize: 11,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
