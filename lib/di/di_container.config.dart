// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acits_flutter/domain/env.dart' as _i531;
import 'package:acits_flutter/export.dart' as _i965;
import 'package:acits_flutter/res/color.dart' as _i430;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i876;
import 'package:acits_flutter/service/auth/auth_repository.dart' as _i622;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i21;
import 'package:acits_flutter/service/auth/email_confirm_repository.dart'
    as _i422;
import 'package:acits_flutter/service/client/auth_client_register.dart'
    as _i363;
import 'package:acits_flutter/service/client/auth_interceptor.dart' as _i492;
import 'package:acits_flutter/service/client/dio_register.dart' as _i693;
import 'package:acits_flutter/service/client/header_inteceptor.dart' as _i158;
import 'package:acits_flutter/service/config/config_service.dart' as _i245;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i47;
import 'package:acits_flutter/service/document/document_repository.dart'
    as _i302;
import 'package:acits_flutter/service/env/env_register.dart' as _i143;
import 'package:acits_flutter/service/file/file_repository.dart' as _i830;
import 'package:acits_flutter/service/file/file_service.dart' as _i499;
import 'package:acits_flutter/service/link_handler/deep_link_service.dart'
    as _i705;
import 'package:acits_flutter/service/personal/personal_service.dart' as _i701;
import 'package:acits_flutter/service/prescription/prescription_service.dart'
    as _i212;
import 'package:acits_flutter/service/secure_storage/secure_storage_register.dart'
    as _i539;
import 'package:acits_flutter/service/shared_pref/preference_storage.dart'
    as _i2;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart'
    as _i718;
import 'package:acits_flutter/service/staff/staff_service.dart' as _i156;
import 'package:acits_flutter/util/logger/app_logger.dart' as _i197;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final secureStorageRegister = _$SecureStorageRegister();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  final appLoggerModule = _$AppLoggerModule();
  final dioRegister = _$DioRegister();
  final envRegistrer = _$EnvRegistrer();
  final clientRegister = _$ClientRegister();
  gh.factory<_i492.AuthInterceptor>(() => _i492.AuthInterceptor());
  gh.factory<_i158.HeaderInterceptor>(() => _i158.HeaderInterceptor());
  gh.factory<_i558.FlutterSecureStorage>(
    () => secureStorageRegister.createSp(),
  );
  gh.factory<_i2.PreferenceStorage>(() => _i2.PreferenceStorage());
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => sharedPreferenceRegister.createSp(),
    preResolve: true,
  );
  gh.singleton<_i430.ColorRes>(() => _i430.ColorRes());
  gh.singleton<_i705.DeepLinkService>(() => _i705.DeepLinkService());
  gh.singleton<_i207.Talker>(() => appLoggerModule.talker());
  gh.factory<_i622.AuthRepository>(
    () => _i622.AuthRepository(gh<_i558.FlutterSecureStorage>()),
  );
  gh.singleton<_i47.DebugService>(
    () => _i47.DebugService(),
    registerFor: {_prod},
  );
  gh.factory<_i361.Dio>(
    () => dioRegister.createDioClient(),
    registerFor: {_prod},
  );
  gh.factory<_i531.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i965.Openapi>(
    () => clientRegister.createGuestClient(gh<_i531.Env>()),
    instanceName: 'guest',
    registerFor: {_prod},
  );
  gh.factory<_i965.Openapi>(
    () => clientRegister.createClient(
      gh<_i492.AuthInterceptor>(),
      gh<_i158.HeaderInterceptor>(),
      gh<_i531.Env>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i422.EmailConfirmRepository>(
    () => _i422.EmailConfirmRepository(gh<_i361.Dio>()),
  );
  gh.factory<_i830.FileRepository>(() => _i830.FileRepository(gh<_i361.Dio>()));
  gh.factory<_i499.FileService>(
    () => _i499.FileService(gh<_i830.FileRepository>()),
  );
  gh.singleton<_i21.AuthService>(
    () => _i21.AuthService(
      gh<_i965.Openapi>(),
      gh<_i965.Openapi>(instanceName: 'guest'),
      gh<_i622.AuthRepository>(),
      gh<_i422.EmailConfirmRepository>(),
    ),
  );
  gh.singleton<_i245.ConfigService>(
    () => _i245.ConfigService(
      gh<_i965.Openapi>(),
      gh<_i21.AuthService>(),
      gh<_i2.PreferenceStorage>(),
    ),
  );
  gh.singleton<_i876.AnimalService>(
    () => _i876.AnimalService(gh<_i21.AuthService>(), gh<_i965.Openapi>()),
  );
  gh.singleton<_i156.StaffService>(
    () => _i156.StaffService(gh<_i21.AuthService>(), gh<_i965.Openapi>()),
  );
  gh.factory<_i302.DocumentRepository>(
    () => _i302.DocumentRepository(gh<_i21.AuthService>(), gh<_i965.Openapi>()),
  );
  gh.singleton<_i701.PersonalService>(
    () => _i701.PersonalService(gh<_i965.Openapi>(), gh<_i21.AuthService>()),
  );
  gh.singleton<_i212.PrescriptionService>(
    () => _i212.PrescriptionService(
      gh<_i965.Openapi>(),
      gh<_i21.AuthService>(),
      gh<_i245.ConfigService>(),
    ),
  );
  return getIt;
}

class _$SecureStorageRegister extends _i539.SecureStorageRegister {}

class _$SharedPreferenceRegister extends _i718.SharedPreferenceRegister {}

class _$AppLoggerModule extends _i197.AppLoggerModule {}

class _$DioRegister extends _i693.DioRegister {}

class _$EnvRegistrer extends _i143.EnvRegistrer {}

class _$ClientRegister extends _i363.ClientRegister {}
