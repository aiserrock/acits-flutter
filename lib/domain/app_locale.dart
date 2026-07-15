import 'package:flutter/widgets.dart';

import 'package:acits_flutter/gen/assets.gen.dart';

/// Поддерживаемые языки приложения с флагами (для переключателя локали).
///
/// По образцу hamkormobile `SupportedLocales`, упрощённо для ru/en.
enum AppLocale {
  ru(locale: Locale('ru'), title: 'Русский', code: 'RU'),
  en(locale: Locale('en'), title: 'English', code: 'EN');

  const AppLocale({required this.locale, required this.title, required this.code});

  /// Locale для `context.setLocale`.
  final Locale locale;

  /// Название языка на самом языке.
  final String title;

  /// Короткий код для компактного отображения (RU/EN).
  final String code;

  /// SVG-флаг страны.
  SvgGenImage get flag => switch (this) {
    AppLocale.ru => Assets.icon.flagRu,
    AppLocale.en => Assets.icon.flagEn,
  };

  /// Подобрать [AppLocale] по коду языка текущей локали; дефолт — ru.
  static AppLocale fromLanguageCode(String? code) {
    return AppLocale.values.firstWhere((e) => e.locale.languageCode == code?.toLowerCase(), orElse: () => AppLocale.ru);
  }
}
