import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  generateForDir: [
    'lib',
    'test',
  ],
  initializerName: r'$initDevGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService],
)
Future<void> initDevDi() async {
  await $initDevGetIt(
    getIt,
    environmentFilter: NoEnvOrContains(Environment.dev),
  );
  getIt.registerSingleton(GlobalKey<NavigatorState>());
}
