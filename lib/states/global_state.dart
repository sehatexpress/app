import 'package:flutter/foundation.dart' show immutable;

import '../config/enums.dart' show MessageType;

@immutable
class GlobalState {
  final bool loading;
  final String? message;
  final MessageType type;
  final bool orderPlaced;

  const GlobalState({
    this.loading = true,
    this.message,
    this.type = MessageType.neutral,
    this.orderPlaced = false,
  });

  const GlobalState.initial(bool load)
      : loading = load,
        message = null,
        type = MessageType.neutral,
        orderPlaced = false;

  GlobalState copyWith({
    bool? loading,
    String? message,
    MessageType? type,
    bool? orderPlaced,
  }) =>
      GlobalState(
        loading: loading ?? this.loading,
        message: message ?? this.message,
        type: type ?? this.type,
        orderPlaced: orderPlaced ?? this.orderPlaced,
      );

  @override
  bool operator ==(covariant GlobalState other) =>
      identical(this, other) ||
      (loading == other.loading &&
          message == other.message &&
          type == other.type &&
          orderPlaced == other.orderPlaced);

  @override
  int get hashCode => Object.hash(loading, message, type, orderPlaced);
}
