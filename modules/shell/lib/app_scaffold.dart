import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:di/di.dart';
import 'package:ui_kit/ui_kit.dart' show AppTheme;

import 'res/res.dart';
import 'widget/widget.dart';

/// Корневой виджет приложения (composition root).
///
/// Собирает дерево над [MaterialApp]: [EasyLocalization] (локали) → [RestartWidget]
/// (пересоздание дерева dev-инструментами) → [ThemeCubit] (themeMode) →
/// `MaterialApp.router` с роутером из DI. [overlayBuilder] — необязательная
/// обёртка (dev-сборка кладёт плавающую debug-кнопку поверх дерева).
class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, this.overlayBuilder});

  final TransitionBuilder? overlayBuilder;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: L10n.supportedLocales,
      path: L10n.translationsPath,
      fallbackLocale: L10n.fallbackLocale,
      // Без startLocale: он перебивал сохранённую локаль на каждом запуске.
      // saveLocale по умолчанию true — easy_localization сам персистит выбор в
      // SharedPreferences и восстанавливает его при старте; первый запуск берёт
      // fallbackLocale.
      // RestartWidget выше дерева: dev-инструменты пересоздают всё дерево (и все
      // BlocProvider) после смены окружения/прокси, чтобы виджеты взяли свежие
      // сервисы из getIt, а не держали старые ссылки.
      child: RestartWidget(child: _MaterialRoot(overlayBuilder: overlayBuilder)),
    );
  }
}

class _MaterialRoot extends StatelessWidget {
  const _MaterialRoot({this.overlayBuilder});

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
