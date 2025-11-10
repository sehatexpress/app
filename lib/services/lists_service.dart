import 'package:flutter/foundation.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import '../config/extensions.dart' show StringExtensions;
import '../config/string_constants.dart' show CollectionConstants, Fields;
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

final _banners = CollectionConstants.banners;
final _categories = CollectionConstants.categories;
final _products = CollectionConstants.products;

@immutable
class ListsService {
  final String? city;
  const ListsService(this.city);

  // 🔹 Get list of banner images (optimized with .withConverter)
  Stream<List<BannerModel>> getAllBanners() {
    if (city == null) return Stream.value([]);

    final finalCity = city!.translatedCity.toLowerCase();
    return _banners
        .where(Fields.city, isEqualTo: finalCity)
        .orderBy(Fields.createdAt, descending: true)
        .withConverter<BannerModel>(
          fromFirestore: (doc, _) => BannerModel.fromSnapshot(doc),
          toFirestore: (model, _) => {},
        )
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream()
        .handleError((e) => throw e.firebaseErrorMessage);
  }

  // 🔹 Get category lists (optimized with .withConverter)
  Stream<List<CategoryModel>> getCategories() {
    if (city == null) return Stream.value([]);

    final finalCity = city!.translatedCity.toLowerCase();
    return _categories
        .where(Fields.cities, arrayContains: finalCity)
        .where(Fields.status, isEqualTo: true)
        .withConverter<CategoryModel>(
          fromFirestore: (doc, _) => CategoryModel.fromSnapshot(doc),
          toFirestore: (model, _) => {},
        )
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream()
        .handleError((e) => throw e.firebaseErrorMessage);
  }

  // 🔹 Get list of products by restaurant (optimized sorting)
  Stream<List<ProductModel>> getAllProductsByRestaurant(String id) {
    return _products
        .where(Fields.restaurantId, isEqualTo: id)
        .where(Fields.status, isEqualTo: true)
        // .orderBy(FirestoreFields.sold, descending: true)
        .withConverter<ProductModel>(
          fromFirestore: (doc, _) => ProductModel.fromSnapshot(doc),
          toFirestore: (model, _) => {},
        )
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream()
        .handleError((e) => throw e.firebaseErrorMessage);
  }
}

final listServiceProvider = Provider.family<ListsService, String?>(
  (_, city) => ListsService(city),
);
