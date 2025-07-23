import 'package:flutter/foundation.dart' show immutable;

@immutable
class TimerState {
  final int hour;
  final int minute;
  final int seconds;

  const TimerState({
    required this.hour,
    required this.minute,
    required this.seconds,
  });
}
