import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/extensions.dart';
import '../../providers/lists_provider.dart' show bannerListProvider;
import '../../screens/restaurant/restaurant_detail_screen.dart';
import '../generic/custom_image_provider.dart';
import '../generic/loader_widget.dart';

class OfferSliderWidget extends HookConsumerWidget {
  const OfferSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var index = useState<int>(0);
    final banners = ref.watch(bannerListProvider);
    return banners.when(
      data: (data) {
        return data.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (i, _) => index.value = i,
                        viewportFraction: size.width < 500
                            ? .8
                            : size.width < 760
                                ? .6
                                : .4,
                      ),
                      items: data
                          .map((e) => GestureDetector(
                                onTap: () {
                                  if (e.restaurantId != null) {
                                    context.push(RestaurantDetailsScreen(
                                      restaurantId: e.restaurantId!,
                                    ));
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CustomImageProvider(image: e.imageUrl),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        data.length,
                        (x) => AnimatedContainer(
                          height: 6,
                          width: index.value == x ? 20 : 6,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: ColorConstants.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          duration: const Duration(milliseconds: 400),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
      error: (_, _) => const SizedBox(),
      loading: () => Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: LoaderWidget(),
      ),
    );
  }
}
