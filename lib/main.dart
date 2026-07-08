import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/l10n/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/strings.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/di/di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initDi();
  runApp(const AcitsApp());
}

/// Корневой виджет приложения. Оборачивает [MyApp] в [EasyLocalization],
/// который должен стоять выше [MaterialApp] в дереве.
class AcitsApp extends StatelessWidget {
  const AcitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: L10n.supportedLocales,
      path: L10n.translationsPath,
      fallbackLocale: L10n.fallbackLocale,
      startLocale: L10n.fallbackLocale,
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    );
  }
}
