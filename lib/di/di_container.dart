import 'package:acits_flutter/di/di_container.config.dart';
import 'package:app_services/app_services.dart';
import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shell/shell.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService],
  externalPackageModulesAfter: [ExternalModule(AppServicesPackageModule), ExternalModule(ShellPackageModule)],
)
Future<void> initDi() async {
  await $initGetIt(getIt, environmentFilter: NoEnvOrContains(Environment.prod));
  getIt.registerSingleton(_navigatorKey);
  getIt.registerSingleton(_scaffoldMessengerKey);
  getIt.registerSingleton(createAppRouter());
}
