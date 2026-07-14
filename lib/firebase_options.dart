import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration for the Dawrati app.
///
/// This config (apiKey, projectId, etc.) is not a secret — Firebase web
/// configs are meant to be public; access is controlled by Firestore
/// security rules and Google Cloud API key restrictions, not by hiding
/// these values. Safe to commit.
///
/// Only the Web platform is registered in Firebase so far. Android and iOS
/// need their own app registration (google-services.json /
/// GoogleService-Info.plist) before store release — see task #12.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        // Falls back to the web config so the app still runs during
        // development. Replace with platform-specific FirebaseOptions
        // (from google-services.json / GoogleService-Info.plist) before
        // shipping to Android/iOS.
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBEuELV1B3l9An5IyTDz4ZhvoxAweCyMmI',
    authDomain: 'dawrati-app.firebaseapp.com',
    projectId: 'dawrati-app',
    storageBucket: 'dawrati-app.firebasestorage.app',
    messagingSenderId: '123563739832',
    appId: '1:123563739832:web:8de7940a8ad12d6c85824d',
    measurementId: 'G-FME6BMV4BD',
  );
}
