import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/enums.dart' show FilterEnum;
import '../states/value_state.dart';

// Create a StateNotifier to manage ValueState
class ValueNotifier extends StateNotifier<ValueState> {
  ValueNotifier() : super(ValueState());

  // Method to change tab index
  void changeIndex(int newIndex) {
    state = state.copyWith(index: newIndex, search: null);
  }

  // Method to set search value
  void setSearch(String? searchValue) {
    state = state.copyWith(search: searchValue);
  }

  // Method to set filter value
  void setFilter(FilterEnum? filterValue) {
    state = state.copyWith(filter: filterValue);
  }

  void clear() => state = const ValueState();
}

// AutoDispose Provider that clears search and filter on dispose
final valueProvider =
    StateNotifierProvider<ValueNotifier, ValueState>((_) => ValueNotifier());
