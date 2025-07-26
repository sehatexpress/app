import 'package:flutter/material.dart' show IconData, Icons, immutable;

@immutable
class BottomBarModel {
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  const BottomBarModel({
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });

  BottomBarModel copyWith({
    String? title,
    IconData? icon,
    IconData? selectedIcon,
  }) => BottomBarModel(
    title: title ?? this.title,
    icon: icon ?? this.icon,
    selectedIcon: selectedIcon ?? this.selectedIcon,
  );

  @override
  bool operator ==(covariant BottomBarModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.icon == icon &&
        other.selectedIcon == selectedIcon;
  }

  @override
  int get hashCode => title.hashCode ^ icon.hashCode ^ selectedIcon.hashCode;
}

List<BottomBarModel> bottomBarLists = [
  BottomBarModel(
    title: 'Home',
    selectedIcon: Icons.home_rounded,
    icon: Icons.home_outlined,
  ),
  BottomBarModel(
    title: 'Profile',
    selectedIcon: Icons.person,
    icon: Icons.person_outlined,
  ),
];
