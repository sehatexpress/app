import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/global_provider.dart';
import '../../providers/location_provider.dart';
import '../../services/location_service.dart';

class MapWidget extends HookConsumerWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latitude =
        ref.watch(locationProvider.select((state) => state.latitude));
    final longitude =
        ref.watch(locationProvider.select((state) => state.longitude));
    final searchedLocations =
        ref.watch(locationProvider.select((state) => state.searchedLocations));
    final focusedLocationIndex = ref
        .watch(locationProvider.select((state) => state.focusedLocationIndex));
    final controller = useState<GoogleMapController?>(null);
    final markers = useState<Map<MarkerId, Marker>>({});
    final isMapInitialized = useState(false);

    /// Adds a marker at the specified latitude and longitude
    void addMarker(double lat, double lng, {bool isFocused = false}) {
      if (lat != 0 && lng != 0) {
        var id = lat + lng;
        var markerId = MarkerId(id.toString());
        final newMarker = Marker(
          markerId: markerId,
          icon: isFocused
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarker,
          position: LatLng(lat, lng),
        );

        // Create a new copy of the map and update it
        final updatedMarkers = Map<MarkerId, Marker>.from(markers.value);
        updatedMarkers[markerId] = newMarker;
        markers.value = updatedMarkers;
      }
    }

    /// Updates markers and focuses on the selected marker
    void updateMarkers() {
      markers.value = {};
      for (var i = 0; i < searchedLocations.length; i++) {
        final item = searchedLocations[i];
        addMarker(
          item.latitude,
          item.longitude,
          isFocused: i == focusedLocationIndex,
        );
      }
      // Animate camera to focused marker
      if (searchedLocations.isNotEmpty &&
          focusedLocationIndex >= 0 &&
          focusedLocationIndex < searchedLocations.length &&
          controller.value != null) {
        final focusedLocation = searchedLocations[focusedLocationIndex];
        controller.value!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                focusedLocation.latitude,
                focusedLocation.longitude,
              ),
              zoom: 15,
            ),
          ),
        );
      }
    }

    final currentPosition = LatLng(latitude, longitude);

    useEffect(() {
      if (isMapInitialized.value) {
        addMarker(currentPosition.latitude, currentPosition.longitude);
        updateMarkers();
      }
      return null;
    }, [currentPosition, focusedLocationIndex, isMapInitialized.value]);

    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: false,
      onTap: (latlng) async {
        try {
          ref.read(loadingProvider.notifier).state =true;
          var location = await ref.read(locationServiceProvider).getAddress(
                latlng.latitude,
                latlng.longitude,
              );
          ref.read(locationProvider.notifier).addToSearchLocation(location);
          updateMarkers();
        } catch (e) {
          ref.read(messageProvider.notifier).state =e.toString();
        } finally {
          ref.read(loadingProvider.notifier).state =false;
        }
      },
      onMapCreated: (mapController) {
        controller.value = mapController;
        isMapInitialized.value = true;
      },
      initialCameraPosition: CameraPosition(
        target: currentPosition,
        zoom: 15,
      ),
      markers: markers.value.values.toSet(),
    );
  }
}
