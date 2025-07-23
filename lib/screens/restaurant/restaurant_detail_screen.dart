import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/typo_config.dart';
import '../../providers/lists_provider.dart';
import '../../providers/value_provider.dart';
import '../../widgets/generic/loader_widget.dart';
import '../../widgets/inputs/search_input_widget.dart';
import '../../widgets/restaurant/menu_filter_widget.dart';
import '../../widgets/restaurant/restaurant_additional_info_widget.dart';
import '../../widgets/restaurant/restaurant_detail_bottombar_menu.dart';
import '../../widgets/restaurant/restaurant_image_info_widget.dart';
import '../../widgets/restaurant/restaurant_menu_items_widget.dart';

class RestaurantDetailsScreen extends HookConsumerWidget {
  final String restaurantId;
  const RestaurantDetailsScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(valueProvider.notifier);
    useEffect(() {
      Future.microtask(() => notifier.clear());
      return () => Future.microtask(() => notifier.clear());
    }, []);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: const SearchInputWidget(
                hintText: 'Search products...',
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: ref.watch(singleRestaurantListByCityProvider(restaurantId)).when(
            data: (restaurant) {
              if (!restaurant.status) {
                return Center(
                  child: Text(
                    'Sorry the restaurant service is \n unavailable now. Please visit some time later.',
                    style: typoConfig.textStyle.smallCaptionSubtitle2,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              final search =
                  ref.watch(valueProvider.select((state) => state.search));
              final filter =
                  ref.watch(valueProvider.select((state) => state.filter));
              return ListView(
                shrinkWrap: true,
                children: [
                  if (search == null || search.isEmpty)
                    RestaurantImageInfoWidget(
                      restaurant: restaurant,
                    ),
                  ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      if (search == null || search.isEmpty) ...[
                        RestaurantAdditionalInfoWidget(
                          restaurant: restaurant,
                        ),
                        MenuFilterWidget(
                          filter: filter,
                          onUpdate: (x) =>
                              ref.read(valueProvider.notifier).setFilter(x),
                        ),
                        const SizedBox(height: 8),
                      ],
                      RestaurantMenuItemsWidget(restaurant: restaurant),
                    ],
                  ),
                ],
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => Center(
              child: LoaderWidget(),
            ),
          ),
      bottomNavigationBar: const RestaurantBottomAppbarMenu(),
    );
  }
}
