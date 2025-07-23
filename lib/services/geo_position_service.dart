import 'package:cloud_firestore/cloud_firestore.dart' show GeoPoint;
import 'package:dart_geohash/dart_geohash.dart' show GeoHasher;

import '../models/position_model.dart';

class GeoPositionService {
  Future<PositionModel> getPosition({
    required double latitude,
    required double longitude,
  }) async {
    var geoHasher = GeoHasher();
    String geohash = geoHasher.encode(latitude, longitude, precision: 8);
    PositionModel position = PositionModel(
      geohash: geohash,
      geopoint: GeoPoint(latitude, longitude),
    );
    return position;
  }
}

final geoPositionService = GeoPositionService();
