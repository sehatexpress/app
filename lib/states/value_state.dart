import 'package:flutter/foundation.dart' show immutable;

import '../config/enums.dart' show FilterEnum;

@immutable
class ValueState {
  final int index;
  final String? search;
  final FilterEnum? filter;

  const ValueState({
    this.index = 0,
    this.search,
    this.filter,
  });

  ValueState copyWith({
    int? index,
    String? search,
    FilterEnum? filter,
  }) =>
      ValueState(
        index: index ?? this.index,
        search: search ?? this.search,
        filter: filter ?? this.filter,
      );

  @override
  bool operator ==(covariant ValueState other) {
    if (identical(this, other)) return true;

    return other.index == index &&
        other.search == search &&
        other.filter == filter;
  }

  @override
  int get hashCode => index.hashCode ^ search.hashCode ^ filter.hashCode;
}
