import 'dart:math' show asin, cos, sqrt;

extension DistanceCalculator on GeoCoordinates {
  double calculateDistanceTo(GeoCoordinates other) {
    var lat1 = latitude;
    var lon1 = longitude;
    var lat2 = other.latitude;
    var lon2 = other.longitude;

    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

class GeoCoordinates {
  final double latitude;
  final double longitude;

  GeoCoordinates(this.latitude, this.longitude);
}

/*
GeoCoordinates point1 = GeoCoordinates(52.5200, 13.4050); // Berlin
GeoCoordinates point2 = GeoCoordinates(48.8566, 2.3522);  // Paris

double distance = point1.calculateDistanceTo(point2);
print('The distance between the two points is: $distance km');
*/