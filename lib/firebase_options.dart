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
    apiKey: 'AIzaSyCjQQGw1yNBIvx9adRBHsADHL4G6WD4Trw',
    appId: '1:255221626122:web:5b62169183ce6448bab6f3',
    messagingSenderId: '255221626122',
    projectId: 'mtgarchive-c329d',
    authDomain: 'mtgarchive-c329d.firebaseapp.com',
    storageBucket: 'mtgarchive-c329d.appspot.com',
    measurementId: 'G-CYM1R1PQ5W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYNeg2553vzaDUJdnxaeMT9q1hiiFOn7Q',
    appId: '1:255221626122:android:53989b3d5f7179e7bab6f3',
    messagingSenderId: '255221626122',
    projectId: 'mtgarchive-c329d',
    storageBucket: 'mtgarchive-c329d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-EDoehojw2-gY9LAXlth9iZ2p9jqDfDg',
    appId: '1:255221626122:ios:3c2c2226e335674fbab6f3',
    messagingSenderId: '255221626122',
    projectId: 'mtgarchive-c329d',
    storageBucket: 'mtgarchive-c329d.appspot.com',
    iosClientId: '255221626122-ufafn2t2623sh7rrnebaurmaj8qsb8rf.apps.googleusercontent.com',
    iosBundleId: 'com.tremend.playground',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-EDoehojw2-gY9LAXlth9iZ2p9jqDfDg',
    appId: '1:255221626122:ios:3c2c2226e335674fbab6f3',
    messagingSenderId: '255221626122',
    projectId: 'mtgarchive-c329d',
    storageBucket: 'mtgarchive-c329d.appspot.com',
    iosClientId: '255221626122-ufafn2t2623sh7rrnebaurmaj8qsb8rf.apps.googleusercontent.com',
    iosBundleId: 'com.tremend.playground',
  );
}