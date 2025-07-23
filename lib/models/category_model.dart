import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CategoryModel {
  final String id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory CategoryModel.fromSnapshot(DocumentSnapshot snap) => CategoryModel(
        id: snap.id,
        name: snap['name'],
        image: snap['image'],
      );

  @override
  String toString() => 'CategoryModel(id: $id, name: $name, image: $image)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
