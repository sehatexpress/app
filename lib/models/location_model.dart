import 'package:flutter/foundation.dart' show immutable;

import '../config/string_constants.dart' show FirestoreFields;

@immutable
class LocationModel {
  final double latitude;
  final double longitude;
  final String displayName;
  final String city;
  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.displayName,
    required this.city,
  });

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? displayName,
    String? city,
  }) =>
      LocationModel(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        displayName: displayName ?? this.displayName,
        city: city ?? this.city,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        FirestoreFields.latitude: latitude,
        FirestoreFields.longitude: longitude,
        FirestoreFields.displayName: displayName,
        FirestoreFields.city: city,
      };

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        latitude: double.parse(map['lat']),
        longitude: double.parse(map['lon']),
        displayName: map['display_name'],
        city: map['address'].containsKey('city')
            ? map['address']['city']
            : map['address'].containsKey('town')
                ? map['address']['town']
                : map['address'].containsKey('municipality')
                    ? map['address']['municipality']
                    : map['address']['state_district'],
      );

  factory LocationModel.fromSearchMap(Map<String, dynamic> map) =>
      LocationModel(
        latitude: double.parse(map['lat']),
        longitude: double.parse(map['lon']),
        displayName: map['display_name'],
        city: map['name'],
      );

  @override
  String toString() =>
      'LocationModel(latitude: $latitude, longitude: $longitude, displayName: $displayName, city: $city)';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.displayName == displayName &&
        other.city == city;
  }

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      displayName.hashCode ^
      city.hashCode;
}



/*{
  "place_id": 242539931,
  "licence": "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
  "osm_type": "way",
  "osm_id": 233027127,
  "lat": "27.03261410820504",
  "lon": "85.00434577317478",
  "category": "highway",
  "type": "residential",
  "place_rank": 26,
  "importance": 0.10000999999999993,
  "addresstype": "road",
  "name": "",
  "display_name": "Kalaiya-01, Kalaiya, Bara, Madhesh Province, 04441, Nepal",
  "address": {
    "city_district": "Kalaiya-01",
    "town": "Kalaiya",
    "municipality": "Kalaiya",
    "county": "Bara",
    "state": "Madhesh Province",
    "ISO3166-2-lvl4": "NP-P2",
    "postcode": "04441",
    "country": "Nepal",
    "country_code": "np"
  },
  "boundingbox": [
    "27.0320134",
    "27.0341222",
    "85.0040883",
    "85.0050044"
  ]
}*/