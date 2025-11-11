import 'package:flutter/material.dart';

import '../../config/enums.dart';
import '../../config/typo_config.dart';

class NotificationCardWidget extends StatelessWidget {
  final NotificationEnum type;
  final String title;
  final dynamic body;

  const NotificationCardWidget({
    super.key,
    required this.type,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final notificationStyle = _NotificationStyle.getNotificationStyle(type);

    return Container(
      decoration: BoxDecoration(
        gradient: notificationStyle.gradient,
        boxShadow: notificationStyle.shadows,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(1.6),
      child: Container(
        decoration: BoxDecoration(
          gradient: notificationStyle.innerGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(
              notificationStyle.icon,
              size: 30,
              color: notificationStyle.iconColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: typoConfig.textStyle.smallCaptionLabelMedium
                        .copyWith(color: typoConfig.color.neutralsNeutrals600),
                  ),
                  body is String
                      ? Text(
                          body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: typoConfig.textStyle.smallCaptionSubtitle2
                              .copyWith(
                                color: typoConfig.color.neutralsNeutrals600,
                              ),
                        )
                      : body,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationStyle {
  final Gradient gradient;
  final List<BoxShadow> shadows;
  final IconData icon;
  final Color iconColor;
  final Gradient innerGradient;

  const _NotificationStyle({
    required this.gradient,
    required this.shadows,
    required this.icon,
    required this.iconColor,
    required this.innerGradient,
  });

  static _NotificationStyle getNotificationStyle(NotificationEnum type) {
    switch (type) {
      case NotificationEnum.info:
        return _NotificationStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6E9DF9), Colors.white],
          ),
          shadows: [
            BoxShadow(
              color: Color(0x916E9DF9),
              offset: Offset(8, 13),
              blurRadius: 12,
              spreadRadius: -8,
            ),
            BoxShadow(
              color: Color(0x87FFFFFF),
              offset: Offset(-5, -5),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
          icon: Icons.info,
          iconColor: Color(0xFF6E9DF9),
          innerGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFBBD1FC), Color(0xFFFFFFFF)],
          ),
        );
      case NotificationEnum.error:
        return _NotificationStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF7448), Colors.white],
          ),
          shadows: [
            BoxShadow(
              color: Color(0x91FF7448),
              offset: Offset(8, 13),
              blurRadius: 12,
              spreadRadius: -8,
            ),
            BoxShadow(
              color: Color(0x87FFFFFF),
              offset: Offset(-5, -5),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
          icon: Icons.error,
          iconColor: Color(0xFFFF7448),
          innerGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE1D7), Colors.white],
          ),
        );
      case NotificationEnum.warning:
        return _NotificationStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF4A71D), Colors.white],
          ),
          shadows: [
            BoxShadow(
              color: Color(0x91F4A71D),
              offset: Offset(8, 13),
              blurRadius: 12,
              spreadRadius: -8,
            ),
            BoxShadow(
              color: Color(0x87FFFFFF),
              offset: Offset(-5, -5),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
          icon: Icons.warning,
          iconColor: Color(0xFFF4A71D),
          innerGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFCEBD2), Colors.white],
          ),
        );
      case NotificationEnum.success:
        return _NotificationStyle(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5DDA5D), Colors.white],
          ),
          shadows: [
            BoxShadow(
              color: Color(0x915DDA5D),
              offset: Offset(8, 13),
              blurRadius: 12,
              spreadRadius: -8,
            ),
            BoxShadow(
              color: Color(0x87FFFFFF),
              offset: Offset(-5, -5),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
          icon: Icons.check_circle,
          iconColor: Color(0xFF5DDA5D),
          innerGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE0FCE0), Color(0xFFFFFFFF)],
          ),
        );
    }
  }
}
