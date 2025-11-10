import 'package:flutter/foundation.dart' show immutable;

import '../config/enums.dart' show FilterEnum, convertToFilterType;
import '../config/extensions.dart' show FilterEnumValue;
import '../config/string_constants.dart' show Fields;
import 'product_model.dart';

@immutable
class BasketItem {
  final String id;
  final String name;
  final String image;
  final String category;
  final double commission;
  final String commissionType;
  final double price;
  final int quantity;
  final String description;
  final FilterEnum type;
  const BasketItem({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.commission,
    required this.commissionType,
    required this.price,
    required this.quantity,
    required this.description,
    required this.type,
  });

  BasketItem copyWith({
    String? id,
    String? name,
    String? image,
    String? category,
    double? commission,
    String? commissionType,
    double? price,
    int? quantity,
    String? description,
    FilterEnum? type,
  }) => BasketItem(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    category: category ?? this.category,
    commission: commission ?? this.commission,
    commissionType: commissionType ?? this.commissionType,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    description: description ?? this.description,
    type: type ?? this.type,
  );

  Map<String, dynamic> toDocument() => {
    Fields.id: id,
    Fields.name: name,
    Fields.image: image,
    Fields.category: category,
    Fields.commission: commission,
    Fields.commissionType: commissionType,
    Fields.sellingPrice: price,
    Fields.quantity: quantity,
    Fields.description: description,
    Fields.type: type.type,
  };

  factory BasketItem.fromProduct(ProductModel snap) => BasketItem(
    id: snap.id,
    name: snap.name,
    image: snap.image,
    category: snap.category,
    commission: snap.commission,
    commissionType: snap.commissionType,
    price: snap.price,
    quantity: 1,
    description: snap.description!,
    type: snap.type,
  );

  factory BasketItem.fromSnapshot(Map<String, dynamic> snap) => BasketItem(
    id: snap[Fields.id],
    name: snap[Fields.name],
    image: snap[Fields.image],
    category: snap[Fields.category],
    commission: snap[Fields.commission],
    commissionType: snap[Fields.commissionType],
    price: snap.toString().contains(Fields.sellingPrice)
        ? snap[Fields.sellingPrice]
        : snap[Fields.price],
    quantity: snap[Fields.quantity],
    description: snap.toString().contains(Fields.description)
        ? snap[Fields.description]
        : '',
    type: convertToFilterType(snap[Fields.type]),
  );

  @override
  String toString() =>
      'BasketItem(id: $id, name: $name, image: $image, category: $category, commission: $commission, commissionType: $commissionType, sellingPrice: $price, quantity: $quantity, description: $description, type: $type)';

  @override
  bool operator ==(covariant BasketItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.category == category &&
        other.commission == commission &&
        other.commissionType == commissionType &&
        other.price == price &&
        other.quantity == quantity &&
        other.description == description &&
        other.type == type;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      category.hashCode ^
      commission.hashCode ^
      commissionType.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      description.hashCode ^
      type.hashCode;
}
