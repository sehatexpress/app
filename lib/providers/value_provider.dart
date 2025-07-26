import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

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

  void clear() => state = const ValueState();
}

// AutoDispose Provider that clears search and filter on dispose
final valueProvider = StateNotifierProvider<ValueNotifier, ValueState>(
  (_) => ValueNotifier(),
);

final searchProductProvider = StateProvider.autoDispose<String?>((_) => null);

final randomNumberProvider = StreamProvider.autoDispose<int>((ref) async* {
  final search = ref.watch(searchProductProvider);
  final random = Random();
  if (search != null) {
    yield random.nextInt(10) + 1;
  } else {
    yield 10;
  }
});
