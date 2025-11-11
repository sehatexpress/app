import 'dart:developer' as console show log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../providers/location_provider.dart' show locationProvider;
import '../config/firebase_config.dart';

final loadingProvider = StateProvider<bool>((ref) => false);
final messageProvider = StateProvider<String?>((ref) => null);
final orderPlacedProvider = StateProvider<bool>((ref) => false);

/// APP STARTUP PROVIDER
final appStartupProvider = FutureProvider<void>((ref) async {
  try {
    console.log('Initializing app dependencies...');
    await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    // Uncomment for debugging with emulators
    // if (kDebugMode) {
    //   FirebaseFunctions.instance.useFunctionsEmulator(LocationConstant.url, 5001);
    //   FirebaseFirestore.instance.useFirestoreEmulator(LocationConstant.url, 8080);
    //   await FirebaseAuth.instance.useAuthEmulator(LocationConstant.url, 9099);
    // }

    if (!kIsWeb) {
      if (kReleaseMode) {
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
        // await FirebaseAnalytics.instance.logEvent(name: 'app_start');
      }
      // await notificationService.initNotification();
      // await notificationService.subscribeToTopic('client');
    }

    await ref.read(locationProvider.notifier).requestLocation();
    console.log('App dependencies initialized successfully!');
  } catch (e, st) {
    console.log('Firebase initialization failed: $e');
    FirebaseCrashlytics.instance.recordError(e, st, reason: 'init_failure');
    rethrow;
  }
});
