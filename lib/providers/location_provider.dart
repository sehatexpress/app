import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../config/extensions.dart';
import '../config/string_constants.dart' show LocationStrings;
import '../models/location_model.dart';
import '../services/location_service.dart';
import '../states/location_state.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(ref),
);

class LocationNotifier extends StateNotifier<LocationState> {
  final Ref ref;
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  LocationNotifier(this.ref) : super(LocationState());

  Future<void> requestLocation() async {
    await ref.withLoading(() async {
      bool enabled = await ref
          .read(locationServiceProvider)
          .checkLocationPermission();
      if (!enabled) throw LocationStrings.locationDenied;
      state = state.copyWith(enabled: enabled);
      await init();
    });
  }

  void updateCity(String? city) => state = state.copyWith(city: city);

  Future<void> updateCords({
    required double latitude,
    required double longitude,
  }) async {
    await ref.withLoading(() async {
      await _updateLocation(latitude, longitude);
    });
  }

  Future<void> getCurrentLocation() async {
    await ref.withLoading(() async {
      var pos = await ref.read(locationServiceProvider).getCurrentLocation();
      await _updateLocation(pos.latitude, pos.longitude);
    });
  }

  Future<void> _updateLocation(double lat, double lng) async {
    final loc = await ref.read(locationServiceProvider).getAddress(lat, lng);
    state = state.copyWith(
      latitude: lat,
      longitude: lng,
      location: loc,
      city: loc.city,
    );
  }

  Future<void> init({bool load = false}) async {
    await ref.withLoading(() async {
      Position cords = await _geolocator.getCurrentPosition();
      await _updateLocation(cords.latitude, cords.longitude);
    });
  }

  Future<void> searchLocation(String search) async {
    await ref.withLoading(() async {
      final result = await ref
          .read(locationServiceProvider)
          .getLocationBySearch(search);
      state = state.copyWith(searchedLocations: result);
    });
  }

  void addToSearchLocation(LocationModel location) {
    final locations = [...state.searchedLocations, location];
    state = state.copyWith(
      searchedLocations: locations,
      focusedLocationIndex: locations.length - 1,
    );
  }

  void setFocusedLocation(int i) =>
      state = state.copyWith(focusedLocationIndex: i);

  void clear() {
    state = state.copyWith(
      search: null,
      searchedLocations: [],
      focusedLocationIndex: 0,
    );
  }
}
