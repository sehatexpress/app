import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart' show StringExtensions;
import '../providers/auth_provider.dart' show authUidProvider;
import '../config/string_constants.dart' show Strings;
import '../providers/global_provider.dart' show globalProvider;
import '../providers/location_provider.dart' show locationProvider;
import '../models/order_model.dart';
import '../models/reataurant_model.dart';
import '../services/geo_position_service.dart';
import '../services/notification_service.dart';
import '../services/order_service.dart';
import '../models/address_model.dart';
import '../models/basket_item.dart';
import '../models/product_model.dart';
import '../models/voucher_model.dart';
import '../services/location_service.dart';
import '../states/basket_state.dart';
import 'lists_provider.dart'
    show citySettingsListProvider, ordersListProvider, userDetailProvider;

final basketProvider =
    StateNotifierProvider<BasketNotifier, BasketState>((ref) {
  return BasketNotifier(ref);
});

class BasketNotifier extends StateNotifier<BasketState> {
  final Ref ref;

  BasketNotifier(this.ref) : super(BasketState()) {
    final providerCity = ref.watch(locationProvider.select((x) => x.city));
    final city = providerCity?.translatedCity.toUpperCase();
    final orders = ref.watch(ordersListProvider).value ?? [];
    final setting = ref
        .watch(citySettingsListProvider)
        .value
        ?.firstWhereOrNull((e) => e.id == city);
    state = state.copyWith(orders: orders, setting: setting);
  }

  void init(RestaurantModel restaurant, ProductModel product) {
    state = state.copyWith(
      restaurant: restaurant,
      items: [BasketItem.fromProduct(product)],
    );
  }

  void updateDefaultConfirmed(bool? value) =>
      state = state.copyWith(defaultConfirmed: value ?? false);

  void clearBasket() => state = BasketState();

  int get itemCount => state.items.length;

  void updateItemQuantity(String id, {int quantityChange = 1}) {
    final updatedItems = List<BasketItem>.from(state.items);
    final index = updatedItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final newQuantity = updatedItems[index].quantity + quantityChange;
      if (newQuantity > 0) {
        updatedItems[index] =
            updatedItems[index].copyWith(quantity: newQuantity);
      } else {
        updatedItems.removeAt(index);
      }
    }
    state = state.copyWith(items: updatedItems);
  }

  void addItem(ProductModel product) {
    final existingItem =
        state.items.firstWhereOrNull((item) => item.id == product.id);
    final updatedItems = existingItem != null
        ? state.items
            .map((item) => item.id == product.id
                ? item.copyWith(quantity: item.quantity + 1)
                : item)
            .toList()
        : [...state.items, BasketItem.fromProduct(product)];

    state = state.copyWith(items: updatedItems);
  }

  void applyTip(double? tip) => state = state.copyWith(tip: tip ?? 0);

  void applyVoucher(VoucherModel? voucher) =>
      state = state.copyWith(voucher: voucher);

  void selectAddress(AddressModel? address) {
    state = state.copyWith(address: address);
    if (address != null && state.restaurant != null) {
      _fetchDeliveryDistance();
    }
  }

  Future<void> _fetchDeliveryDistance() async {
    final globalNotifier = ref.read(globalProvider.notifier);
    try {
      globalNotifier.updateLoading(true);
      final origin =
          '${state.restaurant!.position.geopoint.latitude},${state.restaurant!.position.geopoint.longitude}';
      final destination =
          '${state.address!.position.geopoint.latitude},${state.address!.position.geopoint.longitude}';
      final distance = await ref
          .read(locationServiceProvider)
          .getDeliveryDistance(origin, destination);
      state = state.copyWith(deliveryDistance: distance);
    } catch (e) {
      globalNotifier.updateMessage(e.toString());
    } finally {
      globalNotifier.updateLoading(false);
    }
  }

  Future<void> placeOrder(OrderModel order) async {
    final globalNotifier = ref.read(globalProvider.notifier);
    final uid = ref.read(authUidProvider);
    if (uid == null) throw Strings.loginBeforeProceeding;
    try {
      globalNotifier.updateLoading(true);
      await ref.read(orderServiceProvider).placeOrder(order);
      if (!kIsWeb) {
        notificationService.sendLocalNotification(
          'Order Placed',
          'Hurray, your order has been placed successfully. Tap for more info.',
        );
      }
      globalNotifier.setOrderPlaced(true);
      clear();
    } catch (e) {
      globalNotifier.updateMessage(e.toString());
    } finally {
      globalNotifier.updateLoading(false);
    }
  }

  Future<void> useCurrentLocation() async {
    final globalNotifier = ref.read(globalProvider.notifier);
    final auth = ref.read(userDetailProvider).value;
    if (auth == null) throw Strings.loginBeforeProceeding;
    try {
      globalNotifier.updateLoading(true);
      var cords = await GeolocatorPlatform.instance.getCurrentPosition();
      var position = await geoPositionService.getPosition(
        latitude: cords.latitude,
        longitude: cords.longitude,
      );
      var location = await ref.read(locationServiceProvider).getAddress(
            cords.latitude,
            cords.longitude,
          );
      AddressModel address = AddressModel(
        name: auth.name,
        mobile: auth.mobile,
        street: location.displayName,
        position: position,
      );
      selectAddress(address);
    } catch (e) {
      globalNotifier.updateMessage(e.toString());
    } finally {
      globalNotifier.updateLoading(false);
    }
  }

  /// clear basket
  void clear() => state = state.copyWith(
        voucher: null,
        items: [],
        restaurant: null,
        tip: 0,
      );
}
