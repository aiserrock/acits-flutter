// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:animals/animals.dart' as _i616;
import 'package:app_services/app_services.dart' as _i579;
import 'package:applicants/applicants.dart' as _i20;
import 'package:auth/auth.dart' as _i662;
import 'package:injectable/injectable.dart' as _i526;
import 'package:media/media.dart' as _i249;
import 'package:personal/personal.dart' as _i1007;
import 'package:prescriptions/prescriptions.dart' as _i857;
import 'package:shell/navigation/animals_router_service.dart' as _i959;
import 'package:shell/navigation/applicants_router_service.dart' as _i765;
import 'package:shell/navigation/auth_router_service.dart' as _i422;
import 'package:shell/navigation/media_router_service.dart' as _i572;
import 'package:shell/navigation/personal_router_service.dart' as _i8;
import 'package:shell/navigation/prescriptions_router_service.dart' as _i919;

class ShellPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i857.PrescriptionsRouterService>(() => const _i919.PrescriptionsRouterServiceImpl());
    gh.factory<_i249.MediaRouterService>(() => const _i572.MediaRouterServiceImpl());
    gh.factory<_i616.AnimalsRouterService>(() => _i959.AnimalsRouterServiceImpl(gh<_i579.AnimalService>()));
    gh.factory<_i1007.PersonalRouterService>(() => const _i8.PersonalRouterServiceImpl());
    gh.factory<_i662.SplashNavigator>(() => const _i422.SplashNavigatorImpl());
    gh.factory<_i662.AuthRouterService>(() => const _i422.AuthRouterServiceImpl());
    gh.factory<_i20.ApplicantsRouterService>(() => const _i765.ApplicantsRouterServiceImpl());
  }
}
