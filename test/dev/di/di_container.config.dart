// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:acits_flutter/api/openapi.swagger.dart' as _i11;
import 'package:acits_flutter/domain/env.dart' as _i5;
import 'package:acits_flutter/export.dart' as _i13;
import 'package:acits_flutter/res/color.dart' as _i14;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i18;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i12;
import 'package:acits_flutter/service/client/auth_client_register.dart' as _i26;
import 'package:acits_flutter/service/client/auth_interceptor.dart' as _i3;
import 'package:acits_flutter/service/client/dio_register.dart' as _i22;
import 'package:acits_flutter/service/client/header_inteceptor.dart' as _i8;
import 'package:acits_flutter/service/config/config_service.dart' as _i15;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i16;
import 'package:acits_flutter/service/env/env_register.dart' as _i24;
import 'package:acits_flutter/service/file/file_repository.dart' as _i6;
import 'package:acits_flutter/service/file/file_service.dart' as _i7;
import 'package:acits_flutter/service/personal/personal_service.dart' as _i17;
import 'package:acits_flutter/service/prescription/prescription_service.dart'
    as _i20;
import 'package:acits_flutter/service/shared_pref/preference_storage.dart'
    as _i9;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart'
    as _i25;
import 'package:acits_flutter/service/staff/staff_service.dart' as _i21;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../env/env_register.dart' as _i23;
import '../service/debug/debug_dev_service.dart' as _i19;

const String _prod = 'prod';
const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initDevGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioRegister = _$DioRegister();
  final envDevRegistrer = _$EnvDevRegistrer();
  final envRegistrer = _$EnvRegistrer();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  final clientRegister = _$ClientRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i4.Dio>(() => dioRegister.createDioClient());
  gh.factory<_i5.Env>(() => envDevRegistrer.createEnv(), registerFor: {_dev});
  gh.factory<_i5.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i6.FileRepository>(() => _i6.FileRepository(get<_i4.Dio>()));
  gh.factory<_i7.FileService>(() => _i7.FileService(get<_i6.FileRepository>()));
  gh.factory<_i8.HeaderInterceptor>(() => _i8.HeaderInterceptor());
  gh.factory<_i9.PreferenceStorage>(() => _i9.PreferenceStorage());
  await gh.factoryAsync<_i10.SharedPreferences>(
      () => sharedPreferenceRegister.createSp(),
      preResolve: true);
  gh.factory<_i11.Openapi>(() => clientRegister.createClient(
      get<_i3.AuthInterceptor>(),
      get<_i8.HeaderInterceptor>(),
      get<_i5.Env>(),
      get<_i9.PreferenceStorage>()));
  gh.factory<_i11.Openapi>(
      () => clientRegister.createGuestClient(
          get<_i5.Env>(), get<_i9.PreferenceStorage>()),
      instanceName: 'guest');
  gh.singleton<_i12.AuthService>(_i12.AuthService(
      get<_i13.Openapi>(), get<_i13.Openapi>(instanceName: 'guest')));
  gh.singleton<_i14.ColorRes>(_i14.ColorRes());
  gh.singleton<_i15.ConfigService>(
      _i15.ConfigService(get<_i13.Openapi>(), get<_i12.AuthService>()));
  gh.singleton<_i16.DebugService>(_i16.DebugService(), registerFor: {_prod});
  gh.singleton<_i17.PersonalService>(
      _i17.PersonalService(get<_i13.Openapi>(), get<_i12.AuthService>()));
  gh.singleton<_i18.AnimalService>(
      _i18.AnimalService(get<_i12.AuthService>(), get<_i13.Openapi>()));
  gh.singleton<_i16.DebugService>(
      _i19.DebugDevService(get<_i9.PreferenceStorage>()),
      registerFor: {_dev});
  gh.singleton<_i20.PrescriptionService>(_i20.PrescriptionService(
      get<_i11.Openapi>(), get<_i12.AuthService>(), get<_i15.ConfigService>()));
  gh.singleton<_i21.StaffService>(
      _i21.StaffService(get<_i12.AuthService>(), get<_i11.Openapi>()));
  return get;
}

class _$DioRegister extends _i22.DioRegister {}

class _$EnvDevRegistrer extends _i23.EnvDevRegistrer {}

class _$EnvRegistrer extends _i24.EnvRegistrer {}

class _$SharedPreferenceRegister extends _i25.SharedPreferenceRegister {}

class _$ClientRegister extends _i26.ClientRegister {}
