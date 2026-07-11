import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/main.dart';
import 'package:acits_flutter/firebase/firebase_config.dart';
import 'package:acits_flutter/util/logger/app_bloc_observer.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'di/di_container.dart';
import 'service/shared_pref/debug_preference_storage.dart';
import 'service/client/proxy_http_overrides.dart';
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

  // Логи всех cubit'ов/bloc'ов идут в общий Talker (виден в debug-меню → «Логи»).
  Bloc.observer = createAppBlocObserver(getIt<Talker>());
  Log.info('App start · flavor=dev');

  // Прокси (Charles/mitmproxy) — глобальный HttpOverrides, покрывает ВЕСЬ
  // трафик (chopper, dio, картинки). Ставится при старте, читая сохранённый
  // флаг из storage; поэтому смена прокси в debug требует полного перезапуска
  // приложения (не kIsWeb — HttpOverrides только на нативе).
  if (!kIsWeb) {
    final debugPrefs = getIt<DebugPreferenceStorage>();
    final proxy = debugPrefs.proxy;
    if (debugPrefs.proxyEnabled && proxy != null && proxy.isNotEmpty) {
      HttpOverrides.global = ProxyHttpOverrides(proxy);
    }
  }

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
