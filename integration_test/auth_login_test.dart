import 'package:patrol/patrol.dart';

import 'support/app_boot.dart';
import 'support/flows.dart';
import 'support/test_credentials.dart';

/// Сценарий 1 — авторизация с нуля.
///
/// Чистая сессия (logout до старта) → splash уводит на login → ввод логина/
/// пароля → выбор приюта → главный экран.
///
/// Запуск: `patrol test --target integration_test/auth_login_test.dart --flavor dev`.
void main() {
  final creds = TestCredentials.fromEnv();

  patrolTest('login from scratch reaches root', ($) async {
    await bootApp($, freshSession: true);

    final flows = Flows($);
    await flows.login(creds);

    // login() уже проверяет expectOnRoot внутри; дублируем как явную гарантию.
    await flows.expectOnRoot();
  });
}
