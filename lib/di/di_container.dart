import 'package:app_services/app_services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:shell/shell.dart';

import 'package:di/di.dart';
import 'package:observability/observability.dart';

import 'package:acits_flutter/observability_setup.dart';
import 'package:acits_flutter/update_policy.dart';
import 'package:auth/auth.dart' show AppUpdatePolicy;

import 'di_container.config.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@InjectableInit(
  generateForDir: ['lib'],
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
  ignoreUnregisteredTypes: [DebugService, ErrorReporter, AppUpdatePolicy],
  externalPackageModulesAfter: [ExternalModule(AppServicesPackageModule), ExternalModule(ShellPackageModule)],
)
Future<void> initDi(ObservabilitySetup observability) async {
  // До $initGetIt: Talker (injectable) резолвит ErrorReporter в своей фабрике.
  getIt.registerSingleton<ErrorReporter>(observability.reporter);
  getIt.registerSingleton<AppUpdatePolicy>(RemoteConfigUpdatePolicy(firebaseReady: observability.firebaseReady));
  await $initGetIt(getIt, environmentFilter: NoEnvOrContains(Environment.prod));
  await registerCollectionSettings(observability);
  // Error reports carry the current shelter id, cleared on logout.
  getIt<AuthService>().addSessionListener((shelterId) => observability.setUser(shelterId: shelterId));
  getIt.registerSingleton(_navigatorKey);
  getIt.registerSingleton(_scaffoldMessengerKey);
  getIt.registerSingleton<List<NavigatorObserver>>(observability.navigatorObservers());
  getIt.registerSingleton(createAppRouter());
}

/// Регистрирует выбор пользователя о сборе данных и применяет сохранённое значение.
Future<void> registerCollectionSettings(ObservabilitySetup observability) async {
  final settings = observability.collectionSettings(getIt<PreferenceStorage>());
  getIt.registerSingleton<CollectionSettings>(settings);
  await settings.apply();
}
