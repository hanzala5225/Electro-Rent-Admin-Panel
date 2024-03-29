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
    apiKey: 'AIzaSyByghvOxdZOCReRy0PCrl2WlqiU0v80_h4',
    appId: '1:951794321880:web:59beb2dfdd8225e5b88aad',
    messagingSenderId: '951794321880',
    projectId: 'electro-rent-3838d',
    authDomain: 'electro-rent-3838d.firebaseapp.com',
    storageBucket: 'electro-rent-3838d.appspot.com',
    measurementId: 'G-64V1D8R4C7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoH5Ltvq8agjwxkXeuke-Y55-35j5Aq48',
    appId: '1:951794321880:android:e103e36964fdff3ab88aad',
    messagingSenderId: '951794321880',
    projectId: 'electro-rent-3838d',
    storageBucket: 'electro-rent-3838d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7gOn-ZTJQl2cpZ60szTA33LJfOoaqGWQ',
    appId: '1:951794321880:ios:28ea17939d8f2c07b88aad',
    messagingSenderId: '951794321880',
    projectId: 'electro-rent-3838d',
    storageBucket: 'electro-rent-3838d.appspot.com',
    androidClientId: '951794321880-r8o4q8mcjcckit1vv5dk6vdlikmtnbe5.apps.googleusercontent.com',
    iosClientId: '951794321880-22v1597t3ud2n8hkpiqvegi1b0h4g750.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminPanel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7gOn-ZTJQl2cpZ60szTA33LJfOoaqGWQ',
    appId: '1:951794321880:ios:83a564c580b76695b88aad',
    messagingSenderId: '951794321880',
    projectId: 'electro-rent-3838d',
    storageBucket: 'electro-rent-3838d.appspot.com',
    androidClientId: '951794321880-r8o4q8mcjcckit1vv5dk6vdlikmtnbe5.apps.googleusercontent.com',
    iosClientId: '951794321880-tpvjfb91oebdc1bk3ftnv9ser9jgulo9.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminPanel.RunnerTests',
  );
}
