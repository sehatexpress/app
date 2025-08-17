import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show listEquals, immutable;

import '../config/enums.dart' show FilterEnum;
import '../config/extensions.dart' show StringExtensions, DateTimeExtensions;
import '../config/string_constants.dart' show FirestoreFields;

@immutable
class ProductModel {
  final String id;
  final String restaurantId;
  final String name;
  final FilterEnum type;
  final String category;
  final String image;
  final double price;
  final String commissionType;
  final double commission;
  final bool featured;
  final bool newProduct;
  final bool recommended;
  final double averageRating;
  final int totalUsers;
  final List<dynamic>? likes;
  final int sold;
  final bool status;
  final String createdAt;
  final String? updatedAt;
  final String? description;
  final bool bestSeller;

  const ProductModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.type,
    required this.category,
    required this.image,
    required this.price,
    required this.commissionType,
    required this.commission,
    required this.featured,
    required this.newProduct,
    required this.recommended,
    required this.averageRating,
    required this.totalUsers,
    this.likes = const [],
    this.sold = 0,
    this.status = true,
    required this.createdAt,
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
    String? commissionType,
    double? commission,
    bool? featured,
    bool? newProduct,
    bool? recommended,
    double? averageRating,
    int? totalUsers,
    List<dynamic>? likes,
    int? sold,
    bool? status,
    String? createdAt,
    String? updatedAt,
    bool? bestSeller,
  }) => ProductModel(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    name: name ?? this.name,
    type: type ?? this.type,
    category: category ?? this.category,
    image: image ?? this.image,
    price: price ?? this.price,
    commissionType: commissionType ?? this.commissionType,
    commission: commission ?? this.commission,
    featured: featured ?? this.featured,
    newProduct: newProduct ?? this.newProduct,
    recommended: recommended ?? this.recommended,
    averageRating: averageRating ?? this.averageRating,
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
    type: snap[FirestoreFields.type] == 'veg'
        ? FilterEnum.veg
        : FilterEnum.nonVeg,
    category: snap[FirestoreFields.category],
    image: snap[FirestoreFields.image],
    price: snap[FirestoreFields.sellingPrice].toDouble(),
    commissionType: snap[FirestoreFields.commissionType],
    commission: snap[FirestoreFields.commission].toDouble(),
    featured: snap[FirestoreFields.featured],
    newProduct: snap[FirestoreFields.newProduct],
    recommended: snap[FirestoreFields.recommended],
    averageRating: snap[FirestoreFields.averageRating].toDouble(),
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
      'ProductModel(id: $id, restaurantId: $restaurantId, name: $name, type: $type, category: $category, image: $image, sellingPrice: $price, commissionType: $commissionType, commission: $commission, featured: $featured, newProduct: $newProduct, recommended: $recommended, averageRating: $averageRating, totalUsers: $totalUsers, likes: $likes, sold: $sold, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, bestSeller: $bestSeller)';

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
        other.commissionType == commissionType &&
        other.commission == commission &&
        other.featured == featured &&
        other.newProduct == newProduct &&
        other.recommended == recommended &&
        other.averageRating == averageRating &&
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
      commissionType.hashCode ^
      commission.hashCode ^
      featured.hashCode ^
      newProduct.hashCode ^
      recommended.hashCode ^
      averageRating.hashCode ^
      totalUsers.hashCode ^
      likes.hashCode ^
      sold.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      description.hashCode ^
      bestSeller.hashCode;
}

