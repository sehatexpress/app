import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/location_model.dart';
import '../../services/location_service.dart';
import '../generic/loader_widget.dart';

class AddressPickerDialog extends HookConsumerWidget {
  final LocationModel initialLocation;

  const AddressPickerDialog({super.key, required this.initialLocation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState<bool>(false);
    final selectedLocation = useState<LocationModel>(initialLocation);
    final mapController = useState<GoogleMapController?>(null);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  selectedLocation.value.latitude,
                  selectedLocation.value.longitude,
                ),
                zoom: 15.6,
              ),
              onMapCreated: (controller) {
                mapController.value = controller;
              },
              onTap: (LatLng latLng) async {
                loading.value = true;
                var res = await ref
                    .read(locationServiceProvider)
                    .getAddress(latLng.latitude, latLng.longitude);
                selectedLocation.value = res;
                loading.value = false;
                mapController.value?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(target: latLng, zoom: 15.6),
                  ),
                );
              },
              markers: {
                Marker(
                  markerId: const MarkerId('selected'),
                  position: LatLng(
                    selectedLocation.value.latitude,
                    selectedLocation.value.longitude,
                  ),
                ),
              },
            ),
            Positioned(
              left: 16,
              top: 16,
              child: SafeArea(
                child: IconButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                  ),
                  onPressed: !loading.value
                      ? () => Navigator.pop(context)
                      : null,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            if (loading.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const LoaderWidget(),
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedLocation.value.displayName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check_rounded, color: Colors.green),
                onPressed: !loading.value
                    ? () => Navigator.pop(context, selectedLocation.value)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
