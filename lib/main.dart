import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/constants.dart' show KeyConstants;
import 'config/theme.dart' show theme;
import 'providers/global_provider.dart' show appStartupProvider;
import 'screens/wrapper.dart';
import 'widgets/startup/startup_loading.dart';
import 'widgets/startup/startup_error.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AppStartupWidget()));
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartup = ref.watch(appStartupProvider);
    return MaterialApp(
      theme: theme,
      title: 'Sehat Express',
      debugShowCheckedModeBanner: false,
      home: appStartup.when(
        data: (_) => const Wrapper(),
        loading: () => const StartupLoading(),
        error: (error, stack) => StartupError(
          error: error,
          onRetry: () => ref.refresh(appStartupProvider),
        ),
      ),
      navigatorKey: KeyConstants.navigatorKey,
    );
  }
}

// rm -rf Pods Podfile.lock
// pod install --repo-update

// to run on brave
// export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
// flutter run -d web-server
