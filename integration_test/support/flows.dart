import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:localization/localization.dart';

import 'test_credentials.dart';

/// Многошаговые сценарные хелперы поверх Patrol. Держат в одном месте селекторы
/// и тайминги, чтобы отдельные тесты читались как последовательность шагов.
///
/// Тайминги щедрые: реальный dev-API + splash с минимумом 2 с + refresh по сети.
class Flows {
  Flows(this.$);

  final PatrolIntegrationTester $;

  /// Ключи полей формы логина (объявлены в login_form.dart).
  static const _loginFieldKey = Key('loginFormNameInputTextField');
  static const _passFieldKey = Key('loginFormPassInputTextField');

  /// Максимум ожидания сетевых экранов (splash-refresh, загрузка приютов, вход).
  static const _networkTimeout = Duration(seconds: 40);

  /// Полный вход: login-форма → submit → выбор приюта → root.
  ///
  /// Предполагает, что splash уже увёл на экран входа (чистая сессия).
  Future<void> login(TestCredentials creds) async {
    await waitForLoginScreen();

    await $(_loginFieldKey).enterText(creds.login);
    await $(_passFieldKey).enterText(creds.password);

    // Кнопка «Войти» (PrimaryButton рендерит Text(uppercase)).
    await $(LocaleKeys.loginEntryBtn.tr().toUpperCase()).tap();

    await pickShelter(creds.shelterName);
    await expectOnRoot();
  }

  /// Дождаться появления формы входа (splash решает маршрут не мгновенно).
  Future<void> waitForLoginScreen() async {
    await $(_loginFieldKey).waitUntilVisible(timeout: _networkTimeout);
  }

  /// Выбрать приют по имени на экране pick-shelter.
  ///
  /// Экран может авто-выбрать единственный приют (maybeAutoSelectSingle) —
  /// тогда мы уже на root и tap не нужен. Поэтому: если заголовок выбора не
  /// появился за короткий срок, считаем, что приют выбран автоматически.
  Future<void> pickShelter(String shelterName) async {
    final title = $(LocaleKeys.shelterSelectShelter.tr());
    final onPickShelter = await _appears(title, timeout: _networkTimeout);
    if (!onPickShelter) return; // авто-выбор единственного приюта

    final tile = $(shelterName);
    await tile.waitUntilVisible(timeout: _networkTimeout);
    await tile.tap();
  }

  /// Убедиться, что мы на главном экране (root — Scaffold с BottomNavigationBar).
  Future<void> expectOnRoot() async {
    await $(BottomNavigationBar).waitUntilVisible(timeout: _networkTimeout);
    expect($(BottomNavigationBar), findsOneWidget);
  }

  /// Проверить, что форма входа НЕ показана (для сценария авто-логина).
  void expectNotOnLogin() {
    expect($(_loginFieldKey), findsNothing);
    expect($(_passFieldKey), findsNothing);
  }

  /// Переключиться на вкладку «Животные» (paw, индекс 1) в нав-баре.
  Future<void> switchToAnimalsTab() async {
    // Лейбл «Животные» в BottomNavigationBar. Строим вкладку лениво — cubit
    // поднимется только после тапа.
    await $(LocaleKeys.commonAnimals.tr()).tap();
  }

  /// Дождаться, что вкладка догрузилась «нормально».
  ///
  /// Оба таба (Сегодня, Животные) строят загруженное состояние через
  /// `DataStateBuilder`: `loader` → `builder(list | empty)` → `errorBuilder`.
  /// И список с данными, и пустое состояние обёрнуты в [RefreshIndicator], а
  /// ветка ошибки рисует НЕвидимый `Column()`. Поэтому «загрузилось нормально» =
  /// **появился RefreshIndicator** (данные ИЛИ пустое состояние). На отсутствие
  /// error-виджета не полагаемся — его там и нет по дизайну.
  Future<void> waitTabLoaded() async {
    // RefreshIndicator появляется только в builder-ветке (успех); в loader- и
    // error-ветках его нет. Ждём его — это и есть «данные подгрузились».
    await $(RefreshIndicator).waitUntilVisible(timeout: _networkTimeout);
    expect(
      $(RefreshIndicator),
      findsWidgets,
      reason: 'Вкладка не построила загруженное состояние (loader/ошибка?)',
    );
  }

  // ── helpers ────────────────────────────────────────────────────────────────

  /// true, если [finder] стал видимым в пределах [timeout]; false по таймауту.
  Future<bool> _appears(PatrolFinder finder, {required Duration timeout}) async {
    try {
      await finder.waitUntilVisible(timeout: timeout);
      return true;
    } on WaitUntilVisibleTimeoutException {
      return false;
    }
  }
}
