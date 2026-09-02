import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shell/res/l10n.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

import 'gallery_directories.dart';

/// Debug-экран каталога дизайн-системы внутри основного приложения.
///
/// Переиспользует общий каталог `ui_kit` через тот же widgetbook, что и
/// standalone example-апп, — человек выбирает: смотреть галерею прямо здесь или
/// ставить отдельное приложение. Экран доступен только под `kDebugMode` (см.
/// роут `/debug/gallery`), поэтому widgetbook вырезается из release-сборки.
///
/// Брендинг намеренно не добавляется: это внутренний dev-инструмент, а не
/// витрина.
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgetbook.material — самодостаточный MaterialApp со своим Navigator: его
    // внутренний back не всплывает к go_router. Поэтому кладём поверх плавающую
    // кнопку выхода, которая закрывает роут `/debug/gallery` через `context.pop`.
    return Stack(
      children: [
        Positioned.fill(
          child: Widgetbook.material(
            directories: buildGalleryDirectories(),
            // Каждый экспонат рендерится внутри EasyLocalization, чтобы `.tr()`
            // в ui_kit-виджетах (holders, sort chips) резолвился в реальный
            // текст. Конфиг переиспользует L10n основного app.
            appBuilder: (context, child) => EasyLocalization(
              supportedLocales: L10n.supportedLocales,
              path: L10n.translationsPath,
              fallbackLocale: L10n.fallbackLocale,
              child: Builder(builder: (context) => child),
            ),
            addons: [
              MaterialThemeAddon(
                themes: [
                  WidgetbookTheme(name: 'Light', data: AppTheme.light),
                  WidgetbookTheme(name: 'Dark', data: AppTheme.dark),
                ],
              ),
              // Переключатель локали превью (ru/en) в панели addons — паритет
              // со standalone example.
              LocalizationAddon(
                locales: L10n.supportedLocales,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                ],
              ),
              ViewportAddon(_allViewports),
            ],
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _CloseGalleryButton(onTap: () => context.pop()),
            ),
          ),
        ),
      ],
    );
  }
}

/// Плавающая кнопка выхода из галереи. Полупрозрачная подложка — чтобы читалась
/// и на светлой, и на тёмной теме превью.
class _CloseGalleryButton extends StatelessWidget {
  const _CloseGalleryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.55),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        tooltip: 'Закрыть галерею',
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}

/// Полный набор viewport-пресетов widgetbook: «без рамки» + все iOS/Android
/// телефоны и планшеты + desktop (macOS/Windows/Linux).
const _allViewports = <ViewportData>[
  Viewports.none,
  ...IosViewports.all,
  ...AndroidViewports.all,
  ...MacosViewports.all,
  ...WindowsViewports.all,
  ...LinuxViewports.all,
];
