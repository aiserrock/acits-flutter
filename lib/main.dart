import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:acits_flutter/res/l10n.dart';
import 'package:acits_flutter/res/strings.dart';
import 'package:acits_flutter/res/theme.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/widget/cubit/theme_cubit.dart';
import 'package:acits_flutter/firebase/firebase_config.dart';
import 'package:acits_flutter/util/app_version.dart';
import 'package:acits_flutter/util/logger/app_bloc_observer.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:acits_flutter/util/phone_frame.dart';
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

  // Независимые инициализации — параллельно (ускоряет старт, особенно «белый
  // экран» на web): локализация, ориентация и версия приложения не зависят
  // друг от друга. initDi идёт после — часть сервисов может опираться на них.
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    AppVersion.load(),
  ]);
  await initDi();

  // Логи всех cubit'ов/bloc'ов идут в общий Talker (в prod-release он выключен).
  Bloc.observer = createAppBlocObserver(getIt<Talker>());
  Log.info('App start · flavor=prod');

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
    // ThemeCubit стоит выше MaterialApp: BlocBuilder перестраивает приложение
    // при смене режима, отдавая свежий themeMode. theme/darkTheme — статичные
    // M3-схемы, Flutter сам выбирает нужную по themeMode.
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: StringConst.commonAppName,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            color: AppTheme.light.colorScheme.primary,
            scaffoldMessengerKey: getIt<GlobalKey<ScaffoldMessengerState>>(),
            routerConfig: getIt<GoRouter>(),
            // На web-десктопе ограничиваем интерфейс шириной смартфона
            // (PhoneFrame), затем поверх — необязательный overlayBuilder
            // (dev-кнопка). Порядок: сначала рамка, потом overlay, чтобы кнопка
            // была над «телефоном».
            builder: (context, child) {
              Widget framed = PhoneFrame(child: child ?? const SizedBox.shrink());
              if (overlayBuilder != null) framed = overlayBuilder!(context, framed);
              return framed;
            },
          );
        },
      ),
    );
  }
}
