import 'dart:async';

import 'package:integration_test/integration_test_driver.dart' as integration_test_driver;

Future<void> main() async {
  // TODO(upgrade-3.41): пакет integration_test больше не экспортирует
  // `testOutputsDirectory` как публичную переменную. Путь вывода Gherkin-отчётов
  // задаётся через переменную окружения `FLUTTER_TEST_OUTPUTS_DIR=reports`
  // при запуске `flutter drive`.
  return integration_test_driver.integrationDriver(timeout: const Duration(minutes: 90));
}
