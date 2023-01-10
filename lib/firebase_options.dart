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
    apiKey: 'AIzaSyAbKmjqsl6mj5JDYzN4buz3elqw2ff40ew',
    appId: '1:177725354636:web:e503c335281a9f5b5a81a9',
    messagingSenderId: '177725354636',
    projectId: 'moshahda',
    authDomain: 'moshahda.firebaseapp.com',
    storageBucket: 'moshahda.appspot.com',
    measurementId: 'G-26VVH6QM1K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4sltqzJv5NapZncacDR2LxOuQ5poNQzM',
    appId: '1:177725354636:android:8620885a3a42fa155a81a9',
    messagingSenderId: '177725354636',
    projectId: 'moshahda',
    storageBucket: 'moshahda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBc_onoUvly-pxCMpiWeTPSCGQq9APZp9Y',
    appId: '1:177725354636:ios:06c91ffc17aef3cb5a81a9',
    messagingSenderId: '177725354636',
    projectId: 'moshahda',
    storageBucket: 'moshahda.appspot.com',
    iosClientId: '177725354636-m5dq3eu1qnuqia17lhsaffq55ce9rpvf.apps.googleusercontent.com',
    iosBundleId: 'com.example.moshahdaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBc_onoUvly-pxCMpiWeTPSCGQq9APZp9Y',
    appId: '1:177725354636:ios:06c91ffc17aef3cb5a81a9',
    messagingSenderId: '177725354636',
    projectId: 'moshahda',
    storageBucket: 'moshahda.appspot.com',
    iosClientId: '177725354636-m5dq3eu1qnuqia17lhsaffq55ce9rpvf.apps.googleusercontent.com',
    iosBundleId: 'com.example.moshahdaApp',
  );
}
