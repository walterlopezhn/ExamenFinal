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
    apiKey: 'AIzaSyDqsRc5yXzs8iUSMNlWnpkhZ3NhHDSqo18',
    appId: '1:246925700936:web:bc916d7bf3c1b1f5a94d7d',
    messagingSenderId: '246925700936',
    projectId: 'starwar-817d5',
    authDomain: 'starwar-817d5.firebaseapp.com',
    storageBucket: 'starwar-817d5.firebasestorage.app',
    measurementId: 'G-YG2T41997E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsDRrNhWagB6Mn2oxjufH-vss9WTj94uo',
    appId: '1:246925700936:android:27162ac7c9d0943aa94d7d',
    messagingSenderId: '246925700936',
    projectId: 'starwar-817d5',
    storageBucket: 'starwar-817d5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRY5_39v3uIYuSxZLPkWnwNwuS93RcIAY',
    appId: '1:246925700936:ios:69f51a3226a997e2a94d7d',
    messagingSenderId: '246925700936',
    projectId: 'starwar-817d5',
    storageBucket: 'starwar-817d5.firebasestorage.app',
    iosBundleId: 'com.example.examen2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRY5_39v3uIYuSxZLPkWnwNwuS93RcIAY',
    appId: '1:246925700936:ios:69f51a3226a997e2a94d7d',
    messagingSenderId: '246925700936',
    projectId: 'starwar-817d5',
    storageBucket: 'starwar-817d5.firebasestorage.app',
    iosBundleId: 'com.example.examen2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDqsRc5yXzs8iUSMNlWnpkhZ3NhHDSqo18',
    appId: '1:246925700936:web:75e57c68166739cba94d7d',
    messagingSenderId: '246925700936',
    projectId: 'starwar-817d5',
    authDomain: 'starwar-817d5.firebaseapp.com',
    storageBucket: 'starwar-817d5.firebasestorage.app',
    measurementId: 'G-JGHF0EZEDD',
  );
}
