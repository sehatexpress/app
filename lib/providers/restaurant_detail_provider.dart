import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/restaurant_service.dart';
import '../states/restaurant_detail_state.dart';

final restaurantDetailProvider = StateNotifierProvider.family<
    RestaurantDetailNotifier, RestaurantDetailState, String>(
  (ref, restaurantId) => RestaurantDetailNotifier(ref, restaurantId),
);

final _restaurantService = RestaurantService();

class RestaurantDetailNotifier extends StateNotifier<RestaurantDetailState> {
  final Ref ref;
  final String restaurantId;

  RestaurantDetailNotifier(this.ref, this.restaurantId)
      : super(RestaurantDetailState.initial()) {
    _fetchRestaurantDetails();
  }

  void _fetchRestaurantDetails() {
    // Listen to restaurant stream by ID
    _restaurantService.getSingleRestaurant(restaurantId).listen(
      (restaurant) {
        state = state.copyWith(restaurant: restaurant, loading: false);
      },
      onError: (err) {
        state = state.copyWith(
          error: err.toString(),
          loading: false,
        );
      },
    );

    // Listen to menu items stream by restaurant ID
    _restaurantService.getAllProductsByRestaurant(restaurantId).listen(
      (items) {
        state = state.copyWith(items: items, loading: false);
      },
      onError: (err) {
        state = state.copyWith(
          error: err.toString(),
          loading: false,
        );
      },
    );
  }

  void updateSearch(String val) => state = state.copyWith(search: val);
  void clear() => state = RestaurantDetailState.initial();
}
