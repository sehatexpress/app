import 'package:hooks_riverpod/hooks_riverpod.dart' show StreamProvider;

import '../models/address_model.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/comment_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/query_model.dart';
import '../models/reataurant_model.dart';
import '../models/user_model.dart';
import '../services/address_service.dart';
import '../services/lists_service.dart';
import '../services/order_service.dart';
import '../services/query_service.dart';
import '../services/restaurant_service.dart';
import '../services/setting_service.dart';
import '../services/user_service.dart';
import 'auth_provider.dart' show authUidProvider;
import 'location_provider.dart' show locationProvider;

// 🔹 City settings list
final citySettingsListProvider = StreamProvider((ref) {
  return ref.read(settingServiceProvider).getCitySettingsList();
});

// 🔹 User-specific providers
final ordersListProvider = StreamProvider<List<OrderModel>>((ref) {
  ref.keepAlive();
  return ref.read(orderServiceProvider).getOrdersStream();
});

final addressListProvider = StreamProvider<List<AddressModel>>((ref) {
  ref.keepAlive();
  final userId = ref.watch(authUidProvider);
  return userId != null
      ? ref.watch(addressServiceProvider).getAddress(userId)
      : Stream.value([]);
});

final userDetailProvider = StreamProvider<UserModel?>((ref) {
  ref.keepAlive();
  final uid = ref.watch(authUidProvider);
  return uid != null
      ? ref.watch(userServiceProvider).getUserStreamDetail(uid)
      : Stream.value(null);
});

// 🔹 Restaurant-related providers
final restaurantListByCityProvider =
    StreamProvider<List<RestaurantModel>>((ref) {
  ref.keepAlive();
  final city = ref.watch(locationProvider.select((state) => state.city));
  return city != null
      ? ref.watch(restaurantServiceProvider).getAllRestaurantsListByCity(city)
      : Stream.value([]);
});

final favouriteRestaurantListProvider =
    StreamProvider<List<RestaurantModel>>((ref) {
  ref.keepAlive();
  final uid = ref.watch(authUidProvider);
  return uid != null
      ? ref.watch(restaurantServiceProvider).getFavouriteRestaurants(uid)
      : Stream.value([]);
});

final singleRestaurantListByCityProvider = StreamProvider.family
    .autoDispose<RestaurantModel, String>((ref, restaurantId) {
  return ref.watch(restaurantServiceProvider).getSingleRestaurant(restaurantId);
});

// 🔹 Product & Category providers
final categoriesListProvider = StreamProvider<List<CategoryModel>>((ref) {
  ref.keepAlive();
  final city = ref.watch(locationProvider.select((state) => state.city));
  return city != null
      ? ref.watch(listServiceProvider(city)).getCategories()
      : Stream.value([]);
});

final productsListByRestaurantProvider = StreamProvider.family
    .autoDispose<List<ProductModel>, String>((ref, restaurantId) {
  return ref
      .watch(listServiceProvider(null))
      .getAllProductsByRestaurant(restaurantId);
});

// 🔹 Banner list
final bannerListProvider = StreamProvider<List<BannerModel>>((ref) {
  ref.keepAlive();
  final city = ref.watch(locationProvider.select((state) => state.city));
  return city != null
      ? ref.watch(listServiceProvider(city)).getAllBanners()
      : Stream.value([]);
});

// 🔹 Query & Comment providers (Now correctly using userId)
final queryListProvider = StreamProvider<List<QueryModel>>((ref) {
  ref.keepAlive();
  final uid = ref.watch(authUidProvider);
  return uid != null
      ? ref.watch(queryServiceProvider(uid)).getAllQueries()
      : Stream.value([]);
});

final queryCommentsListProvider = StreamProvider.family
    .autoDispose<List<CommentModel>, String>((ref, queryId) {
  final uid = ref.watch(authUidProvider);
  return uid != null
      ? ref.watch(queryServiceProvider(uid)).getListOfComments(queryId)
      : Stream.value([]);
});
