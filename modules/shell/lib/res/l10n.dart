import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';

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

  /// Делегаты для `MaterialApp`: делегат переводов easy_localization плюс
  /// Global*-делегаты material_ui/cupertino_ui.
  ///
  /// `context.localizationDelegates` отдаёт легаси-делегаты flutter_localizations —
  /// они грузят типы Material/Cupertino из SDK, и `MaterialApp` из material_ui не
  /// находит русские `MaterialLocalizations`. Делегат easy_localization в списке
  /// первый (см. его `delegates`), легаси-хвост заменяем.
  static List<LocalizationsDelegate<dynamic>> delegates(BuildContext context) => [
    context.localizationDelegates.first,
    ...GlobalMaterialLocalizations.delegates,
  ];
}
