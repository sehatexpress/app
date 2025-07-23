import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show kIsWeb, listEquals, immutable;
import '../config/extensions.dart'
    show DateTimeExtensions, OrderStatusEnumExtension, OrderStatusValue;

import '../config/enums.dart' show OrderStatusEnum;
import '../config/string_constants.dart' show FirestoreFields;
import 'basket_item.dart';
import 'position_model.dart';

@immutable
class OrderModel {
  final String? id;
  final int orderOTP;

  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;
  final String restaurantCity;
  final String restaurantStreet;
  final String restaurantNumber;
  final PositionModel restaurantPosition;

  final String userId;
  final String userName;
  final String userEmail;
  final String? userPhoneNumber;

  final String deliveryAddressPersonName;
  final String deliveryAddressPersonPhoneNumber;
  final String deliveryAddressStreet;
  final PositionModel deliveryAddressPosition;

  final List<BasketItem> items;
  final num itemTotal;
  final num deliveryCharge;
  final num discount;
  final String? discountVoucherId;
  final String? discountVoucherCode;
  final num? tip;
  final num grandTotal;

  final String? deliveryPersonId;
  final String? deliveryPersonName;
  final String? deliveryPersonPhoneNumber;
  final String? deliveryPersonImage;
  final PositionModel? deliveryPersonPosition;

  final bool? progress;
  final OrderStatusEnum status;
  // ordered, accepted, confirmed, picked, delivered, cancelled
  final int? orderedDate;
  final int? acceptedDate;
  final int? confirmedDate;
  final int? pickedDate;
  final int? deliveredDate;
  final int? cancelledDate;
  final String? cancellationReason;
  final int? updatedDate;
  final String? date;

  final bool defaultConfirmed;
  const OrderModel({
    this.id,
    required this.orderOTP,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.restaurantCity,
    required this.restaurantStreet,
    required this.restaurantNumber,
    required this.restaurantPosition,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userPhoneNumber,
    required this.deliveryAddressPersonName,
    required this.deliveryAddressPersonPhoneNumber,
    required this.deliveryAddressStreet,
    required this.deliveryAddressPosition,
    required this.items,
    required this.itemTotal,
    required this.deliveryCharge,
    required this.discount,
    this.discountVoucherId,
    this.discountVoucherCode,
    this.tip,
    required this.grandTotal,
    this.deliveryPersonId,
    this.deliveryPersonName,
    this.deliveryPersonPhoneNumber,
    this.deliveryPersonImage,
    this.deliveryPersonPosition,
    this.progress,
    this.status = OrderStatusEnum.ordered,
    this.orderedDate,
    this.acceptedDate,
    this.confirmedDate,
    this.pickedDate,
    this.deliveredDate,
    this.cancelledDate,
    this.cancellationReason,
    this.updatedDate,
    this.date,
    this.defaultConfirmed = false,
  });

