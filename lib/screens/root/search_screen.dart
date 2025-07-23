import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../providers/value_provider.dart' show valueProvider;
import '../../widgets/search/initial_search_widget.dart';
import '../../widgets/search/restaurant_list_widget.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(valueProvider.select((state) => state.search));
    return SizedBox(
      height: double.maxFinite,
      width: double.infinity,
      child: search != null && search.isNotEmpty
          ? SearchViewRestaurantWidget(search: search)
          : const InitialSearchWidget(),
    );
  }
}
