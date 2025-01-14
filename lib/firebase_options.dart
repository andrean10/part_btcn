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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBX8YRUINt3cVJlwEm4Adr1yOErdSVupBc',
    appId: '1:95779639063:android:7c84603772232b589ab152',
    messagingSenderId: '95779639063',
    projectId: 'part-btcn',
    storageBucket: 'part-btcn.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFUW6rZlpi6r4Br4NoV54irQi-9dsCAsA',
    appId: '1:95779639063:ios:d88c376e29a6119c9ab152',
    messagingSenderId: '95779639063',
    projectId: 'part-btcn',
    storageBucket: 'part-btcn.firebasestorage.app',
    iosBundleId: 'com.example.partBtcn',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC8PuIrjzSgYWIVdlJpaKwLW7m1_m84YV8',
    appId: '1:95779639063:web:c1c33395e5fb02439ab152',
    messagingSenderId: '95779639063',
    projectId: 'part-btcn',
    authDomain: 'part-btcn.firebaseapp.com',
    storageBucket: 'part-btcn.firebasestorage.app',
    measurementId: 'G-C39LLDYTXP',
  );

}