final List<ProductModel> sampleProducts = [
  ProductModel(
    id: 'p1',
    restaurantId: 'r1',
    name: 'Margherita Pizza',
    type: FilterEnum.veg,
    category: 'Pizza',
    image:
        'https://images.unsplash.com/photo-1604908177522-7f3f62e4f523?auto=format&fit=crop&w=800&q=80',
    price: 8.99,
    commissionType: 'percentage',
    commission: 5,
    featured: true,
    newProduct: false,
    recommended: true,
    averageRating: 4.5,
    totalUsers: 120,
    createdAt: DateTimeExtensions.nowLocal,
    description:
        'Classic Margherita pizza with fresh tomatoes and mozzarella cheese',
    bestSeller: true,
  ),
  ProductModel(
    id: 'p2',
    restaurantId: 'r1',
    name: 'Pepperoni Pizza',
    type: FilterEnum.nonVeg,
    category: 'Pizza',
    image:
        'https://images.unsplash.com/photo-1603074513981-f644a8d0b84f?auto=format&fit=crop&w=800&q=80',
    price: 10.99,
    commissionType: 'percentage',
    commission: 5,
    featured: false,
    newProduct: true,
    recommended: true,
    averageRating: 4.7,
    totalUsers: 95,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Delicious Pepperoni pizza with mozzarella and tomato sauce',
  ),
  ProductModel(
    id: 'p3',
    restaurantId: 'r2',
    name: 'Veg Burger',
    type: FilterEnum.veg,
    category: 'Burger',
    image:
        'https://images.unsplash.com/photo-1605470280919-8bde98f6df2d?auto=format&fit=crop&w=800&q=80',
    price: 5.49,
    commissionType: 'fixed',
    commission: 1,
    featured: true,
    newProduct: false,
    recommended: true,
    averageRating: 4.2,
    totalUsers: 80,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Fresh vegetable burger with lettuce, tomato, and cheese',
  ),
  ProductModel(
    id: 'p4',
    restaurantId: 'r2',
    name: 'Chicken Burger',
    type: FilterEnum.nonVeg,
    category: 'Burger',
    image:
        'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=800&q=80',
    price: 6.99,
    commissionType: 'percentage',
    commission: 5,
    featured: false,
    newProduct: true,
    recommended: true,
    averageRating: 4.6,
    totalUsers: 110,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Grilled chicken burger with fresh lettuce and cheese',
    bestSeller: true,
  ),
  ProductModel(
    id: 'p5',
    restaurantId: 'r3',
    name: 'Veg Sandwich',
    type: FilterEnum.veg,
    category: 'Sandwich',
    image:
        'https://images.unsplash.com/photo-1600891964042-d66b2f2da0b4?auto=format&fit=crop&w=800&q=80',
    price: 4.49,
    commissionType: 'fixed',
    commission: 0.5,
    featured: false,
    newProduct: true,
    recommended: false,
    averageRating: 4.1,
    totalUsers: 60,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Fresh vegetable sandwich with sauces',
  ),
  ProductModel(
    id: 'p6',
    restaurantId: 'r3',
    name: 'Chicken Sandwich',
    type: FilterEnum.nonVeg,
    category: 'Sandwich',
    image:
        'https://images.unsplash.com/photo-1600891964042-d66b2f2da0b4?auto=format&fit=crop&w=800&q=80',
    price: 5.99,
    commissionType: 'percentage',
    commission: 3,
    featured: true,
    newProduct: false,
    recommended: true,
    averageRating: 4.4,
    totalUsers: 75,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Grilled chicken sandwich with fresh lettuce and sauces',
  ),
  ProductModel(
    id: 'p7',
    restaurantId: 'r1',
    name: 'French Fries',
    type: FilterEnum.veg,
    category: 'Sides',
    image:
        'https://images.unsplash.com/photo-1603074513981-f644a8d0b84f?auto=format&fit=crop&w=800&q=80',
    price: 2.99,
    commissionType: 'fixed',
    commission: 0.2,
    featured: false,
    newProduct: false,
    recommended: true,
    averageRating: 4.2,
    totalUsers: 100,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Crispy golden French fries',
  ),
  ProductModel(
    id: 'p8',
    restaurantId: 'r2',
    name: 'Coke',
    type: FilterEnum.veg,
    category: 'Drink',
    image:
        'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=800&q=80',
    price: 1.99,
    commissionType: 'fixed',
    commission: 0.1,
    featured: false,
    newProduct: false,
    recommended: true,
    averageRating: 4.6,
    totalUsers: 150,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Chilled Coca-Cola drink',
  ),
  ProductModel(
    id: 'p9',
    restaurantId: 'r3',
    name: 'Veg Wrap',
    type: FilterEnum.veg,
    category: 'Wrap',
    image:
        'https://images.unsplash.com/photo-1605470280919-8bde98f6df2d?auto=format&fit=crop&w=800&q=80',
    price: 4.99,
    commissionType: 'fixed',
    commission: 0.5,
    featured: false,
    newProduct: true,
    recommended: false,
    averageRating: 4.0,
    totalUsers: 40,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Healthy veg wrap with sauces',
  ),
  ProductModel(
    id: 'p10',
    restaurantId: 'r2',
    name: 'Chicken Wrap',
    type: FilterEnum.nonVeg,
    category: 'Wrap',
    image:
        'https://images.unsplash.com/photo-1603074513981-f644a8d0b84f?auto=format&fit=crop&w=800&q=80',
    price: 6.49,
    commissionType: 'percentage',
    commission: 4,
    featured: true,
    newProduct: false,
    recommended: true,
    averageRating: 4.5,
    totalUsers: 85,
    createdAt: DateTimeExtensions.nowLocal,
    description: 'Grilled chicken wrap with fresh vegetables',
    bestSeller: true,
  ),
];
