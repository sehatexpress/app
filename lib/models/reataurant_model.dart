import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable, listEquals;

import '../config/enums.dart' show FilterEnum, convertToFilterType;
import '../config/extensions.dart'
    show RestaurantTimeStatusBool, StringExtensions;
import '../config/string_constants.dart' show FirestoreFields;
import 'position_model.dart';

@immutable
class RestaurantModel {
  final String id;
  final String name;
  final FilterEnum type;
  final double minimumOrder;
  final String deliveryTime;
  final List<dynamic> categories;
  final bool isNew;
  final bool featured;
  final bool recommended;
  final String mobile;
  final String email;
  final String street;
  final String city;
  final PositionModel position;
  final String ownerName;
  final String ownerMobile;
  final String ownerEmail;
  final String description;
  final String image;
  final bool status;
  final List<dynamic> likes;
  final double averageRating;
  final double totalRating;
  final int totalUsers;
  final int createdAt;
  final int updatedAt;
  final int totalDelivery;
  final String openingTime;
  final String closingTime;
  final bool isOpen;
  final double distance;
  final bool isClosed;
  final bool bestSeller;
  const RestaurantModel({
    required this.id,
    required this.name,
    required this.type,
    required this.minimumOrder,
    required this.deliveryTime,
    required this.categories,
    required this.isNew,
    required this.featured,
    required this.recommended,
    required this.mobile,
    required this.email,
    required this.street,
    required this.city,
    required this.position,
    required this.ownerName,
    required this.ownerMobile,
    required this.ownerEmail,
    required this.description,
    required this.image,
    required this.status,
    required this.likes,
    required this.averageRating,
    required this.totalRating,
    required this.totalUsers,
    required this.createdAt,
    required this.updatedAt,
    required this.totalDelivery,
    required this.openingTime,
    required this.closingTime,
    required this.isOpen,
    this.distance = 0,
    this.isClosed = false,
    this.bestSeller = false,
  });

  RestaurantModel copyWith({
    String? id,
    String? name,
    FilterEnum? type,
    double? minimumOrder,
    String? deliveryTime,
    List<dynamic>? categories,
    bool? isNew,
    bool? featured,
    bool? recommended,
    String? mobile,
    String? email,
    String? street,
    String? city,
    PositionModel? position,
    String? ownerName,
    String? ownerMobile,
    String? ownerEmail,
    String? description,
    String? image,
    bool? status,
    List<dynamic>? likes,
    double? averageRating,
    double? totalRating,
    int? totalUsers,
    int? createdAt,
    int? updatedAt,
    int? totalDelivery,
    String? openingTime,
    String? closingTime,
    bool? isOpen,
    double? distance,
    bool? isClosed,
    bool? bestSeller,
  }) =>
      RestaurantModel(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        minimumOrder: minimumOrder ?? this.minimumOrder,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        categories: categories ?? this.categories,
        isNew: isNew ?? this.isNew,
        featured: featured ?? this.featured,
        recommended: recommended ?? this.recommended,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        street: street ?? this.street,
        city: city ?? this.city,
        position: position ?? this.position,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        ownerMobile: ownerMobile ?? this.ownerMobile,
        ownerName: ownerName ?? this.ownerName,
        description: description ?? this.description,
        image: image ?? this.image,
        likes: likes ?? this.likes,
        status: status ?? this.status,
        averageRating: averageRating ?? this.averageRating,
        totalRating: totalRating ?? this.totalRating,
        totalUsers: totalUsers ?? this.totalUsers,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalDelivery: totalDelivery ?? this.totalDelivery,
        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        isOpen: isOpen ?? this.isOpen,
        distance: distance ?? this.distance,
        isClosed: isClosed ?? this.isClosed,
        bestSeller: bestSeller ?? this.bestSeller,
      );

