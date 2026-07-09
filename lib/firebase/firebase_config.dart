import 'package:firebase_core/firebase_core.dart';

import 'dev/firebase_options.dart' as dev;
import 'prod/firebase_options.dart' as prod;

/// Firebase-опции по окружению. Каждый flavor — свой Firebase-проект
/// (acits-prod / acits-dev), поэтому события/краши не смешиваются.
/// Analytics — на android/ios/web; Crashlytics — только android/ios
/// (web-плагина нет, вызовы под guard `kIsWeb` в main).
FirebaseOptions get prodFirebaseOptions => prod.DefaultFirebaseOptions.currentPlatform;

FirebaseOptions get devFirebaseOptions => dev.DefaultFirebaseOptions.currentPlatform;
