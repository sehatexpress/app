import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

import '../config/string_constants.dart';

@immutable
class UserModel {
  final String uid;
  final String name;
  final String? email;
  final int? gender;
  final String phone;
  final int? points;
  final bool? status;
  final int? createdAt;
  final int? updatedAt;
  final String? deviceToken;
  final int? freeDelivery;
  const UserModel({
    required this.uid,
    required this.name,
    this.email,
    this.gender,
    required this.phone,
    this.points,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deviceToken,
    this.freeDelivery,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? gender,
    String? phone,
    int? points,
    bool? status,
    int? createdAt,
    int? updatedAt,
    String? deviceToken,
    int? freeDelivery,
  }) => UserModel(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    gender: gender ?? this.gender,
    phone: phone ?? this.phone,
    points: points ?? this.points,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceToken: deviceToken ?? this.deviceToken,
    freeDelivery: freeDelivery ?? this.freeDelivery,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) => UserModel(
    uid: snap.id,
    name: snap[Fields.name],
    gender: snap[Fields.gender],
    email: snap[Fields.email],
    phone: snap[Fields.phone],
    points: snap[Fields.points],
    status: snap[Fields.status],
    createdAt: snap[Fields.createdAt],
    updatedAt: snap[Fields.updatedAt],
    deviceToken: snap.data().toString().contains(Fields.deviceToken)
        ? snap[Fields.deviceToken]
        : null,
    freeDelivery: snap.data().toString().contains(Fields.freeDelivery)
        ? snap[Fields.freeDelivery]
        : 0,
  );

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, email: $email, gender: $gender, phone: $phone, points: $points, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deviceToken: $deviceToken, freeDelivery: $freeDelivery)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.phone == phone &&
        other.points == points &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deviceToken == deviceToken &&
        other.freeDelivery == freeDelivery;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      phone.hashCode ^
      points.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deviceToken.hashCode ^
      freeDelivery.hashCode;
}
