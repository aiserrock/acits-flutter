import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_container.config.dart';

final getIt = GetIt.instance;

final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@InjectableInit(
  generateForDir: ['lib', 'test'],
  initializerName: r'$initDevGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService, Alice],
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
