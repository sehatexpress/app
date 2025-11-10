import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show kIsWeb, listEquals, immutable;
import '../config/extensions.dart'
    show DateTimeExtensions, OrderStatusEnumExtension, OrderStatusValue;

import '../config/enums.dart' show OrderStatusEnum;
import '../config/string_constants.dart' show Fields;
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
  }) => OrderModel(
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
    deliveryAddressPersonPhoneNumber:
        deliveryAddressPersonPhoneNumber ??
        this.deliveryAddressPersonPhoneNumber,
    deliveryAddressStreet: deliveryAddressStreet ?? this.deliveryAddressStreet,
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
    Fields.orderOTP: orderOTP,
    Fields.restaurantId: restaurantId,
    Fields.restaurantName: restaurantName,
    Fields.restaurantImage: restaurantImage,
    Fields.restaurantCity: restaurantCity,
    Fields.restaurantStreet: restaurantStreet,
    Fields.restaurantNumber: restaurantNumber,
    Fields.restaurantPosition: restaurantPosition.toDocument(),
    Fields.userId: userId,
    Fields.userName: userName,
    Fields.userEmail: userEmail,
    Fields.userPhoneNumber: userPhoneNumber,
    Fields.deliveryAddressPersonName: deliveryAddressPersonName,
    Fields.deliveryAddressPersonPhoneNumber: deliveryAddressPersonPhoneNumber,
    Fields.deliveryAddressStreet: deliveryAddressStreet,
    Fields.deliveryAddressPosition: deliveryAddressPosition.toDocument(),
    Fields.items: items.map((e) => e.toDocument()).toList(),
    Fields.itemTotal: itemTotal,
    Fields.deliveryCharge: deliveryCharge,
    Fields.discount: discount,
    Fields.discountVoucherId: discountVoucherId,
    Fields.discountVoucherCode: discountVoucherCode,
    Fields.tip: tip,
    Fields.grandTotal: grandTotal,
    Fields.deliveryPersonId: null,
    Fields.deliveryPersonName: null,
    Fields.deliveryPersonPhoneNumber: null,
    Fields.deliveryPersonImage: null,
    Fields.deliveryPersonPosition: null,
    Fields.progress: false,
    Fields.status: OrderStatusEnum.ordered.value,
    Fields.orderedDate: DateTime.now().millisecondsSinceEpoch,
    Fields.acceptedDate: null,
    Fields.confirmedDate: null,
    Fields.pickedDate: null,
    Fields.deliveredDate: null,
    Fields.cancelledDate: null,
    Fields.cancellationReason: null,
    Fields.updatedDate: DateTime.now().millisecondsSinceEpoch,
    Fields.commission: 0,
    Fields.restaurantBalance: 0,
    Fields.deliveryPersonBalance: 0,
    Fields.date: DateTime.now().millisecondsSinceEpoch.formattedDate,
    Fields.platform: kIsWeb ? 'web' : 'mobile',
    Fields.defaultConfirmed: defaultConfirmed,
  };

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) => OrderModel(
    id: snap.id,
    orderOTP: snap[Fields.orderOTP],
    restaurantId: snap[Fields.restaurantId],
    restaurantName: snap[Fields.restaurantName],
    restaurantImage: snap[Fields.restaurantImage],
    restaurantCity: snap[Fields.restaurantCity],
    restaurantStreet: snap[Fields.restaurantStreet],
    restaurantNumber: snap.data().toString().contains(Fields.restaurantNumber)
        ? snap[Fields.restaurantNumber]
        : '9876543210',
    restaurantPosition: PositionModel.fromSnapshot(
      snap[Fields.restaurantPosition],
    ),
    userId: snap[Fields.userId],
    userName: snap[Fields.userName],
    userEmail: snap[Fields.userEmail],
    userPhoneNumber: snap[Fields.userPhoneNumber],
    deliveryAddressPersonName: snap[Fields.deliveryAddressPersonName],
    deliveryAddressPersonPhoneNumber:
        snap[Fields.deliveryAddressPersonPhoneNumber],
    deliveryAddressStreet: snap[Fields.deliveryAddressStreet],
    deliveryAddressPosition: PositionModel.fromSnapshot(
      snap[Fields.deliveryAddressPosition],
    ),
    items: snap[Fields.items]
        .map<BasketItem>((e) => BasketItem.fromSnapshot(e))
        .toList(),
    itemTotal: snap[Fields.itemTotal],
    deliveryCharge: snap[Fields.deliveryCharge],
    discount: snap[Fields.discount],
    discountVoucherId: snap[Fields.discountVoucherId],
    discountVoucherCode: snap[Fields.discountVoucherCode],
    tip: snap[Fields.tip],
    grandTotal: snap[Fields.grandTotal],
    deliveryPersonId: snap[Fields.deliveryPersonId],
    deliveryPersonName: snap[Fields.deliveryPersonName],
    deliveryPersonPhoneNumber: snap[Fields.deliveryPersonPhoneNumber],
    deliveryPersonImage: snap[Fields.deliveryPersonImage],
    deliveryPersonPosition: snap.get(Fields.deliveryPersonPosition) != null
        ? PositionModel.fromSnapshot(snap[Fields.deliveryPersonPosition])
        : null,
    progress: snap[Fields.progress],
    status: OrderStatusEnumExtension.fromString(snap[Fields.status]),
    orderedDate: snap[Fields.orderedDate],
    acceptedDate: snap[Fields.acceptedDate],
    confirmedDate: snap[Fields.confirmedDate],
    pickedDate: snap[Fields.pickedDate],
    deliveredDate: snap[Fields.deliveredDate],
    cancelledDate: snap[Fields.cancelledDate],
    cancellationReason: snap[Fields.cancellationReason],
    updatedDate: snap[Fields.updatedDate],
    date: snap[Fields.date],
    defaultConfirmed: snap.toString().contains('defaultConfirmed')
        ? snap[Fields.defaultConfirmed]
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
