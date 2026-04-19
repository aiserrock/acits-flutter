import 'package:acits_flutter/di/di_container.config.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;
final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService],
)
Future<void> initDi() async {
  await $initGetIt(getIt, environmentFilter: NoEnvOrContains(Environment.prod));
  getIt.registerSingleton(_navigatorKey);
  getIt.registerSingleton(_scaffoldMessengerKey);
}
