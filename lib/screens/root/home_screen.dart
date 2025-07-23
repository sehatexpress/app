import 'package:app/widgets/buttons/icon_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/enums.dart' show CityEnum, cityFromString;
import '../../providers/location_provider.dart' show locationProvider;
import '../../widgets/buttons/text_gradient_button.dart';
import '../../widgets/home/banner_slider_widget.dart';
import '../../widgets/home/categories_list_widget.dart';
import '../../widgets/home/restaurants_list_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(locationProvider.select((state) => state.city));
    final convertToEnum = cityFromString(city);
    if (convertToEnum == CityEnum.unknown) {
      return Center(
        // child: Text('NOT AVAILABLE IN YOUR CITY '),
        child: Column(
          children: [
            TextGradientButton(title: 'Click Me', leftIcon: Icons.login),
            const SizedBox(height: 12),
            IconGradientButton(icon: Icons.abc),
          ],
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        children: [
          OfferSliderWidget(),
          CategoriesListWidget(),
          RestaurantListWidget(),
        ],
      );
    }
  }
}
