import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

import '../config/enums.dart' show TicketStatusEnum, convertToTicketStatus;

@immutable
class QueryModel {
  final String? id;
  final String uid;
  final String message;
  final String phone;
  final String name;
  final TicketStatusEnum status;
  final int? createdAt;
  final String? createdBy;
  final int? updatedAt;
  final String? updatedBy;
  const QueryModel({
    this.id,
    required this.uid,
    required this.message,
    required this.phone,
    required this.name,
    this.status = TicketStatusEnum.pending,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  QueryModel copyWith({
    String? id,
    String? uid,
    String? message,
    String? phone,
    String? name,
    TicketStatusEnum? status,
    int? createdAt,
    String? createdBy,
    int? updatedAt,
    String? updatedBy,
  }) =>
      QueryModel(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        message: message ?? this.message,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uid': uid,
        'message': message,
        'phone': phone,
        'name': name,
        'status': 'pending',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'createdBy': uid,
        'updatedAt': updatedAt,
        'updatedBy': updatedBy,
      };

  factory QueryModel.fromSnapshot(DocumentSnapshot snap) => QueryModel(
        id: snap.id,
        uid: snap['uid'],
        message: snap['message'],
        name: snap['name'],
        phone: snap['phone'],
        status: convertToTicketStatus(snap['status']),
        createdAt: snap['createdAt'],
        createdBy: snap['createdBy'],
        updatedAt: snap['updatedAt'],
        updatedBy: snap['updatedBy'],
      );

  @override
  String toString() =>
      'QueryModel(id: $id, uid: $uid, message: $message, phone: $phone, name: $name, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy)';

  @override
  bool operator ==(covariant QueryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.message == message &&
        other.phone == phone &&
        other.name == name &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        other.updatedAt == updatedAt &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      message.hashCode ^
      phone.hashCode ^
      name.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      createdBy.hashCode ^
      updatedAt.hashCode ^
      updatedBy.hashCode;
}
