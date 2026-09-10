import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

import 'directories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: const AcitsUiKitApp(),
    ),
  );
}

/// Standalone-каталог дизайн-системы ACITS на widgetbook.
///
/// Живой адаптивный хост: на вебе — трёхколоночный layout, на телефоне —
/// свёрнутая навигация, всё без крашей заброшенного storybook. Показывает
/// общий каталог [buildGalleryDirectories] (из `ui_kit_gallery`), который тот
/// же самый переиспользует debug-экран основного приложения.
class AcitsUiKitApp extends StatelessWidget {
  const AcitsUiKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: buildGalleryDirectories(),
      // Тема самого UI widgetbook (панели/навигация) в фирменных тонах ACITS.
      lightTheme: ThemeData.light(useMaterial3: true).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: _brand)),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: _brand, brightness: Brightness.dark),
      ),
      header: const _BrandHeader(),
      // Каждый экспонат рендерится внутри EasyLocalization, чтобы `.tr()` в
      // ui_kit-виджетах (holders, sort chips) резолвился в реальный текст.
      appBuilder: (context, child) => EasyLocalization(
        supportedLocales: const [Locale('ru'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru'),
        child: Builder(builder: (context) => child),
      ),
      addons: [
        // Продовые токены дизайн-системы: тумблер Light/Dark применяет реальную
        // AppTheme к превью.
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: AppTheme.light),
            WidgetbookTheme(name: 'Dark', data: AppTheme.dark),
          ],
        ),
        // Локализация превью (ru/en) — общий переключатель поверх всех
        // экспонатов.
        LocalizationAddon(
          locales: const [Locale('ru'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
        ),
        // Адаптив: обрамление в реальные устройства. Полный набор пресетов
        // widgetbook (iOS + Android + desktop) — то, чего не хватало для
        // проверки вёрстки на всех форм-факторах.
        ViewportAddon(_allViewports),
      ],
    );
  }
}

const _brand = Color(0xFF6776E0);

/// Полный набор viewport-пресетов widgetbook: «без рамки» + все iOS/Android
/// телефоны и планшеты + desktop (macOS/Windows/Linux). Даёт проверить вёрстку
/// на любом форм-факторе прямо в галерее.
const _allViewports = <ViewportData>[
  Viewports.none,
  ...IosViewports.all,
  ...AndroidViewports.all,
  ...MacosViewports.all,
  ...WindowsViewports.all,
  ...LinuxViewports.all,
];

/// Фирменная шапка каталога: акцентная плитка с монограммой + «ACITS UI Kit».
/// Сразу даёт понять, что это за инструмент, при первом открытии.
class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brand, Color(0xFF4B5AC4)],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'A',
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w800, height: 1.0),
            ),
          ),
          const SizedBox(width: 12.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ACITS UI Kit',
                style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w700, height: 1.1),
              ),
              Text('Design system gallery', style: TextStyle(color: Colors.white70, fontSize: 11.0, height: 1.2)),
            ],
          ),
        ],
      ),
    );
  }
}
