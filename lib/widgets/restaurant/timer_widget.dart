import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ConsumerWidget, WidgetRef;

import '../../config/typo_config.dart' show typoConfig;
import '../../providers/timer_provider.dart' show timerProvider;
import '../../states/timer_state.dart';

// Timer widget using Riverpod
class TimerWidget extends ConsumerWidget {
  final int hour;
  final int minute;
  final int seconds;
  final Color color;

  const TimerWidget({
    super.key,
    this.color = Colors.white,
    this.hour = 0,
    this.minute = 0,
    this.seconds = 60,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(timerProvider(TimerState(
      hour: hour,
      minute: minute,
      seconds: seconds,
    )));

    // Format time for display
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(duration.inHours.remainder(24));
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final sec = strDigits(duration.inSeconds.remainder(60));

    return Text(
      '$hours:$minutes:$sec',
      style: typoConfig.textStyle.largeHeaderH1.copyWith(color: color),
    );
  }
}
