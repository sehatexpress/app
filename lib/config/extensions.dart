import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'constants.dart';
import 'enums.dart';
import 'typo_config.dart';

// screen size
extension ScreenTypeExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;
  bool get isLarge => MediaQuery.of(this).size.width >= 1920;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Push to a new screen and return the future
  Future<T?> push<T>(Widget screen) =>
      Navigator.push<T>(this, MaterialPageRoute(builder: (_) => screen));

  /// Push and replace current screen and return the future
  Future<T?> pushReplacement<T, TO>(Widget screen) =>
      Navigator.pushReplacement<T, TO>(
        this,
        MaterialPageRoute(builder: (_) => screen),
      );

  /// Push and clear all previous screens and return the future
  Future<T?> pushAndRemoveUntil<T>(Widget screen) =>
      Navigator.pushAndRemoveUntil<T>(
        this,
        MaterialPageRoute(builder: (_) => screen),
        (route) => false,
      );

  void pop() => Navigator.pop(this);

  /// Shorthand for Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Shorthand for Theme.of(context).textTheme
  TextTheme get text => theme.textTheme;

  /// Shorthand for Theme.of(context).colorScheme
  ColorScheme get color => theme.colorScheme;

  // show snackbbar
  void showSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 5),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      clipBehavior: Clip.none,
      backgroundColor: ColorConstants.primary,
      content: Text(
        message,
        style: text.labelMedium?.copyWith(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension OrderStatusEnumExtension on OrderStatusEnum {
  static OrderStatusEnum fromString(String val) {
    return EnumConstant.orderStatus[val.toLowerCase()] ??
        OrderStatusEnum.cancelled;
  }
}

extension OrderStatusValue on OrderStatusEnum {
  String get value => toString().split('.').last;
  Color get color => EnumConstant.statusColors[this] ?? Colors.red;
}

//
extension StringExtensions on String {
  String get initialLetters => isNotEmpty
      ? trim()
            .split(' ')
            .where((e) => e.isNotEmpty)
            .map((l) => l[0])
            .take(2)
            .join()
            .toUpperCase()
      : '';

  String get capitalize => isNotEmpty
      ? trim()
            .split(' ')
            .map(
              (e) =>
                  e.isNotEmpty ? '${e[0].toUpperCase()}${e.substring(1)}' : '',
            )
            .join(' ')
      : '';

  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isPhoneNumber => RegExp(r'^\d{10}$').hasMatch(this);

  String get translatedCity {
    if (endsWith('ज')) return 'birgunj';
    if (endsWith('या')) return 'kalaiya';
    return toLowerCase();
  }
}

extension FilterEnumValue on FilterEnum {
  String get value => EnumConstant.filterValues[this] ?? 'Veg';
  String get type => EnumConstant.filterTypes[this] ?? 'veg';
}

extension TicketStatusValue on TicketStatusEnum {
  String get value => EnumConstant.ticketStatusValues[this] ?? 'Pending';
}

extension DateTimeExtensions on int {
  DateTime get _toDateTime => DateTime.fromMillisecondsSinceEpoch(this);

  String get formattedDate => DateFormat('yyyy-MM-dd').format(_toDateTime);
  String get formattedTime => DateFormat.jm().format(_toDateTime);
  String get formatDateTime =>
      DateFormat('dd MMM, hh:mm a').format(_toDateTime);

  int differenceInMinutes(int otherMillis) => _toDateTime
      .difference(DateTime.fromMillisecondsSinceEpoch(otherMillis))
      .inMinutes
      .abs();

  /// Returns the current local DateTime
  static String get nowLocal => DateTime.now().toIso8601String();
}

extension StringTimeExtensions on String? {
  String get formattedTimeFromString {
    if (this == null || this!.isEmpty) return '--:--';

    final res = this!.split('.').first.split(':').map(int.parse).toList();
    if (res.length < 2) return '--:--';

    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, res[0], res[1]);

    return DateFormat('hh:mm a').format(dateTime);
  }
}

extension RestaurantTimeStatus on String {
  String getRestaurantStatus(String closingTime) {
    final openingTimeParts = split(
      '.',
    ).first.split(':').map(int.parse).toList();
    final closingTimeParts = closingTime
        .split('.')
        .first
        .split(':')
        .map(int.parse)
        .toList();

    if (openingTimeParts.length < 2 || closingTimeParts.length < 2) {
      return 'CLOSED';
    }

    final now = DateTime.now();
    final openingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      openingTimeParts[0],
      openingTimeParts[1],
    );
    final closingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      closingTimeParts[0],
      closingTimeParts[1],
    );

    if (now.isBefore(openingDateTime)) return 'OPENING SOON';
    if (now.isAfter(closingDateTime)) return 'CLOSED';
    return 'OPEN';
  }
}

extension RestaurantTimeStatusBool on String {
  bool getRestaurantStatusBool(String closingTime) {
    final openingTimeParts = split(
      '.',
    ).first.split(':').map(int.parse).toList();
    final closingTimeParts = closingTime
        .split('.')
        .first
        .split(':')
        .map(int.parse)
        .toList();

    if (openingTimeParts.length < 2 || closingTimeParts.length < 2) {
      return false;
    }

    final now = DateTime.now();
    final openingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      openingTimeParts[0],
      openingTimeParts[1],
    );
    final closingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      closingTimeParts[0],
      closingTimeParts[1],
    );

    return now.isAfter(openingDateTime) && now.isBefore(closingDateTime);
  }
}

extension DateDifference on DateTime {
  int differenceInMinutes(DateTime other) => difference(other).inMinutes;
}

extension DateDifferenceInDays on String {
  String getDifferenceInDays() {
    if (isEmpty || length <= 5) return '--:--';

    final expiryDate = DateTime.tryParse(this);
    if (expiryDate == null) return '--:--';

    final diff = expiryDate.difference(DateTime.now());
    if (diff.isNegative) return 'Expired';
    if (diff.inDays == 0) return 'Expires Today';
    return 'Expires in ${diff.inDays} days';
  }
}

extension DateHistoryFormat on DateTime {
  String getHistoryDate() {
    final now = DateTime.now();
    final differenceInDays = now.difference(this).inDays;

    if (differenceInDays == 0) return 'Today';
    if (differenceInDays == 1) return 'Yesterday';

    return DateFormat('yyyy-MM-dd').format(this);
  }
}

extension ExpiryCheck on String {
  bool isExpired() {
    if (isEmpty || length <= 5) return false;

    final expiryDate = DateTime.tryParse(this);
    return expiryDate?.isBefore(DateTime.now()) ?? false;
  }
}

/// 🔹 **Extension to Handle Firebase Errors Gracefully**
extension FirebaseErrorHandler on dynamic {
  String get firebaseErrorMessage {
    if (this is FirebaseAuthException) {
      return (this as FirebaseAuthException).message ??
          "An unknown authentication error occurred.";
    } else if (this is FirebaseException) {
      return (this as FirebaseException).message ??
          "Something went wrong with Firebase!";
    } else {
      return "Unexpected error: ${toString()}";
    }
  }
}

extension DialogText on String {
  Widget get dialogTitle => Text(
    this,
    style: typoConfig.textStyle.smallBodyBodyText2.copyWith(
      height: 1,
      fontWeight: FontWeight.w600,
    ),
  );
}

