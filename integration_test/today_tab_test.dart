import 'package:patrol/patrol.dart';

import 'support/app_boot.dart';
import 'support/flows.dart';
import 'support/test_credentials.dart';

/// Сценарий 3 — вкладка «Сегодня» грузится нормально.
///
/// Входим в приложение → на root активна вкладка «Сегодня» (индекс 0) → её
/// `MainCubit` грузит назначения на сегодня. Проверяем, что загрузка завершилась
/// построением состояния (список назначений ИЛИ пустое состояние), а не зависла
/// в лоадере и не свалилась в ошибку.
///
/// Запуск: `patrol test --target integration_test/today_tab_test.dart --flavor dev`.
void main() {
  final creds = TestCredentials.fromEnv();

  patrolTest('today tab loads its data', ($) async {
    await bootApp($, freshSession: true);

    final flows = Flows($);
    await flows.login(creds);
    await flows.expectOnRoot();

    // Вкладка «Сегодня» активна по умолчанию — сразу ждём её загруженное состояние.
    await flows.waitTabLoaded();
  });
}
