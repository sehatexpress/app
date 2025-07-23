import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/foundation.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler, StringExtensions;
import '../config/string_constants.dart'
    show CollectionConstants, FirestoreFields, Strings;
import '../models/product_model.dart';
import '../models/reataurant_model.dart';

final restaurantRef = CollectionConstants.restaurants;
final productRef = CollectionConstants.products;

@immutable
class RestaurantService {
  const RestaurantService();

  // get all restaurants in that area
  Stream<List<RestaurantModel>> getAllRestaurantsListByCity(String city) {
    try {
      final finalCity = city.translatedCity.toLowerCase();
      return restaurantRef
          .where(FirestoreFields.status, isEqualTo: true)
          .where(FirestoreFields.city, isEqualTo: finalCity)
          .snapshots()
          .map((docs) => docs.docs
              .map((doc) => RestaurantModel.fromSnapshot(doc))
              .toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get single restaurant
  Stream<RestaurantModel> getSingleRestaurant(String doc) {
    try {
      return restaurantRef
          .doc(doc)
          .snapshots()
          .map((x) => RestaurantModel.fromSnapshot(x));
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get list of favourite restaurants
  Stream<List<RestaurantModel>> getFavouriteRestaurants(String? uid) {
    try {
      return uid != null
          ? restaurantRef
              .where(FirestoreFields.status, isEqualTo: true)
              .where(FirestoreFields.likes, arrayContains: uid)
              .snapshots()
              .map((docs) => docs.docs
                  .map((doc) => RestaurantModel.fromSnapshot(doc))
                  .toList())
          : Stream.value([]);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // add / remove from favourites
  Future<String> addRemoveFromFavorite({
    required List<dynamic> likes,
    required String docId,
    required String uid,
  }) async {
    try {
      final restaurantDoc = restaurantRef.doc(docId);

      if (likes.contains(uid)) {
        await restaurantDoc.update({
          FirestoreFields.likes: FieldValue.arrayRemove([uid])
        });
        return Strings.removedfromFavourite;
      } else {
        await restaurantDoc.update({
          FirestoreFields.likes: FieldValue.arrayUnion([uid])
        });
        return Strings.addedTofavourite;
      }
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // list of products by restaurant ID
  Stream<List<ProductModel>> getAllProductsByRestaurant(String id) {
    try {
      return productRef
          .where(FirestoreFields.restaurantId, isEqualTo: id)
          .where(FirestoreFields.status, isEqualTo: true)
          .snapshots()
          .map((snapshot) {
        List<ProductModel> products =
            snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
        products.sort((a, b) => b.sold!.compareTo(a.sold!));
        return products;
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final restaurantServiceProvider = Provider((_) => RestaurantService());
