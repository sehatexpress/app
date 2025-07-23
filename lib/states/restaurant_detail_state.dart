import 'package:flutter/foundation.dart' show immutable;

import '../models/product_model.dart';
import '../models/reataurant_model.dart';

@immutable
class RestaurantDetailState {
  final RestaurantModel? restaurant;
  final List<ProductModel> items;
  final String? search;
  final bool loading;
  final String? error;
  const RestaurantDetailState({
    this.restaurant,
    this.items = const [],
    this.search,
    this.loading = true,
    this.error,
  });

  RestaurantDetailState copyWith({
    RestaurantModel? restaurant,
    List<ProductModel>? items,
    String? search,
    bool? loading,
    String? error,
  }) =>
      RestaurantDetailState(
        restaurant: restaurant ?? this.restaurant,
        items: items ?? this.items,
        search: search ?? this.search,
        loading: loading ?? this.loading,
        error: error ?? this.error,
      );
  const RestaurantDetailState.initial()
      : restaurant = null,
        items = const [],
        search = '',
        loading = true,
        error = null;
}
