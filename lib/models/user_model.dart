import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

import '../config/string_constants.dart';

@immutable
class UserModel {
  final String uid;
  final String name;
  final String email;
  final int? gender;
  final String mobile;
  final int? points;
  final bool? status;
  final int? createdAt;
  final int? updatedAt;
  final String? deviceToken;
  final int? freeDelivery;
  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.gender,
    required this.mobile,
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
    String? mobile,
    int? points,
    bool? status,
    int? createdAt,
    int? updatedAt,
    String? deviceToken,
    int? freeDelivery,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        mobile: mobile ?? this.mobile,
        points: points ?? this.points,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deviceToken: deviceToken ?? this.deviceToken,
        freeDelivery: freeDelivery ?? this.freeDelivery,
      );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) => UserModel(
        uid: snap.id,
        name: snap[FirestoreFields.name],
        gender: snap[FirestoreFields.gender],
        email: snap[FirestoreFields.email],
        mobile: snap[FirestoreFields.mobile],
        points: snap[FirestoreFields.points],
        status: snap[FirestoreFields.status],
        createdAt: snap[FirestoreFields.createdAt],
        updatedAt: snap[FirestoreFields.updatedAt],
        deviceToken: snap.data().toString().contains(FirestoreFields.deviceToken)
            ? snap[FirestoreFields.deviceToken]
            : null,
        freeDelivery: snap.data().toString().contains(FirestoreFields.freeDelivery)
            ? snap[FirestoreFields.freeDelivery]
            : 0,
      );

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, email: $email, gender: $gender, mobile: $mobile, points: $points, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deviceToken: $deviceToken, freeDelivery: $freeDelivery)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.mobile == mobile &&
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
      mobile.hashCode ^
      points.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deviceToken.hashCode ^
      freeDelivery.hashCode;
}
