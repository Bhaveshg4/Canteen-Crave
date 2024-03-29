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
    apiKey: 'AIzaSyCFg2v8_zlPyIxsLWjCM9DMqzrP4fyxyQI',
    appId: '1:156374383715:web:54d0ed881008c23fe0cc56',
    messagingSenderId: '156374383715',
    projectId: 'paliwalmess-42e50',
    authDomain: 'paliwalmess-42e50.firebaseapp.com',
    storageBucket: 'paliwalmess-42e50.appspot.com',
    measurementId: 'G-FZC012D0QT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFXoBN6R3X6qp2Sjka7C5lidyGKBDvNi0',
    appId: '1:156374383715:android:1748ed9846cec10ee0cc56',
    messagingSenderId: '156374383715',
    projectId: 'paliwalmess-42e50',
    storageBucket: 'paliwalmess-42e50.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtCsRLfAOAKLJx3VBwEJnIZ2ZjVIXGv_8',
    appId: '1:156374383715:ios:af0e716667397b7ee0cc56',
    messagingSenderId: '156374383715',
    projectId: 'paliwalmess-42e50',
    storageBucket: 'paliwalmess-42e50.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtCsRLfAOAKLJx3VBwEJnIZ2ZjVIXGv_8',
    appId: '1:156374383715:ios:ab66ccab98fc6e29e0cc56',
    messagingSenderId: '156374383715',
    projectId: 'paliwalmess-42e50',
    storageBucket: 'paliwalmess-42e50.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
