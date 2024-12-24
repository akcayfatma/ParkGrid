import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAtmZ-beejl-IBKy6MANaGr0tTefY6GVII',
    appId: '1:191958698784:android:d21e6defc866f2fea82545',
    messagingSenderId: '191958698784',
    projectId: 'parkgrid-a7e26',
    storageBucket: 'parkgrid-a7e26.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeO8bHMsRiQGqG9COFC3qn9agtRltDaX0',
    appId: '1:191958698784:ios:aeac76e113706389a82545',
    messagingSenderId: '191958698784',
    projectId: 'parkgrid-a7e26',
    storageBucket: 'parkgrid-a7e26.firebasestorage.app',
    iosBundleId: 'com.example.parkgridy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCL0ZNciMVQf_y5g8udg0AYpzJvfGILSUs',
    appId: '1:191958698784:web:cb3f3b000dbcdbaea82545',
    messagingSenderId: '191958698784',
    projectId: 'parkgrid-a7e26',
    authDomain: 'parkgrid-a7e26.firebaseapp.com',
    storageBucket: 'parkgrid-a7e26.firebasestorage.app',
  );

}