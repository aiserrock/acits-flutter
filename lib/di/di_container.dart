import 'package:acits_flutter/di/di_container.config.dart';
import 'package:acits_flutter/service/debug/debug_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService],
)
void initDi() {
  $initGetIt(getIt);
  getIt.registerSingleton(GlobalKey<NavigatorState>());
}
