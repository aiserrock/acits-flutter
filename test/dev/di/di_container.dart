import 'package:acits_flutter/navigation/app_router.dart';
import 'package:app_services/app_services.dart';
import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:injectable/injectable.dart';

import 'di_container.config.dart';

// getIt-инстанс живёт в пакете di; ре-экспортим, чтобы относительные импортёры
// внутри test/dev (register-модули, debug-экран) видели тот же локатор, что и app.
export 'package:di/di.dart' show getIt;

final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@InjectableInit(
  generateForDir: ['lib', 'test'],
  initializerName: r'$initDevGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService, Alice],
  externalPackageModulesAfter: [ExternalModule(AppServicesPackageModule)],
)
Future<void> initDevDi() async {
  getIt.registerSingleton(_navigatorKey);
  getIt.registerSingleton(_scaffoldMessengerKey);
  // Alice регистрируем ДО $initDevGetIt: chopper/dio-клиенты (injectable)
  // резолвят getIt<Alice>() в своих фабриках для HTTP-инспектора. navigatorKey
  // выше — Alice.showInspector() навигирует через него.
  getIt.registerSingleton(Alice(showNotification: false, navigatorKey: _navigatorKey));
  await $initDevGetIt(getIt, environmentFilter: NoEnvOrContains(Environment.dev));
  getIt.registerSingleton(createAppRouter());
}
