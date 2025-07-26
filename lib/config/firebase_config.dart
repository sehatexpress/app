import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDx3TukgjBlnq6Qu8yAY8ibHEHKAIyj4aI',
    appId: '1:398848679909:web:aa9717310cde18774e590c',
    messagingSenderId: '398848679909',
    projectId: 'sehatexpresss',
    authDomain: 'sehatexpresss.firebaseapp.com',
    storageBucket: 'sehatexpresss.firebasestorage.app',
    measurementId: 'G-WHSKXRN6PM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkI5XfhoOU0z9QBAHYlJhQmN9mUF_bgR4',
    appId: '1:398848679909:android:7094eda9a54e95264e590c',
    messagingSenderId: '398848679909',
    projectId: 'sehatexpresss',
    storageBucket: 'sehatexpresss.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPkfUExEaQ096iYacIkKFuEbbuEnsWm1M',
    appId: '1:398848679909:ios:89c4abd81b2985ae4e590c',
    messagingSenderId: '398848679909',
    projectId: 'sehatexpresss',
    storageBucket: 'sehatexpresss.firebasestorage.app',
    androidClientId:
        '398848679909-1003tf2r619j8j48kfma4ojsmcn80jik.apps.googleusercontent.com',
    iosClientId:
        '398848679909-5m038vl5q566g5qqi3m0auide1hecdhc.apps.googleusercontent.com',
    iosBundleId: 'com.sehatexpress.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPkfUExEaQ096iYacIkKFuEbbuEnsWm1M',
    appId: '1:398848679909:ios:89c4abd81b2985ae4e590c',
    messagingSenderId: '398848679909',
    projectId: 'sehatexpresss',
    storageBucket: 'sehatexpresss.firebasestorage.app',
    androidClientId:
        '398848679909-1003tf2r619j8j48kfma4ojsmcn80jik.apps.googleusercontent.com',
    iosClientId:
        '398848679909-5m038vl5q566g5qqi3m0auide1hecdhc.apps.googleusercontent.com',
    iosBundleId: 'com.sehatexpress.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDx3TukgjBlnq6Qu8yAY8ibHEHKAIyj4aI',
    appId: '1:398848679909:web:209275e505aec5fa4e590c',
    messagingSenderId: '398848679909',
    projectId: 'sehatexpresss',
    authDomain: 'sehatexpresss.firebaseapp.com',
    storageBucket: 'sehatexpresss.firebasestorage.app',
    measurementId: 'G-D1GDZ624L9',
  );
}
