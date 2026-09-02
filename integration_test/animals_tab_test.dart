import 'package:patrol/patrol.dart';

import 'support/app_boot.dart';
import 'support/flows.dart';
import 'support/test_credentials.dart';

/// Сценарий 4 — вкладка «Животные» грузится нормально.
///
/// Входим в приложение → переключаемся на вкладку «Животные» (индекс 1). Вкладку
/// строим лениво: её `AnimalsCubit` поднимается только после первого перехода и
/// тогда грузит список. Проверяем, что загрузка завершилась построением
/// состояния (список карточек ИЛИ пустое состояние), а не зависла/упала.
///
/// Запуск: `patrol test --target integration_test/animals_tab_test.dart --flavor dev`.
void main() {
  final creds = TestCredentials.fromEnv();

  patrolTest('animals tab loads its data', ($) async {
    await bootApp($, freshSession: true);

    final flows = Flows($);
    await flows.login(creds);
    await flows.expectOnRoot();

    // Ленивая вкладка: cubit и загрузка стартуют только после тапа по табу.
    await flows.switchToAnimalsTab();
    await flows.waitTabLoaded();
  });
}
