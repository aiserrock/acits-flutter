// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_services/app_services.dart' as _i579;
import 'package:core/api.dart' as _i995;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/network.dart' as _i372;
import 'package:shell/shell.dart' as _i889;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

import '../env/env_register.dart' as _i962;
import '../service/client/acits_api_register.dart' as _i39;
import '../service/client/dio_register.dart' as _i230;
import '../service/debug/debug_dev_service.dart' as _i218;
import '../service/logger/logger_register.dart' as _i175;
import '../service/shared_pref/debug_preference_storage.dart' as _i1058;

const String _dev = 'dev';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initDevGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final envDevRegistrer = _$EnvDevRegistrer();
  final dioRegisterDev = _$DioRegisterDev();
  final loggerRegisterDev = _$LoggerRegisterDev();
  final acitsApiRegisterDev = _$AcitsApiRegisterDev();
  gh.factory<_i579.Env>(() => envDevRegistrer.createEnv(), registerFor: {_dev});
  gh.factory<_i361.Dio>(
    () => dioRegisterDev.createDioClient(),
    registerFor: {_dev},
  );
  gh.factory<_i1058.DebugPreferenceStorage>(
    () => _i1058.DebugPreferenceStorage(),
    registerFor: {_dev},
  );
  gh.singleton<_i207.Talker>(
    () => loggerRegisterDev.talker(),
    registerFor: {_dev},
  );
  gh.singleton<_i579.DebugService>(
    () => _i218.DebugDevService(gh<_i1058.DebugPreferenceStorage>()),
    registerFor: {_dev},
  );
  gh.factory<_i361.Dio>(
    () => acitsApiRegisterDev.createAcitsApiGuestDio(
      gh<_i579.Env>(),
      gh<_i1058.DebugPreferenceStorage>(),
    ),
    instanceName: 'acitsApiGuest',
    registerFor: {_dev},
  );
  gh.factory<_i361.Dio>(
    () => acitsApiRegisterDev.createAcitsApiDio(
      gh<_i372.TokenStore>(),
      gh<_i372.TokenRefresher>(),
      gh<_i372.SessionInvalidator>(),
      gh<_i372.LocaleProvider>(),
      gh<_i579.Env>(),
      gh<_i1058.DebugPreferenceStorage>(),
    ),
    instanceName: 'acitsApi',
    registerFor: {_dev},
  );
  gh.factory<_i995.SheltersClient>(
    () => acitsApiRegisterDev.sheltersClient(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.UsersRegistrationClient>(
    () => acitsApiRegisterDev.usersRegistrationClient(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.AnimalsClient>(
    () => acitsApiRegisterDev.animalsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.UsersClient>(
    () => acitsApiRegisterDev.usersClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.PrescriptionsClient>(
    () => acitsApiRegisterDev.prescriptionsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.ApplicantsClient>(
    () => acitsApiRegisterDev.applicantsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.CuratorsClient>(
    () => acitsApiRegisterDev.curatorsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.ProfileApiPort>(
    () => acitsApiRegisterDev.profileApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i995.UsersClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.TokenClient>(
    () => acitsApiRegisterDev.tokenClientAuthed(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    instanceName: 'acitsApiTokenAuthed',
    registerFor: {_dev},
  );
  gh.factory<_i995.SheltersClient>(
    () => acitsApiRegisterDev.sheltersClientAuthed(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    instanceName: 'acitsApiSheltersAuthed',
    registerFor: {_dev},
  );
  gh.factory<_i995.StaffApiPort>(
    () => acitsApiRegisterDev.staffApiPort(
      gh<_i995.ApplicantsClient>(),
      gh<_i995.CuratorsClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.AnimalApiPort>(
    () => acitsApiRegisterDev.animalApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i995.AnimalsClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.AnimalNotesApiPort>(
    () => acitsApiRegisterDev.animalNotesApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i995.AnimalsClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.SelectionApiPort>(
    () => acitsApiRegisterDev.selectionApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i995.AnimalsClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.PrescriptionApiPort>(
    () => acitsApiRegisterDev.prescriptionApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i995.PrescriptionsClient>(),
      gh<_i995.SheltersClient>(instanceName: 'acitsApiSheltersAuthed'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i995.AuthApiPort>(
    () => acitsApiRegisterDev.authApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
      gh<_i995.TokenClient>(instanceName: 'acitsApiTokenAuthed'),
      gh<_i995.UsersClient>(),
      gh<_i995.SheltersClient>(),
      gh<_i995.UsersRegistrationClient>(),
    ),
    registerFor: {_dev},
  );
  await _i579.AppServicesPackageModule().init(gh);
  await _i889.ShellPackageModule().init(gh);
  return getIt;
}

class _$EnvDevRegistrer extends _i962.EnvDevRegistrer {}

class _$DioRegisterDev extends _i230.DioRegisterDev {}

class _$LoggerRegisterDev extends _i175.LoggerRegisterDev {}

class _$AcitsApiRegisterDev extends _i39.AcitsApiRegisterDev {}
