import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart';
import '../../providers/location_provider.dart' show locationProvider;
import '../../widgets/generic/map_widget.dart';

class SearchLocationScreen extends ConsumerWidget {
  const SearchLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedLocations =
        ref.watch(locationProvider.select((state) => state.searchedLocations));
    final currentFocusIndex = ref.watch(
      locationProvider.select((state) => state.focusedLocationIndex),
    );

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: MapWidget(),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorConstants.textColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        hintText: 'Search location...',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                      ),
                      onFieldSubmitted: (val) {
                        ref.read(locationProvider.notifier).searchLocation(val);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: IconButton(
              onPressed: () async {
                await ref.read(locationProvider.notifier).getCurrentLocation();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.primary,
              ),
              icon: const Icon(Icons.my_location_rounded, color: Colors.white),
            ),
          ),
          if (searchedLocations.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 77,
                  enlargeCenterPage: true,
                  onPageChanged: (i, _) =>
                      ref.read(locationProvider.notifier).setFocusedLocation(i),
                  viewportFraction: .7,
                ),
                items: searchedLocations
                    .map((e) => Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await ref
                                    .read(locationProvider.notifier)
                                    .updateCords(
                                      latitude: e.latitude,
                                      longitude: e.longitude,
                                    );
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.city,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: typoConfig
                                          .textStyle.largeCaptionLabel3Bold
                                          .copyWith(height: 1),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      e.displayName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: typoConfig.textStyle.smallSmall
                                          .copyWith(
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (currentFocusIndex ==
                                searchedLocations.indexOf(e))
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
