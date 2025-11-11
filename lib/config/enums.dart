import 'constants.dart' show EnumConstant;
import 'extensions.dart' show StringExtensions;

enum OrderStatusEnum {
  ordered,
  accepted,
  confirmed,
  picked,
  delivered,
  cancelled,
}

enum CityEnum { birgunj, kalaiya, unknown }

/// Convert String to CityEnum
CityEnum cityFromString(String? city) {
  if (city == null) return CityEnum.unknown;
  final normalizedCity = city.translatedCity;
  return EnumConstant.cityMap[normalizedCity] ?? CityEnum.unknown;
}

/// Convert CityEnum to String
String cityToString(CityEnum city) => EnumConstant.cityNames[city] ?? 'Unknown';

// filter enums
enum FilterEnum { all, veg, nonVeg, both, bestSeller }

FilterEnum convertToFilterType(String val) {
  return EnumConstant.filterMap[val.toLowerCase()] ?? FilterEnum.nonVeg;
}

// pending, in-process, closed
enum TicketStatusEnum { pending, inProcess, closed }

TicketStatusEnum convertToTicketStatus(String val) {
  return EnumConstant.ticketStatusMap[val.toLowerCase()] ??
      TicketStatusEnum.pending;
}

enum MessageType { neutral, error, success }

enum AddressType { home, office, work, other }

enum NotificationEnum { info, error, warning, success }
