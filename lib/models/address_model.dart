import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

import '../config/string_constants.dart';
import 'position_model.dart';

@immutable
class AddressModel {
  final String? id;
  final String name;
  final String mobile;
  final String? addressType;
  final String? email;
  final String street;
  final PositionModel position;
  final bool status;
  final int? createdAt;
  final int? updatedAt;
  const AddressModel({
    this.id,
    required this.name,
    required this.mobile,
    this.addressType,
    this.email,
    required this.street,
    required this.position,
    this.status = true,
    this.createdAt,
    this.updatedAt,
  });

  AddressModel copyWith({
    String? id,
    String? name,
    String? mobile,
    String? addressType,
    String? email,
    String? street,
    PositionModel? position,
    bool? status,
    int? createdAt,
    int? updatedAt,
  }) =>
      AddressModel(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        addressType: addressType ?? this.addressType,
        email: email ?? this.email,
        street: street ?? this.street,
        position: position ?? this.position,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AddressModel.fromSnapshot(DocumentSnapshot snap) => AddressModel(
        id: snap.id,
        name: snap[FirestoreFields.name],
        mobile: snap[FirestoreFields.mobile],
        addressType:
            snap.data().toString().contains(FirestoreFields.addressType)
                ? snap[FirestoreFields.addressType]
                : 'Home',
        email: snap[FirestoreFields.email],
        street: snap[FirestoreFields.street],
        position: PositionModel.fromSnapshot(snap[FirestoreFields.position]),
        status: snap[FirestoreFields.status],
        createdAt: snap[FirestoreFields.createdAt],
        updatedAt: snap[FirestoreFields.updatedAt],
      );

  @override
  String toString() =>
      'AddressModel(id: $id, name: $name, mobile: $mobile, addressType $addressType, email: $email, street: $street, position: $position, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.mobile == mobile &&
        other.addressType == addressType &&
        other.email == email &&
        other.street == street &&
        other.position == position &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      mobile.hashCode ^
      addressType.hashCode ^
      email.hashCode ^
      street.hashCode ^
      position.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
