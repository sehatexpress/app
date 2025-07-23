import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show listEquals, immutable;

import '../config/enums.dart' show FilterEnum;
import '../config/extensions.dart' show StringExtensions;
import '../config/string_constants.dart' show FirestoreFields;

@immutable
class ProductModel {
  final String? id;
  final String restaurantId;
  final String name;
  final FilterEnum type;
  final String category;
  final String image;
  final double price;
  final double sellingPrice;
  final String commissionType;
  final double commission;
  final bool featured;
  final bool newProduct;
  final bool recommended;
  final double? averageRating;
  final double? totalRating;
  final int? totalUsers;
  final List<dynamic>? likes;
  final int? sold;
  final bool? status;
  final int? createdAt;
  final int? updatedAt;
  final String? description;
  final bool bestSeller;

  const ProductModel({
    this.id,
    required this.restaurantId,
    required this.name,
    required this.type,
    required this.category,
    required this.image,
    required this.price,
    required this.sellingPrice,
    required this.commissionType,
    required this.commission,
    required this.featured,
    required this.newProduct,
    required this.recommended,
    this.averageRating,
    this.totalRating,
    this.totalUsers,
    this.likes,
    this.sold,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.bestSeller = false,
  });

  ProductModel copyWith({
    String? id,
    String? restaurantId,
    String? name,
    FilterEnum? type,
    String? category,
    String? description,
    String? image,
    double? price,
    double? sellingPrice,
    String? commissionType,
    double? commission,
    bool? featured,
    bool? newProduct,
    bool? recommended,
    double? averageRating,
    double? totalRating,
    int? totalUsers,
    List<dynamic>? likes,
    int? sold,
    bool? status,
    int? createdAt,
    int? updatedAt,
    bool? bestSeller,
  }) =>
      ProductModel(
        id: id ?? this.id,
        restaurantId: restaurantId ?? this.restaurantId,
        name: name ?? this.name,
        type: type ?? this.type,
        category: category ?? this.category,
        image: image ?? this.image,
        price: price ?? this.price,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        commissionType: commissionType ?? this.commissionType,
        commission: commission ?? this.commission,
        featured: featured ?? this.featured,
        newProduct: newProduct ?? this.newProduct,
        recommended: recommended ?? this.recommended,
        averageRating: averageRating ?? this.averageRating,
        totalRating: totalRating ?? this.totalRating,
        totalUsers: totalUsers ?? this.totalUsers,
        likes: likes ?? this.likes,
        sold: sold ?? this.sold,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
        bestSeller: bestSeller ?? this.bestSeller,
      );

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) => ProductModel(
        id: snap.id,
        restaurantId: snap[FirestoreFields.restaurantId],
        name: (snap[FirestoreFields.name] as String).capitalize,
        type: snap[FirestoreFields.type] == 'veg' ? FilterEnum.veg : FilterEnum.nonVeg,
        category: snap[FirestoreFields.category],
        image: snap[FirestoreFields.image],
        price: snap[FirestoreFields.price].toDouble(),
        sellingPrice: snap[FirestoreFields.sellingPrice].toDouble(),
        commissionType: snap[FirestoreFields.commissionType],
        commission: snap[FirestoreFields.commission].toDouble(),
        featured: snap[FirestoreFields.featured],
        newProduct: snap[FirestoreFields.newProduct],
        recommended: snap[FirestoreFields.recommended],
        averageRating: snap[FirestoreFields.averageRating].toDouble(),
        totalRating: snap[FirestoreFields.totalRating].toDouble(),
        totalUsers: snap[FirestoreFields.totalUsers],
        likes: snap[FirestoreFields.likes],
        sold: snap[FirestoreFields.sold],
        status: snap[FirestoreFields.status],
        createdAt: snap[FirestoreFields.createdAt],
        updatedAt: snap[FirestoreFields.updatedAt],
        description: snap[FirestoreFields.description],
        bestSeller: snap.data().toString().contains(FirestoreFields.bestSeller)
            ? snap[FirestoreFields.bestSeller]
            : false,
      );

  @override
  String toString() =>
      'ProductModel(id: $id, restaurantId: $restaurantId, name: $name, type: $type, category: $category, image: $image, price: $price, sellingPrice: $sellingPrice, commissionType: $commissionType, commission: $commission, featured: $featured, newProduct: $newProduct, recommended: $recommended, averageRating: $averageRating, totalRating: $totalRating, totalUsers: $totalUsers, likes: $likes, sold: $sold, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, bestSeller: $bestSeller)';

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.restaurantId == restaurantId &&
        other.name == name &&
        other.type == type &&
        other.category == category &&
        other.image == image &&
        other.price == price &&
        other.sellingPrice == sellingPrice &&
        other.commissionType == commissionType &&
        other.commission == commission &&
        other.featured == featured &&
        other.newProduct == newProduct &&
        other.recommended == recommended &&
        other.averageRating == averageRating &&
        other.totalRating == totalRating &&
        other.totalUsers == totalUsers &&
        listEquals(other.likes, likes) &&
        other.sold == sold &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.description == description &&
        other.bestSeller == bestSeller;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      restaurantId.hashCode ^
      name.hashCode ^
      type.hashCode ^
      category.hashCode ^
      image.hashCode ^
      price.hashCode ^
      sellingPrice.hashCode ^
      commissionType.hashCode ^
      commission.hashCode ^
      featured.hashCode ^
      newProduct.hashCode ^
      recommended.hashCode ^
      averageRating.hashCode ^
      totalRating.hashCode ^
      totalUsers.hashCode ^
      likes.hashCode ^
      sold.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      description.hashCode ^
      bestSeller.hashCode;
}
