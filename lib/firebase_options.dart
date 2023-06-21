// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    // ignore: combinators_ordering
    show
        defaultTargetPlatform,
        kIsWeb,
        TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdDk3A3m8he8jIMz-k8g3xVr7IZF4L6b8',
    appId: '1:960384948251:web:9b81eb79f86761dcb740be',
    messagingSenderId: '960384948251',
    projectId: 'kitap-sarayi-service',
    authDomain: 'kitap-sarayi-service.firebaseapp.com',
    storageBucket: 'kitap-sarayi-service.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrLr6tpdAOsyWGclUGyUNRNtOpzBlnpRc',
    appId: '1:960384948251:android:b9cc5d3f7787b7b2b740be',
    messagingSenderId: '960384948251',
    projectId: 'kitap-sarayi-service',
    storageBucket: 'kitap-sarayi-service.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoRbV-QUOBH4xrYvwlkD4--xfDrXKSwhU',
    appId: '1:960384948251:ios:95ef0029faec53b2b740be',
    messagingSenderId: '960384948251',
    projectId: 'kitap-sarayi-service',
    storageBucket: 'kitap-sarayi-service.appspot.com',
    iosClientId:
        '960384948251-ui45dnul6ori6q8poqfj13f5fcgbhrfi.apps.googleusercontent.com',
    iosBundleId: 'com.example.kitapSarayiApp',
  );
}
