import 'package:flutter/widgets.dart';

/// Конфигурация локализации приложения (easy_localization).
///
/// Переводы лежат в `assets/translations/<locale>.json`, ключи —
/// в `lib/gen/l10n/locale_keys.g.dart` (`LocaleKeys`), доступ через `.tr()`.
abstract final class L10n {
  const L10n._();

  /// Путь к JSON-переводам (см. `pubspec.yaml` → assets).
  static const String translationsPath = 'assets/translations';

  /// Локаль по умолчанию / fallback — русский.
  static const Locale fallbackLocale = Locale('ru');

  /// Поддерживаемые локали.
  static const List<Locale> supportedLocales = [Locale('en'), Locale('ru')];
}
