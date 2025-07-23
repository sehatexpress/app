import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart';

class ContactusWidget extends StatelessWidget {
  const ContactusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          ...List.generate(
            _icons.length,
            (i) => ListTile(
              dense: true,
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade50,
                child: Icon(
                  _icons[i],
                  color: ColorConstants.primary,
                ),
              ),
              title: Text(
                _title[i],
                style: typoConfig.textStyle.smallCaptionLabelMedium,
              ),
              subtitle: Text(
                _subTitle[i],
                style: typoConfig.textStyle.smallCaptionSubtitle2,
              ),
            ),
          ),
          const Divider(height: 0),
          Container(
            padding: const EdgeInsets.all(16).copyWith(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: TextButton.styleFrom(
                      side: BorderSide.none,
                      padding: EdgeInsets.zero,
                      backgroundColor: ColorConstants.primary.withAlpha(25),
                    ),
                    onPressed: () =>
                        launchUrl(Uri.parse('mailto:toeato1@gmail.com')),
                    child: Text(
                      'EMAIL US',
                      style:
                          typoConfig.textStyle.smallCaptionLabelMedium.copyWith(
                        color: ColorConstants.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: TextButton.styleFrom(
                      side: BorderSide.none,
                      padding: EdgeInsets.zero,
                      backgroundColor: ColorConstants.primary.withAlpha(25),
                    ),
                    onPressed: () => launchUrl(Uri.parse('tel:+9779802588671')),
                    child: Text(
                      'CALL US',
                      style:
                          typoConfig.textStyle.smallCaptionLabelMedium.copyWith(
                        color: ColorConstants.primary,
                      ),
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

List<IconData> _icons = [
  Icons.location_on_rounded,
  Icons.email_rounded,
  Icons.phone_rounded,
];
List<String> _title = ['Address', 'Email', 'Contact Number'];
List<String> _subTitle = [
  'Toeato Pvt. Ltd. Birgunj Nepal',
  'toeato0@gmail.com',
  '+977 9802588671, +977 9814245916',
];
