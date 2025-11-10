import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable, listEquals;

import '../config/enums.dart' show CityEnum, cityFromString;
import '../config/extensions.dart' show ExpiryCheck;
import '../config/string_constants.dart' show Fields;

@immutable
class VoucherModel {
  final String id;
  final String code;
  final double value;
  final String type;
  final double minimumOrder;
  final String beginDate;
  final String expiryDate;
  final double upto;
  final bool? status;
  final int? createdAt;
  final int? updatedAt;
  final List<String> users;
  final List<String> conditions;
  final bool expired;
  final String? restaurantId;
  final String? userId;
  final CityEnum? city;
  const VoucherModel({
    required this.id,
    required this.code,
    required this.value,
    required this.type,
    required this.minimumOrder,
    required this.beginDate,
    required this.expiryDate,
    required this.upto,
    this.status,
    this.createdAt,
    this.updatedAt,
    required this.users,
    required this.conditions,
    required this.expired,
    this.restaurantId,
    this.userId,
    required this.city,
  });

  VoucherModel copyWith({
    String? id,
    String? code,
    double? value,
    String? type,
    double? minimumOrder,
    String? beginDate,
    String? expiryDate,
    double? upto,
    bool? status,
    int? createdAt,
    int? updatedAt,
    List<String>? users,
    List<String>? conditions,
    bool? expired,
    String? restaurantId,
    String? userId,
    CityEnum? city,
  }) => VoucherModel(
    id: id ?? this.id,
    code: code ?? this.code,
    value: value ?? this.value,
    type: type ?? this.type,
    minimumOrder: minimumOrder ?? this.minimumOrder,
    beginDate: beginDate ?? this.beginDate,
    expiryDate: expiryDate ?? this.expiryDate,
    upto: upto ?? this.upto,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    users: users ?? this.users,
    conditions: conditions ?? this.conditions,
    expired: expired ?? this.expired,
    restaurantId: restaurantId ?? this.restaurantId,
    userId: userId ?? this.userId,
    city: city ?? this.city,
  );

  factory VoucherModel.fromSnapshot(DocumentSnapshot snapshot) => VoucherModel(
    id: snapshot.id,
    code: snapshot[Fields.code],
    value: snapshot[Fields.value].toDouble(),
    type: snapshot[Fields.type],
    minimumOrder: snapshot[Fields.minimumOrder].toDouble(),
    beginDate: snapshot[Fields.beginDate],
    expiryDate: snapshot[Fields.expiryDate],
    upto: snapshot[Fields.upto].toDouble(),
    status: snapshot[Fields.status],
    createdAt: snapshot[Fields.createdAt],
    updatedAt: snapshot[Fields.updatedAt],
    users: List<String>.from(snapshot[Fields.users]),
    conditions: List<String>.from(snapshot[Fields.conditions]),
    expired: (snapshot[Fields.expiryDate] as String).isExpired(),
    restaurantId: snapshot[Fields.restaurantId],
    userId: snapshot[Fields.userId],
    city: snapshot.data().toString().contains('city')
        ? snapshot[Fields.city] != null
              ? cityFromString(snapshot[Fields.city])
              : null
        : null,
  );

  @override
  String toString() =>
      'VoucherModel(id: $id, code: $code, value: $value, type: $type, minimumOrder: $minimumOrder, beginDate: $beginDate, expiryDate: $expiryDate, upto: $upto, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, users: $users, conditions: $conditions, expired: $expired, restaurantId: $restaurantId, userId: $userId, city: $city)';

  @override
  bool operator ==(covariant VoucherModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.value == value &&
        other.type == type &&
        other.minimumOrder == minimumOrder &&
        other.beginDate == beginDate &&
        other.expiryDate == expiryDate &&
        other.upto == upto &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.users, users) &&
        listEquals(other.conditions, conditions) &&
        other.expired == expired &&
        other.restaurantId == restaurantId &&
        other.userId == userId &&
        other.city == city;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      value.hashCode ^
      type.hashCode ^
      minimumOrder.hashCode ^
      beginDate.hashCode ^
      expiryDate.hashCode ^
      upto.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      users.hashCode ^
      conditions.hashCode ^
      expired.hashCode ^
      restaurantId.hashCode ^
      userId.hashCode ^
      city.hashCode;
}