  OrderModel copyWith({
    String? id,
    int? orderOTP,
    String? restaurantId,
    String? restaurantName,
    String? restaurantImage,
    String? restaurantCity,
    String? restaurantStreet,
    String? restaurantNumber,
    PositionModel? restaurantPosition,
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
    String? deliveryAddressPersonName,
    String? deliveryAddressPersonPhoneNumber,
    String? deliveryAddressStreet,
    PositionModel? deliveryAddressPosition,
    List<BasketItem>? items,
    num? itemTotal,
    num? deliveryCharge,
    num? discount,
    String? discountVoucherId,
    String? discountVoucherCode,
    num? tip,
    num? grandTotal,
    String? deliveryPersonId,
    String? deliveryPersonName,
    String? deliveryPersonPhoneNumber,
    String? deliveryPersonImage,
    PositionModel? deliveryPersonPosition,
    bool? progress,
    OrderStatusEnum? status,
    int? orderedDate,
    int? acceptedDate,
    int? confirmedDate,
    int? pickedDate,
    int? deliveredDate,
    int? cancelledDate,
    int? updatedDate,
    String? cancellationReason,
    String? date,
    bool? defaultConfirmed,
  }) =>
      OrderModel(
        id: id ?? this.id,
        orderOTP: orderOTP ?? this.orderOTP,
        restaurantId: restaurantId ?? this.restaurantId,
        restaurantName: restaurantName ?? this.restaurantName,
        restaurantImage: restaurantImage ?? this.restaurantImage,
        restaurantCity: restaurantCity ?? this.restaurantCity,
        restaurantStreet: restaurantStreet ?? this.restaurantStreet,
        restaurantNumber: restaurantNumber ?? this.restaurantNumber,
        restaurantPosition: restaurantPosition ?? this.restaurantPosition,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
        deliveryAddressPersonName:
            deliveryAddressPersonName ?? this.deliveryAddressPersonName,
        deliveryAddressPersonPhoneNumber: deliveryAddressPersonPhoneNumber ??
            this.deliveryAddressPersonPhoneNumber,
        deliveryAddressStreet:
            deliveryAddressStreet ?? this.deliveryAddressStreet,
        deliveryAddressPosition:
            deliveryAddressPosition ?? this.deliveryAddressPosition,
        items: items ?? this.items,
        itemTotal: itemTotal ?? this.itemTotal,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        discount: discount ?? this.discount,
        discountVoucherId: discountVoucherId ?? this.discountVoucherId,
        discountVoucherCode: discountVoucherCode ?? this.discountVoucherCode,
        tip: tip ?? this.tip,
        grandTotal: grandTotal ?? this.grandTotal,
        deliveryPersonId: deliveryPersonId ?? this.deliveryPersonId,
        deliveryPersonName: deliveryPersonName ?? this.deliveryPersonName,
        deliveryPersonPhoneNumber:
            deliveryPersonPhoneNumber ?? this.deliveryPersonPhoneNumber,
        deliveryPersonImage: deliveryPersonImage ?? this.deliveryPersonImage,
        deliveryPersonPosition:
            deliveryPersonPosition ?? this.deliveryPersonPosition,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        orderedDate: orderedDate ?? this.orderedDate,
        acceptedDate: acceptedDate ?? this.acceptedDate,
        confirmedDate: confirmedDate ?? this.confirmedDate,
        pickedDate: pickedDate ?? this.pickedDate,
        deliveredDate: deliveredDate ?? this.deliveredDate,
        cancelledDate: cancelledDate ?? this.cancelledDate,
        cancellationReason: cancellationReason ?? this.cancellationReason,
        updatedDate: updatedDate ?? this.updatedDate,
        date: date ?? this.date,
        defaultConfirmed: defaultConfirmed ?? this.defaultConfirmed,
      );