  factory RestaurantModel.fromSnapshot(DocumentSnapshot snap) =>
      RestaurantModel(
        id: snap.id,
        name: (snap[FirestoreFields.name] as String).capitalize,
        type: convertToFilterType(snap[FirestoreFields.type]),
        minimumOrder: snap[FirestoreFields.minimumOrder].toDouble(),
        deliveryTime: snap[FirestoreFields.deliveryTime],
        categories: snap[FirestoreFields.categories],
        isNew: snap[FirestoreFields.isNew],
        featured: snap[FirestoreFields.featured],
        recommended: snap[FirestoreFields.recommended],
        mobile: snap[FirestoreFields.mobile],
        email: snap[FirestoreFields.email],
        street: snap[FirestoreFields.street],
        city: snap[FirestoreFields.city],
        position: PositionModel.fromSnapshot(snap[FirestoreFields.position]),
        ownerEmail: snap[FirestoreFields.ownerEmail],
        ownerMobile: snap[FirestoreFields.ownerMobile],
        ownerName: snap[FirestoreFields.ownerName],
        description: snap[FirestoreFields.description],
        image: snap[FirestoreFields.image],
        likes: snap[FirestoreFields.likes],
        status: snap[FirestoreFields.status],
        averageRating: snap[FirestoreFields.averageRating].toDouble(),
        totalRating: snap[FirestoreFields.totalRating].toDouble(),
        totalUsers: snap[FirestoreFields.totalUsers],
        createdAt: snap[FirestoreFields.createdAt],
        updatedAt: snap[FirestoreFields.updatedAt],
        totalDelivery: snap[FirestoreFields.totalDelivery],
        openingTime: snap[FirestoreFields.openingTime],
        closingTime: snap[FirestoreFields.closingTime],
        isOpen: (snap[FirestoreFields.openingTime] as String)
            .getRestaurantStatusBool(snap[FirestoreFields.closingTime]),
        isClosed: snap.data().toString().contains(FirestoreFields.isClosed)
            ? snap[FirestoreFields.isClosed]
            : false,
        bestSeller: snap.data().toString().contains(FirestoreFields.bestSeller)
            ? snap[FirestoreFields.bestSeller]
            : false,
      );

  @override
  String toString() =>
      'RestaurantModel(id: $id, name: $name, type: $type, minimumOrder: $minimumOrder, deliveryTime: $deliveryTime, categories: $categories, isNew: $isNew, featured: $featured, recommended: $recommended, mobile: $mobile, email: $email, street: $street, city: $city, position: $position, ownerName: $ownerName, ownerMobile: $ownerMobile, ownerEmail: $ownerEmail, description: $description, image: $image, status: $status, likes: $likes, averageRating: $averageRating, totalRating: $totalRating, totalUsers: $totalUsers, createdAt: $createdAt, updatedAt: $updatedAt, totalDelivery: $totalDelivery, openingTime: $openingTime, closingTime: $closingTime, isOpen: $isOpen, distance: $distance, isClosed: $isClosed, bestSeller: $bestSeller)';

  @override
  bool operator ==(covariant RestaurantModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.minimumOrder == minimumOrder &&
        other.deliveryTime == deliveryTime &&
        listEquals(other.categories, categories) &&
        other.isNew == isNew &&
        other.featured == featured &&
        other.recommended == recommended &&
        other.mobile == mobile &&
        other.email == email &&
        other.street == street &&
        other.city == city &&
        other.position == position &&
        other.ownerName == ownerName &&
        other.ownerMobile == ownerMobile &&
        other.ownerEmail == ownerEmail &&
        other.description == description &&
        other.image == image &&
        other.status == status &&
        listEquals(other.likes, likes) &&
        other.averageRating == averageRating &&
        other.totalRating == totalRating &&
        other.totalUsers == totalUsers &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.totalDelivery == totalDelivery &&
        other.openingTime == openingTime &&
        other.closingTime == closingTime &&
        other.isOpen == isOpen &&
        other.distance == distance &&
        other.isClosed == isClosed &&
        other.bestSeller == bestSeller;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      type.hashCode ^
      minimumOrder.hashCode ^
      deliveryTime.hashCode ^
      categories.hashCode ^
      isNew.hashCode ^
      featured.hashCode ^
      recommended.hashCode ^
      mobile.hashCode ^
      email.hashCode ^
      street.hashCode ^
      city.hashCode ^
      position.hashCode ^
      ownerName.hashCode ^
      ownerMobile.hashCode ^
      ownerEmail.hashCode ^
      description.hashCode ^
      image.hashCode ^
      status.hashCode ^
      likes.hashCode ^
      averageRating.hashCode ^
      totalRating.hashCode ^
      totalUsers.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      totalDelivery.hashCode ^
      openingTime.hashCode ^
      closingTime.hashCode ^
      isOpen.hashCode ^
      distance.hashCode ^
      isClosed.hashCode ^
      bestSeller.hashCode;
}
