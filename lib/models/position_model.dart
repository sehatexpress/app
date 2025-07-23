import 'package:cloud_firestore/cloud_firestore.dart' show GeoPoint;
import 'package:flutter/foundation.dart' show immutable;

import '../config/string_constants.dart';

@immutable
class PositionModel {
  final String geohash;
  final GeoPoint geopoint;

  const PositionModel({
    required this.geohash,
    required this.geopoint,
  });

  PositionModel copyWith({
    String? geohash,
    GeoPoint? geopoint,
  }) =>
      PositionModel(
        geohash: geohash ?? this.geohash,
        geopoint: geopoint ?? this.geopoint,
      );

  Map<String, dynamic> toDocument() => {
        FirestoreFields.geohash: geohash,
        FirestoreFields.geopoint: geopoint,
      };

  factory PositionModel.fromSnapshot(Map<String, dynamic> snap) =>
      PositionModel(
        geohash: snap[FirestoreFields.geohash],
        geopoint: snap[FirestoreFields.geopoint],
      );

  @override
  String toString() => 'Position(geohash: $geohash, geopoint: $geopoint)';

  @override
  bool operator ==(covariant PositionModel other) {
    if (identical(this, other)) return true;

    return other.geohash == geohash && other.geopoint == geopoint;
  }

  @override
  int get hashCode => geohash.hashCode ^ geopoint.hashCode;
}
