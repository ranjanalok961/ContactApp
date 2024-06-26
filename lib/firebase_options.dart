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
    apiKey: 'AIzaSyD_voNuuqfV1BnMsoI_PSbNnR_WxZX0b64',
    appId: '1:749782380132:web:bf1ce61e897ab29e2c7971',
    messagingSenderId: '749782380132',
    projectId: 'contactapp-ca6ad',
    authDomain: 'contactapp-ca6ad.firebaseapp.com',
    storageBucket: 'contactapp-ca6ad.appspot.com',
    measurementId: 'G-6B7ESK3VRW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyXPHw_b7CA3OZJ5V7_G616k0GZwyH1T4',
    appId: '1:749782380132:android:724942ccf6782b782c7971',
    messagingSenderId: '749782380132',
    projectId: 'contactapp-ca6ad',
    storageBucket: 'contactapp-ca6ad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHsBNGRxNX_jgkljQqekcSsdUBOGK3y6I',
    appId: '1:749782380132:ios:e50e0654a811d7c02c7971',
    messagingSenderId: '749782380132',
    projectId: 'contactapp-ca6ad',
    storageBucket: 'contactapp-ca6ad.appspot.com',
    iosBundleId: 'com.example.contactapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHsBNGRxNX_jgkljQqekcSsdUBOGK3y6I',
    appId: '1:749782380132:ios:e50e0654a811d7c02c7971',
    messagingSenderId: '749782380132',
    projectId: 'contactapp-ca6ad',
    storageBucket: 'contactapp-ca6ad.appspot.com',
    iosBundleId: 'com.example.contactapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD_voNuuqfV1BnMsoI_PSbNnR_WxZX0b64',
    appId: '1:749782380132:web:306074b6dc543b132c7971',
    messagingSenderId: '749782380132',
    projectId: 'contactapp-ca6ad',
    authDomain: 'contactapp-ca6ad.firebaseapp.com',
    storageBucket: 'contactapp-ca6ad.appspot.com',
    measurementId: 'G-VMVS0KZSM3',
  );
}
