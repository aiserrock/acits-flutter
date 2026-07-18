// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acits_flutter/navigation/animals_router_service.dart' as _i514;
import 'package:acits_flutter/navigation/applicants_router_service.dart'
    as _i314;
import 'package:acits_flutter/navigation/auth_router_service.dart' as _i501;
import 'package:acits_flutter/navigation/media_router_service.dart' as _i561;
import 'package:acits_flutter/navigation/personal_router_service.dart' as _i176;
import 'package:acits_flutter/navigation/prescriptions_router_service.dart'
    as _i338;
import 'package:acits_flutter/util/logger/app_logger.dart' as _i197;
import 'package:animals/animals.dart' as _i616;
import 'package:app_services/app_services.dart' as _i579;
import 'package:applicants/applicants.dart' as _i20;
import 'package:auth/auth.dart' as _i662;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:media/media.dart' as _i249;
import 'package:personal/personal.dart' as _i1007;
import 'package:prescriptions/prescriptions.dart' as _i857;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appLoggerModule = _$AppLoggerModule();
  gh.factory<_i1007.PersonalRouterService>(
    () => const _i176.PersonalRouterServiceImpl(),
  );
  gh.factory<_i662.SplashNavigator>(() => const _i501.SplashNavigatorImpl());
  gh.factory<_i20.ApplicantsRouterService>(
    () => const _i314.ApplicantsRouterServiceImpl(),
  );
  gh.factory<_i662.AuthRouterService>(
    () => const _i501.AuthRouterServiceImpl(),
  );
  gh.factory<_i616.AnimalsRouterService>(
    () => _i514.AnimalsRouterServiceImpl(gh<_i579.AnimalService>()),
  );
  gh.factory<_i249.MediaRouterService>(
    () => const _i561.MediaRouterServiceImpl(),
  );
  gh.factory<_i857.PrescriptionsRouterService>(
    () => const _i338.PrescriptionsRouterServiceImpl(),
  );
  gh.singleton<_i207.Talker>(
    () => appLoggerModule.talker(),
    registerFor: {_prod},
  );
  await _i579.AppServicesPackageModule().init(gh);
  return getIt;
}

class _$AppLoggerModule extends _i197.AppLoggerModule {}
