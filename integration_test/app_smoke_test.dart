import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:acits_flutter/generated/locale_keys.g.dart';
import 'package:acits_flutter/l10n/l10n.dart';

/// Дымовой e2e-тест (Patrol): проверяет, что связка Flutter + easy_localization
/// поднимается на устройстве и переводы доступны.
///
/// Запуск на девайсе/эмуляторе:
/// `patrol test --target integration_test/app_smoke_test.dart --flavor dev`.
///
/// Это база для дальнейших сценарных тестов (логин, список животных и т.д.),
/// которые будут гонять реальный `main()` через DI.
void main() {
  patrolTest('localisation boots and renders a translated string', ($) async {
    await EasyLocalization.ensureInitialized();

    await $.pumpWidgetAndSettle(
      EasyLocalization(
        supportedLocales: L10n.supportedLocales,
        path: L10n.translationsPath,
        fallbackLocale: L10n.fallbackLocale,
        startLocale: L10n.fallbackLocale,
        child: Builder(
          builder: (context) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Scaffold(body: Center(child: Text(LocaleKeys.commonToday.tr()))),
          ),
        ),
      ),
    );

    expect($(MaterialApp), findsOneWidget);
    expect($(Text), findsWidgets);
  });
}
