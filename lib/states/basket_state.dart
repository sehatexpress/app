import 'package:flutter/foundation.dart' show immutable;

import '../config/enums.dart' show OrderStatusEnum;
import '../models/address_model.dart';
import '../models/basket_item.dart';
import '../models/order_model.dart';
import '../models/setting_model.dart';
import '../models/voucher_model.dart';

@immutable
class BasketState {
  final SettingModel? setting;
  final List<OrderModel> orders;
  final VoucherModel? voucher;
  final List<BasketItem> items;
  final double? tip;
  final AddressModel? address;
  final double deliveryDistance;
  final bool defaultConfirmed;

  const BasketState({
    this.setting,
    this.orders = const [],
    this.voucher,
    this.items = const [],
    this.tip = 0,
    this.address,
    this.deliveryDistance = 0,
    this.defaultConfirmed = false,
  });

  BasketState copyWith({
    SettingModel? setting,
    List<OrderModel>? orders,
    VoucherModel? voucher,
    List<BasketItem>? items,
    double? tip,
    AddressModel? address,
    double? deliveryDistance,
    bool? defaultConfirmed,
  }) =>
      BasketState(
        setting: setting ?? this.setting,
        orders: orders ?? this.orders,
        voucher: voucher ?? this.voucher,
        items: items ?? this.items,
        tip: tip ?? this.tip,
        address: address ?? this.address,
        deliveryDistance: deliveryDistance ?? this.deliveryDistance,
        defaultConfirmed: defaultConfirmed ?? this.defaultConfirmed,
      );

  double get subTotal => items.fold(
      0, (total, current) => total + (current.sellingPrice * current.quantity));
  String get subTotalString => subTotal.toStringAsFixed(2);
  String get totalString => total(subTotal).toStringAsFixed(2);
  int get _unCancelledOrders =>
      orders.where((order) => order.status != OrderStatusEnum.cancelled).length;

  double get discount {
    if (voucher != null) {
      if (voucher!.type == '%') {
        final x = subTotal * (voucher!.value / 100);
        return x <= voucher!.upto ? x : voucher!.upto;
      } else {
        return voucher!.value;
      }
    }
    return 0;
  }

  double get baseDeliveryCharge =>
      setting != null ? setting!.baseDeliveryCharge : 40;
  int get baseDeliveryKM => setting != null ? setting!.baseDeliveryKM : 2;
  double get deliveryPerKM => setting != null ? setting!.perKM : 20;
  int get freeDelivery => setting != null ? setting!.freeDelivery : 0;
  int get freeDeliveryKM => setting != null ? setting!.freeDeliveryKM : 0;
  double get minimumOrder => setting != null ? setting!.minimumOrder : 499;

  double get deliveryCharge {
    if (freeDelivery > _unCancelledOrders) {
      if (deliveryDistance <= freeDeliveryKM) {
        if (subTotal > minimumOrder) {
          return 0;
        } else {
          return baseDeliveryCharge;
        }
      } else {
        var remaining = deliveryDistance - freeDeliveryKM;
        return (remaining * deliveryPerKM) + baseDeliveryCharge;
      }
    } else {
      if (deliveryDistance > baseDeliveryKM) {
        var remaining = deliveryDistance - baseDeliveryKM;
        return (remaining * deliveryPerKM) + baseDeliveryCharge;
      } else {
        return baseDeliveryCharge;
      }
    }
  }

  double total(double subTotal) {
    final ttl = subTotal + deliveryCharge + (tip ?? 0);
    return ttl - discount;
  }
}
