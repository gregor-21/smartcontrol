// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return macos;
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2IheRLezcWjNxckC1I1X_PWzySil-v6M',
    appId: '1:1047593904058:web:04b28d0bda57b3b0a29f83',
    messagingSenderId: '1047593904058',
    projectId: 'tccsmartcontrol',
    authDomain: 'tccsmartcontrol.firebaseapp.com',
    databaseURL: 'https://tccsmartcontrol-default-rtdb.firebaseio.com',
    storageBucket: 'tccsmartcontrol.appspot.com',
    measurementId: 'G-3VGZX4XBYD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdjIkMp65DVGrDn3cegpP_JTbBGxdFyNc',
    appId: '1:1047593904058:android:ed13866bdad17ba2a29f83',
    messagingSenderId: '1047593904058',
    projectId: 'tccsmartcontrol',
    databaseURL: 'https://tccsmartcontrol-default-rtdb.firebaseio.com',
    storageBucket: 'tccsmartcontrol.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLkySi7H6Sh9rLikLO0i1UOq3JPmslyZs',
    appId: '1:1047593904058:ios:cefe245f82f55f3da29f83',
    messagingSenderId: '1047593904058',
    projectId: 'tccsmartcontrol',
    databaseURL: 'https://tccsmartcontrol-default-rtdb.firebaseio.com',
    storageBucket: 'tccsmartcontrol.appspot.com',
    iosBundleId: 'com.example.tccsmartcontrol',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLkySi7H6Sh9rLikLO0i1UOq3JPmslyZs',
    appId: '1:1047593904058:ios:2dd240d61b0e1e59a29f83',
    messagingSenderId: '1047593904058',
    projectId: 'tccsmartcontrol',
    databaseURL: 'https://tccsmartcontrol-default-rtdb.firebaseio.com',
    storageBucket: 'tccsmartcontrol.appspot.com',
    iosBundleId: 'com.example.tccsmartcontrol.RunnerTests',
  );
}
