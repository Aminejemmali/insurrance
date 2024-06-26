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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCO78LW5Ppjn0lmGF7W6HTm-kyHYXQrLzE',
    appId: '1:406112714890:android:ae698bc495a8ad6ad82d73',
    messagingSenderId: '406112714890',
    projectId: 'insurrance-ba5dd',
    storageBucket: 'insurrance-ba5dd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_HmCQjUPXtm5bb3YtswMT1WkvHlQvPFs',
    appId: '1:406112714890:ios:83593d75e483dba6d82d73',
    messagingSenderId: '406112714890',
    projectId: 'insurrance-ba5dd',
    storageBucket: 'insurrance-ba5dd.appspot.com',
    iosBundleId: 'com.example.insurrance',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCFP9-gy_kswlmQlGEsH9_kJZWWg4-hG9E',
    appId: '1:406112714890:web:ec0518c34a2f6189d82d73',
    messagingSenderId: '406112714890',
    projectId: 'insurrance-ba5dd',
    authDomain: 'insurrance-ba5dd.firebaseapp.com',
    storageBucket: 'insurrance-ba5dd.appspot.com',
    measurementId: 'G-0EY8L1GHDR',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_HmCQjUPXtm5bb3YtswMT1WkvHlQvPFs',
    appId: '1:406112714890:ios:83593d75e483dba6d82d73',
    messagingSenderId: '406112714890',
    projectId: 'insurrance-ba5dd',
    storageBucket: 'insurrance-ba5dd.appspot.com',
    iosBundleId: 'com.example.insurrance',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCFP9-gy_kswlmQlGEsH9_kJZWWg4-hG9E',
    appId: '1:406112714890:web:a98fd317aba8c3f2d82d73',
    messagingSenderId: '406112714890',
    projectId: 'insurrance-ba5dd',
    authDomain: 'insurrance-ba5dd.firebaseapp.com',
    storageBucket: 'insurrance-ba5dd.appspot.com',
    measurementId: 'G-WV94J4CJJE',
  );

}