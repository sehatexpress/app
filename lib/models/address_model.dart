import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

import '../config/string_constants.dart';
import 'position_model.dart';

@immutable
class AddressModel {
  final String? id;
  final String name;
  final String phone;
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
    required this.phone,
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
    String? phone,
    String? addressType,
    String? email,
    String? street,
    PositionModel? position,
    bool? status,
    int? createdAt,
    int? updatedAt,
  }) => AddressModel(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
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
    name: snap[Fields.name],
    phone: snap[Fields.phone],
    addressType: snap.data().toString().contains(Fields.addressType)
        ? snap[Fields.addressType]
        : 'Home',
    email: snap[Fields.email],
    street: snap[Fields.street],
    position: PositionModel.fromSnapshot(snap[Fields.position]),
    status: snap[Fields.status],
    createdAt: snap[Fields.createdAt],
    updatedAt: snap[Fields.updatedAt],
  );

  @override
  String toString() =>
      'AddressModel(id: $id, name: $name, phone: $phone, addressType $addressType, email: $email, street: $street, position: $position, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
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
      phone.hashCode ^
      addressType.hashCode ^
      email.hashCode ^
      street.hashCode ^
      position.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
