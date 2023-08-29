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
    apiKey: 'AIzaSyDx_97v3QT5SjJMvUNAvusy3hc-bS8XKjI',
    appId: '1:141454232151:web:8c66af03b9745d5749f112',
    messagingSenderId: '141454232151',
    projectId: 'greenup-b200d',
    authDomain: 'greenup-b200d.firebaseapp.com',
    storageBucket: 'greenup-b200d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-9qE5DnLR770pYq3APFCD5H6lwZK2Zno',
    appId: '1:141454232151:android:4312bc4653f3a3ce49f112',
    messagingSenderId: '141454232151',
    projectId: 'greenup-b200d',
    storageBucket: 'greenup-b200d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqEqWQbV-GV6Suzs1B5Jf0AfhaGRgEy-Q',
    appId: '1:141454232151:ios:fbff1fc586b53b6e49f112',
    messagingSenderId: '141454232151',
    projectId: 'greenup-b200d',
    storageBucket: 'greenup-b200d.appspot.com',
    iosClientId: '141454232151-s11erqo6jh0se73vi9o5cqvdp8eanpmf.apps.googleusercontent.com',
    iosBundleId: 'com.example.template',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqEqWQbV-GV6Suzs1B5Jf0AfhaGRgEy-Q',
    appId: '1:141454232151:ios:fbff1fc586b53b6e49f112',
    messagingSenderId: '141454232151',
    projectId: 'greenup-b200d',
    storageBucket: 'greenup-b200d.appspot.com',
    iosClientId: '141454232151-s11erqo6jh0se73vi9o5cqvdp8eanpmf.apps.googleusercontent.com',
    iosBundleId: 'com.example.template',
  );
}
