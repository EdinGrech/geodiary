import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyAwobtPB0JiNFLdq-2-TXfXsOok4CiSJ1c',
    appId: '1:973681884601:android:2d939c40f07ed52da24a68',
    messagingSenderId: '973681884601',
    projectId: 'geodiary-de048',
    databaseURL: 'https://geodiary-de048-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'geodiary-de048.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnhoHCLUQnPCZVpR7CkKW1V0yZMOfqwc8',
    appId: '1:973681884601:ios:2482316f63d49607a24a68',
    messagingSenderId: '973681884601',
    projectId: 'geodiary-de048',
    databaseURL: 'https://geodiary-de048-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'geodiary-de048.firebasestorage.app',
    iosBundleId: 'com.example.geodiary',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBoh9GaBeML7XAeJ0hlUCxcpgTLCqi8Xi4',
    appId: '1:973681884601:web:815934ee0c509e84a24a68',
    messagingSenderId: '973681884601',
    projectId: 'geodiary-de048',
    authDomain: 'geodiary-de048.firebaseapp.com',
    databaseURL: 'https://geodiary-de048-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'geodiary-de048.firebasestorage.app',
    measurementId: 'G-L760492827',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnhoHCLUQnPCZVpR7CkKW1V0yZMOfqwc8',
    appId: '1:973681884601:ios:2482316f63d49607a24a68',
    messagingSenderId: '973681884601',
    projectId: 'geodiary-de048',
    databaseURL: 'https://geodiary-de048-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'geodiary-de048.firebasestorage.app',
    iosBundleId: 'com.example.geodiary',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoh9GaBeML7XAeJ0hlUCxcpgTLCqi8Xi4',
    appId: '1:973681884601:web:9d73e7e3c42349fca24a68',
    messagingSenderId: '973681884601',
    projectId: 'geodiary-de048',
    authDomain: 'geodiary-de048.firebaseapp.com',
    databaseURL: 'https://geodiary-de048-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'geodiary-de048.firebasestorage.app',
    measurementId: 'G-K0GNXKN2CJ',
  );

}