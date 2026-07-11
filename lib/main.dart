import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/res/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/strings.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/firebase/firebase_config.dart';
import 'package:acits_flutter/util/restart_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Обычные web-пути (/login вместо /#/login). No-op на мобильных. Требует
  // SPA-fallback на сервере (nginx try_files; для GitHub Pages — 404.html).
  usePathUrlStrategy();

  // prod-окружение: Firebase-проект acits-prod на android/ios/web (Analytics
  // везде). dev-сборка (test/dev/main.dart) поднимает свой acits-dev. Crashlytics
  // существует только на мобильных — на web плагина нет, обработчики под kIsWeb.
  await Firebase.initializeApp(options: prodFirebaseOptions);
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initDi();
  runApp(const AcitsApp());
}

/// Корневой виджет приложения. Оборачивает [MyApp] в [EasyLocalization],
/// который должен стоять выше [MaterialApp] в дереве.
///
/// [overlayBuilder] — необязательная обёртка над деревом MaterialApp (передаётся
/// в её `builder:`). dev-сборка использует её для плавающей debug-кнопки; в prod
/// не задаётся.
class AcitsApp extends StatelessWidget {
  const AcitsApp({super.key, this.overlayBuilder});

  final TransitionBuilder? overlayBuilder;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: L10n.supportedLocales,
      path: L10n.translationsPath,
      fallbackLocale: L10n.fallbackLocale,
      startLocale: L10n.fallbackLocale,
      // RestartWidget выше MyApp: dev-инструменты пересоздают всё дерево (и все
      // BlocProvider) после смены окружения/прокси, чтобы виджеты взяли свежие
      // сервисы из getIt, а не держали старые ссылки.
      child: RestartWidget(child: MyApp(overlayBuilder: overlayBuilder)),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.overlayBuilder});

  final TransitionBuilder? overlayBuilder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.commonAppName,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme.light(
          primary: ColorRes.accent,
          secondary: ColorRes.indicatorActive,
          surface: ColorRes.background,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: ColorRes.primaryButton,
          textTheme: ButtonTextTheme.primary,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
        textTheme: const TextTheme(labelLarge: StyleRes.button),
        inputDecorationTheme: const InputDecorationTheme(iconColor: ColorRes.accent),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: ColorRes.accent),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      color: ColorRes.accent,
      scaffoldMessengerKey: getIt<GlobalKey<ScaffoldMessengerState>>(),
      routerConfig: getIt<GoRouter>(),
      builder: overlayBuilder,
    );
  }
}
