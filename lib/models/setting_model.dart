import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

@immutable
class SettingModel {
  final String id;
  final double baseDeliveryCharge;
  final int baseDeliveryKM;
  final int radiusKM;
  final double perKM;
  final int freeDelivery;
  final int freeDeliveryKM;
  final double minimumOrder;
  final String imgURL;
  const SettingModel({
    required this.id,
    required this.baseDeliveryCharge,
    required this.baseDeliveryKM,
    required this.radiusKM,
    required this.perKM,
    required this.freeDelivery,
    required this.freeDeliveryKM,
    required this.minimumOrder,
    required this.imgURL,
  });

  SettingModel copyWith({
    String? id,
    double? baseDeliveryCharge,
    int? baseDeliveryKM,
    int? radiusKM,
    double? perKM,
    int? freeDelivery,
    int? freeDeliveryKM,
    double? minimumOrder,
    String? imgURL,
  }) =>
      SettingModel(
        id: id ?? this.id,
        baseDeliveryCharge: baseDeliveryCharge ?? this.baseDeliveryCharge,
        baseDeliveryKM: baseDeliveryKM ?? this.baseDeliveryKM,
        radiusKM: radiusKM ?? this.radiusKM,
        perKM: perKM ?? this.perKM,
        freeDelivery: freeDelivery ?? this.freeDelivery,
        freeDeliveryKM: freeDeliveryKM ?? this.freeDeliveryKM,
        minimumOrder: minimumOrder ?? this.minimumOrder,
        imgURL: imgURL ?? this.imgURL,
      );

  factory SettingModel.fromSnapshot(DocumentSnapshot map) => SettingModel(
        id: map.id,
        baseDeliveryCharge: map['baseDeliveryCharge'],
        baseDeliveryKM: map['baseDeliveryKM'],
        radiusKM: map['radiusKM'],
        perKM: map['perKM'],
        freeDelivery: map['freeDelivery'],
        freeDeliveryKM: map['freeDeliveryKM'],
        minimumOrder: map['minimumOrder'],
        imgURL: map['imgURL'],
      );

  @override
  String toString() =>
      'SettingModel(id: $id, deliveryCharge: $baseDeliveryCharge, radiusKM: $radiusKM, freeDelivery: $freeDelivery, freeDeliveryKM: $freeDeliveryKM, perKM: $perKM, minimumOrder: $minimumOrder, imgURL: $imgURL)';

  @override
  bool operator ==(covariant SettingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.baseDeliveryCharge == baseDeliveryCharge &&
        other.radiusKM == radiusKM &&
        other.perKM == perKM &&
        other.freeDelivery == freeDelivery &&
        other.freeDeliveryKM == freeDeliveryKM &&
        other.minimumOrder == minimumOrder &&
        other.imgURL == imgURL;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      baseDeliveryCharge.hashCode ^
      radiusKM.hashCode ^
      perKM.hashCode ^
      freeDelivery.hashCode ^
      freeDeliveryKM.hashCode ^
      minimumOrder.hashCode ^
      imgURL.hashCode;
}
