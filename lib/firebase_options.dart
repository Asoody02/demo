// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCwGaXPBxLyDbhyBxLlu1QupSosSFLfoRA',
    appId: '1:969962080511:web:a2ea52c55d11ba5804e4ca',
    messagingSenderId: '969962080511',
    projectId: 'pollapp2024',
    authDomain: 'pollapp2024.firebaseapp.com',
    storageBucket: 'pollapp2024.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2hbgIgTVH4V-kb_kPOMtzfQ_CeD7sI6k',
    appId: '1:969962080511:android:a0f86e153f95123c04e4ca',
    messagingSenderId: '969962080511',
    projectId: 'pollapp2024',
    storageBucket: 'pollapp2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNWmi0UCLgziPzk8eV6ArmLrlDxY8IBi8',
    appId: '1:969962080511:ios:f32501d6d8f7cf0e04e4ca',
    messagingSenderId: '969962080511',
    projectId: 'pollapp2024',
    storageBucket: 'pollapp2024.appspot.com',
    iosBundleId: 'com.google.firebase.presents.demoPoll',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCNWmi0UCLgziPzk8eV6ArmLrlDxY8IBi8',
    appId: '1:969962080511:ios:f32501d6d8f7cf0e04e4ca',
    messagingSenderId: '969962080511',
    projectId: 'pollapp2024',
    storageBucket: 'pollapp2024.appspot.com',
    iosBundleId: 'com.google.firebase.presents.demoPoll',
  );
}