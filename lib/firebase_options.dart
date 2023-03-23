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
    apiKey: 'AIzaSyBo7jkYiKPqfxXyQroXal_KHwAyxIwdjM0',
    appId: '1:299027057720:web:ba120931bda18c62d36acd',
    messagingSenderId: '299027057720',
    projectId: 'piwc-5e5a0',
    authDomain: 'piwc-5e5a0.firebaseapp.com',
    databaseURL: 'https://piwc-5e5a0-default-rtdb.firebaseio.com',
    storageBucket: 'piwc-5e5a0.appspot.com',
    measurementId: 'G-PY0YXK76S9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYcgEwxJQynOhlXqzoCdaWlmQiabTlkAY',
    appId: '1:299027057720:android:9dcb529cd458139fd36acd',
    messagingSenderId: '299027057720',
    projectId: 'piwc-5e5a0',
    databaseURL: 'https://piwc-5e5a0-default-rtdb.firebaseio.com',
    storageBucket: 'piwc-5e5a0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVYmh-kjHsGrxwf4fwqszOZehj6Va4m0A',
    appId: '1:299027057720:ios:f35c68fab7a1719ad36acd',
    messagingSenderId: '299027057720',
    projectId: 'piwc-5e5a0',
    databaseURL: 'https://piwc-5e5a0-default-rtdb.firebaseio.com',
    storageBucket: 'piwc-5e5a0.appspot.com',
    androidClientId: '299027057720-apk7uar9hpilhqujjhgeppj44n1qm4i9.apps.googleusercontent.com',
    iosClientId: '299027057720-7o7h7m5q6nt2ddbbui890s1clb0t8b3n.apps.googleusercontent.com',
    iosBundleId: 'com.example.piwc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVYmh-kjHsGrxwf4fwqszOZehj6Va4m0A',
    appId: '1:299027057720:ios:f35c68fab7a1719ad36acd',
    messagingSenderId: '299027057720',
    projectId: 'piwc-5e5a0',
    databaseURL: 'https://piwc-5e5a0-default-rtdb.firebaseio.com',
    storageBucket: 'piwc-5e5a0.appspot.com',
    androidClientId: '299027057720-apk7uar9hpilhqujjhgeppj44n1qm4i9.apps.googleusercontent.com',
    iosClientId: '299027057720-7o7h7m5q6nt2ddbbui890s1clb0t8b3n.apps.googleusercontent.com',
    iosBundleId: 'com.example.piwc',
  );
}
