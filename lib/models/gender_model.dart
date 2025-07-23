import 'package:flutter/foundation.dart' show immutable;

@immutable
class GenderModel {
  final String title;
  final int value;

  const GenderModel({
    required this.title,
    required this.value,
  });
}

List<GenderModel> genders = const [
  GenderModel(title: 'Male', value: 1),
  GenderModel(title: 'Female', value: 2),
  GenderModel(title: 'Prefer Not to Say', value: 0),
];
