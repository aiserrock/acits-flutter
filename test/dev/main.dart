import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';

import 'package:acits_flutter/main.dart';
import 'package:acits_flutter/firebase/firebase_config.dart';
import 'di/di_container.dart';
import 'ui/debug_screen/debug_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // обычные web-пути (/login), no-op на мобильных

  // dev-окружение: свой Firebase-проект acits-dev. Crashlytics только на
  // android/ios (web-плагина нет — под guard kIsWeb).
  await Firebase.initializeApp(options: devFirebaseOptions);
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _setupLogging();
  await initDevDi();
  // Плавающая debug-кнопка поверх приложения (только dev, только debug mode).
  runApp(AcitsApp(overlayBuilder: (_, child) => DebugOverlay(child: child ?? const SizedBox())));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    // ignore: avoid_print
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
