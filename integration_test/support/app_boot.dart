import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patrol/patrol.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:util/util.dart';

import 'package:app_services/app_services.dart' show AuthService, ConfigService, Log;
import 'package:shell/shell.dart' show AppScaffold;

import 'package:acits_flutter/firebase/firebase_config.dart';

// initDevDi живёт в app-пакете, но вне lib/ (test/dev/), поэтому доступен только
// относительным путём — package: URI на него не резолвится.
import '../../test/dev/di/di_container.dart';

/// Признак того, что dev-DI уже поднят в этом процессе. Patrol native-restart
/// перезапускает нативное приложение, но dart-VM переиспользуется между тестами
/// одного файла — повторный initDevDi упал бы на re-register синглтонов.
bool _diReady = false;

/// Поднять реальный dev-пайплайн приложения для e2e-теста и запустить корневой
/// [AppScaffold] — тот же виджет, что и в бою (`runAppWith`).
///
/// Отличия от `test/dev/main.dart`: без прокси, debug-логгера и debug-оверлея —
/// тесту нужна ровно та инициализация, что влияет на auth/данные (Firebase-dev,
/// локализация, dev-DI с реальным dio на app.acits.ru, Bloc.observer).
///
/// [freshSession] — сбросить сохранённую авторизацию перед стартом, чтобы splash
/// гарантированно ушёл на login (сценарий 1). По умолчанию сессия сохраняется
/// (сценарий 2 — авто-логин).
Future<void> bootApp(PatrolIntegrationTester $, {bool freshSession = false}) async {
  await _bootstrapDevForTest();

  // На чистой установке (Test Orchestrator стирает данные пакета между тестами)
  // isFirstLaunch = true → splash уводит на ОНБОРДИНГ, а не на login. Тесту
  // онбординг не нужен: помечаем, что первый запуск уже пройден, чтобы splash
  // решал между login и root, как при обычном втором+ запуске.
  getIt<ConfigService>().setFirstLaunch();

  if (freshSession) {
    // Полный сброс: токены + refresh + текущий приют (см. AuthService.logout).
    // Делаем до pumpWidget, чтобы splash не успел восстановить сессию.
    getIt<AuthService>().logout();
  }

  await $.pumpWidgetAndSettle(const AppScaffold());
}

/// dev-инициализация один раз на процесс. Идемпотентна — переживает
/// native-restart внутри одного тест-файла.
Future<void> _bootstrapDevForTest() async {
  if (_diReady) return;

  await Firebase.initializeApp(options: devFirebaseOptions);
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppVersion.load();
  await initDevDi();
  Bloc.observer = createAppBlocObserver(getIt<Talker>());
  Log.info('App start · flavor=dev (patrol e2e)');

  _diReady = true;
}
