import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart'
    show StateNotifier, StateNotifierProvider;

import '../states/timer_state.dart';

class TimerNotifier extends StateNotifier<Duration> {
  Timer? _countdownTimer;

  TimerNotifier(int hours, int minutes, int seconds)
      : super(Duration(hours: hours, minutes: minutes, seconds: seconds)) {
    _startTimer();
  }

  // Start the countdown timer
  void _startTimer() {
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _setCountDown(),
    );
  }

  // Update the countdown time
  void _setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = state.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      _countdownTimer?.cancel();
    } else {
      state = Duration(seconds: seconds);
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}

// Provider for TimerNotifier
final timerProvider = StateNotifierProvider.autoDispose
    .family<TimerNotifier, Duration, TimerState>((ref, params) {
  return TimerNotifier(params.hour, params.minute, params.seconds);
});
