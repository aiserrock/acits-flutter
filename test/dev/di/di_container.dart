import 'package:app_services/app_services.dart';
import 'package:di/di.dart';
import 'package:observability/observability.dart';

import 'package:acits_flutter/di/di_container.dart' show registerCollectionSettings;
import 'package:acits_flutter/observability_setup.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_alice/alice.dart';
import 'package:injectable/injectable.dart';
import 'package:shell/shell.dart';

import 'di_container.config.dart';

// getIt-инстанс живёт в пакете di; ре-экспортим, чтобы относительные импортёры
// внутри test/dev (register-модули, debug-экран) видели тот же локатор, что и app.
export 'package:di/di.dart' show getIt;

final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// Живёт дольше getIt: debug-перезапуск сбрасывает контейнер, а хуки ошибок и
/// бэкенды репортинга остаются теми же.
ObservabilitySetup? _observability;

@InjectableInit(
  generateForDir: ['lib', 'test'],
  initializerName: r'$initDevGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService, Alice, ErrorReporter],
  externalPackageModulesAfter: [ExternalModule(AppServicesPackageModule), ExternalModule(ShellPackageModule)],
)
Future<void> initDevDi([ObservabilitySetup? setup]) async {
  final observability = _observability = setup ?? _observability!;
  getIt.registerSingleton<ErrorReporter>(observability.reporter);
  getIt.registerSingleton(_navigatorKey);
  getIt.registerSingleton(_scaffoldMessengerKey);
  // Alice регистрируем ДО $initDevGetIt: dio-клиенты (injectable)
  // резолвят getIt<Alice>() в своих фабриках для HTTP-инспектора. navigatorKey
  // выше — Alice.showInspector() навигирует через него.
  getIt.registerSingleton(Alice(navigatorKey: _navigatorKey));
  await $initDevGetIt(getIt, environmentFilter: NoEnvOrContains(Environment.dev));
  await registerCollectionSettings(observability);
  getIt.registerSingleton<List<NavigatorObserver>>(observability.navigatorObservers());
  getIt.registerSingleton(createAppRouter());
}
