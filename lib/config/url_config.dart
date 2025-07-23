import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlConfig {
  Future<void> openGoogleMap(
    String origin,
    double originLatitude,
    double originLongitude,
    String destination,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    await MapLauncher.showDirections(
      directionsMode: DirectionsMode.driving,
      mapType: MapType.google,
      originTitle: origin,
      origin: Coords(originLatitude, originLongitude),
      destinationTitle: destination,
      destination: Coords(destinationLatitude, destinationLongitude),
    );
  }

  Future<bool> openCall(String phone) async =>
      await launchUrl(Uri.parse('tel:+977$phone'));

  Future<Future<bool>> openEmail(String mail) async =>
      launchUrl(Uri.parse('mailto:$mail'));

  Future<bool> launchOpenUrl(String url) async =>
      await launchUrl(Uri.parse(url));
}

final urlConfig =  UrlConfig();