  Map<String, dynamic> toDocument() => {
        FirestoreFields.orderOTP: orderOTP,
        FirestoreFields.restaurantId: restaurantId,
        FirestoreFields.restaurantName: restaurantName,
        FirestoreFields.restaurantImage: restaurantImage,
        FirestoreFields.restaurantCity: restaurantCity,
        FirestoreFields.restaurantStreet: restaurantStreet,
        FirestoreFields.restaurantNumber: restaurantNumber,
        FirestoreFields.restaurantPosition: restaurantPosition.toDocument(),
        FirestoreFields.userId: userId,
        FirestoreFields.userName: userName,
        FirestoreFields.userEmail: userEmail,
        FirestoreFields.userPhoneNumber: userPhoneNumber,
        FirestoreFields.deliveryAddressPersonName: deliveryAddressPersonName,
        FirestoreFields.deliveryAddressPersonPhoneNumber:
            deliveryAddressPersonPhoneNumber,
        FirestoreFields.deliveryAddressStreet: deliveryAddressStreet,
        FirestoreFields.deliveryAddressPosition:
            deliveryAddressPosition.toDocument(),
        FirestoreFields.items: items.map((e) => e.toDocument()).toList(),
        FirestoreFields.itemTotal: itemTotal,
        FirestoreFields.deliveryCharge: deliveryCharge,
        FirestoreFields.discount: discount,
        FirestoreFields.discountVoucherId: discountVoucherId,
        FirestoreFields.discountVoucherCode: discountVoucherCode,
        FirestoreFields.tip: tip,
        FirestoreFields.grandTotal: grandTotal,
        FirestoreFields.deliveryPersonId: null,
        FirestoreFields.deliveryPersonName: null,
        FirestoreFields.deliveryPersonPhoneNumber: null,
        FirestoreFields.deliveryPersonImage: null,
        FirestoreFields.deliveryPersonPosition: null,
        FirestoreFields.progress: false,
        FirestoreFields.status: OrderStatusEnum.ordered.value,
        FirestoreFields.orderedDate: DateTime.now().millisecondsSinceEpoch,
        FirestoreFields.acceptedDate: null,
        FirestoreFields.confirmedDate: null,
        FirestoreFields.pickedDate: null,
        FirestoreFields.deliveredDate: null,
        FirestoreFields.cancelledDate: null,
        FirestoreFields.cancellationReason: null,
        FirestoreFields.updatedDate: DateTime.now().millisecondsSinceEpoch,
        FirestoreFields.commission: 0,
        FirestoreFields.restaurantBalance: 0,
        FirestoreFields.deliveryPersonBalance: 0,
        FirestoreFields.date:
            DateTime.now().millisecondsSinceEpoch.formattedDate,
        FirestoreFields.platform: kIsWeb ? 'web' : 'mobile',
        FirestoreFields.defaultConfirmed: defaultConfirmed,
      };

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) => OrderModel(
        id: snap.id,
        orderOTP: snap[FirestoreFields.orderOTP],
        restaurantId: snap[FirestoreFields.restaurantId],
        restaurantName: snap[FirestoreFields.restaurantName],
        restaurantImage: snap[FirestoreFields.restaurantImage],
        restaurantCity: snap[FirestoreFields.restaurantCity],
        restaurantStreet: snap[FirestoreFields.restaurantStreet],
        restaurantNumber:
            snap.data().toString().contains(FirestoreFields.restaurantNumber)
                ? snap[FirestoreFields.restaurantNumber]
                : '9876543210',
        restaurantPosition: PositionModel.fromSnapshot(
            snap[FirestoreFields.restaurantPosition]),
        userId: snap[FirestoreFields.userId],
        userName: snap[FirestoreFields.userName],
        userEmail: snap[FirestoreFields.userEmail],
        userPhoneNumber: snap[FirestoreFields.userPhoneNumber],
        deliveryAddressPersonName:
            snap[FirestoreFields.deliveryAddressPersonName],
        deliveryAddressPersonPhoneNumber:
            snap[FirestoreFields.deliveryAddressPersonPhoneNumber],
        deliveryAddressStreet: snap[FirestoreFields.deliveryAddressStreet],
        deliveryAddressPosition: PositionModel.fromSnapshot(
            snap[FirestoreFields.deliveryAddressPosition]),
        items: snap[FirestoreFields.items]
            .map<BasketItem>((e) => BasketItem.fromSnapshot(e))
            .toList(),
        itemTotal: snap[FirestoreFields.itemTotal],
        deliveryCharge: snap[FirestoreFields.deliveryCharge],
        discount: snap[FirestoreFields.discount],
        discountVoucherId: snap[FirestoreFields.discountVoucherId],
        discountVoucherCode: snap[FirestoreFields.discountVoucherCode],
        tip: snap[FirestoreFields.tip],
        grandTotal: snap[FirestoreFields.grandTotal],
        deliveryPersonId: snap[FirestoreFields.deliveryPersonId],
        deliveryPersonName: snap[FirestoreFields.deliveryPersonName],
        deliveryPersonPhoneNumber:
            snap[FirestoreFields.deliveryPersonPhoneNumber],
        deliveryPersonImage: snap[FirestoreFields.deliveryPersonImage],
        deliveryPersonPosition:
            snap.get(FirestoreFields.deliveryPersonPosition) != null
                ? PositionModel.fromSnapshot(
                    snap[FirestoreFields.deliveryPersonPosition])
                : null,
        progress: snap[FirestoreFields.progress],
        status:
            OrderStatusEnumExtension.fromString(snap[FirestoreFields.status]),
        orderedDate: snap[FirestoreFields.orderedDate],
        acceptedDate: snap[FirestoreFields.acceptedDate],
        confirmedDate: snap[FirestoreFields.confirmedDate],
        pickedDate: snap[FirestoreFields.pickedDate],
        deliveredDate: snap[FirestoreFields.deliveredDate],
        cancelledDate: snap[FirestoreFields.cancelledDate],
        cancellationReason: snap[FirestoreFields.cancellationReason],
        updatedDate: snap[FirestoreFields.updatedDate],
        date: snap[FirestoreFields.date],
        defaultConfirmed: snap.toString().contains('defaultConfirmed')
            ? snap[FirestoreFields.defaultConfirmed]
            : false,
      );

  @override
  String toString() =>
      'OrderModel(id: $id, orderOTP: $orderOTP, restaurantId: $restaurantId, restaurantName: $restaurantName, restaurantImage: $restaurantImage, restaurantCity: $restaurantCity, restaurantStreet: $restaurantStreet, restaurantNumber: $restaurantNumber, restaurantPosition: $restaurantPosition, userId: $userId, userName: $userName, userEmail: $userEmail, userPhoneNumber: $userPhoneNumber, deliveryAddressPersonName: $deliveryAddressPersonName, deliveryAddressPersonPhoneNumber: $deliveryAddressPersonPhoneNumber, deliveryAddressStreet: $deliveryAddressStreet, deliveryAddressPosition: $deliveryAddressPosition, items: $items, itemTotal: $itemTotal, deliveryCharge: $deliveryCharge, discount: $discount, discountVoucherId: $discountVoucherId, discountVoucherCode: $discountVoucherCode, tip: $tip, grandTotal: $grandTotal, deliveryPersonId: $deliveryPersonId, deliveryPersonName: $deliveryPersonName, deliveryPersonPhoneNumber: $deliveryPersonPhoneNumber, deliveryPersonImage: $deliveryPersonImage, deliveryPersonPosition: $deliveryPersonPosition, progress: $progress, status: $status, orderedDate: $orderedDate, acceptedDate: $acceptedDate, confirmedDate: $confirmedDate, pickedDate: $pickedDate, deliveredDate: $deliveredDate, cancelledDate: $cancelledDate, cancellationReason: $cancellationReason, updatedDate: $updatedDate, date: $date, defaultConfirmed: $defaultConfirmed)';

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderOTP == orderOTP &&
        other.restaurantId == restaurantId &&
        other.restaurantName == restaurantName &&
        other.restaurantImage == restaurantImage &&
        other.restaurantCity == restaurantCity &&
        other.restaurantStreet == restaurantStreet &&
        other.restaurantNumber == restaurantNumber &&
        other.restaurantPosition == restaurantPosition &&
        other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.userPhoneNumber == userPhoneNumber &&
        other.deliveryAddressPersonName == deliveryAddressPersonName &&
        other.deliveryAddressPersonPhoneNumber ==
            deliveryAddressPersonPhoneNumber &&
        other.deliveryAddressStreet == deliveryAddressStreet &&
        other.deliveryAddressPosition == deliveryAddressPosition &&
        listEquals(other.items, items) &&
        other.itemTotal == itemTotal &&
        other.deliveryCharge == deliveryCharge &&
        other.discount == discount &&
        other.discountVoucherId == discountVoucherId &&
        other.discountVoucherCode == discountVoucherCode &&
        other.tip == tip &&
        other.grandTotal == grandTotal &&
        other.deliveryPersonId == deliveryPersonId &&
        other.deliveryPersonName == deliveryPersonName &&
        other.deliveryPersonPhoneNumber == deliveryPersonPhoneNumber &&
        other.deliveryPersonImage == deliveryPersonImage &&
        other.deliveryPersonPosition == deliveryPersonPosition &&
        other.progress == progress &&
        other.status == status &&
        other.orderedDate == orderedDate &&
        other.acceptedDate == acceptedDate &&
        other.confirmedDate == confirmedDate &&
        other.pickedDate == pickedDate &&
        other.deliveredDate == deliveredDate &&
        other.cancelledDate == cancelledDate &&
        other.cancellationReason == cancellationReason &&
        other.updatedDate == updatedDate &&
        other.date == date &&
        other.defaultConfirmed == defaultConfirmed;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      orderOTP.hashCode ^
      restaurantId.hashCode ^
      restaurantName.hashCode ^
      restaurantImage.hashCode ^
      restaurantCity.hashCode ^
      restaurantStreet.hashCode ^
      restaurantNumber.hashCode ^
      restaurantPosition.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      userEmail.hashCode ^
      userPhoneNumber.hashCode ^
      deliveryAddressPersonName.hashCode ^
      deliveryAddressPersonPhoneNumber.hashCode ^
      deliveryAddressStreet.hashCode ^
      deliveryAddressPosition.hashCode ^
      items.hashCode ^
      itemTotal.hashCode ^
      deliveryCharge.hashCode ^
      discount.hashCode ^
      discountVoucherId.hashCode ^
      discountVoucherCode.hashCode ^
      tip.hashCode ^
      grandTotal.hashCode ^
      deliveryPersonId.hashCode ^
      deliveryPersonName.hashCode ^
      deliveryPersonPhoneNumber.hashCode ^
      deliveryPersonImage.hashCode ^
      deliveryPersonPosition.hashCode ^
      progress.hashCode ^
      status.hashCode ^
      orderedDate.hashCode ^
      acceptedDate.hashCode ^
      confirmedDate.hashCode ^
      pickedDate.hashCode ^
      deliveredDate.hashCode ^
      cancelledDate.hashCode ^
      cancellationReason.hashCode ^
      updatedDate.hashCode ^
      date.hashCode ^
      defaultConfirmed.hashCode;
}
