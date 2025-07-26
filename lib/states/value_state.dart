import 'package:flutter/foundation.dart' show immutable;

@immutable
class ValueState {
  final int index;
  final String? search;

  const ValueState({this.index = 0, this.search});

  ValueState copyWith({int? index, String? search}) =>
      ValueState(index: index ?? this.index, search: search ?? this.search);

  @override
  bool operator ==(covariant ValueState other) {
    if (identical(this, other)) return true;

    return other.index == index && other.search == search;
  }

  @override
  int get hashCode => index.hashCode ^ search.hashCode;
}
