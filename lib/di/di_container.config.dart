// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:acits_flutter/api/openapi.swagger.dart' as _i13;
import 'package:acits_flutter/domain/env.dart' as _i5;
import 'package:acits_flutter/export.dart' as _i17;
import 'package:acits_flutter/res/color.dart' as _i14;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i22;
import 'package:acits_flutter/service/auth/auth_repository.dart' as _i12;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i16;
import 'package:acits_flutter/service/client/auth_client_register.dart' as _i27;
import 'package:acits_flutter/service/client/auth_interceptor.dart' as _i3;
import 'package:acits_flutter/service/client/dio_register.dart' as _i23;
import 'package:acits_flutter/service/client/header_inteceptor.dart' as _i9;
import 'package:acits_flutter/service/config/config_service.dart' as _i18;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i15;
import 'package:acits_flutter/service/env/env_register.dart' as _i24;
import 'package:acits_flutter/service/file/file_repository.dart' as _i6;
import 'package:acits_flutter/service/file/file_service.dart' as _i7;
import 'package:acits_flutter/service/personal/personal_service.dart' as _i19;
import 'package:acits_flutter/service/prescription/prescription_service.dart' as _i20;
import 'package:acits_flutter/service/secure_storage/secure_storage_register.dart' as _i25;
import 'package:acits_flutter/service/shared_pref/preference_storage.dart' as _i10;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart' as _i26;
import 'package:acits_flutter/service/staff/staff_service.dart' as _i21;
import 'package:dio/dio.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioRegister = _$DioRegister();
  final envRegistrer = _$EnvRegistrer();
  final secureStorageRegister = _$SecureStorageRegister();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  final clientRegister = _$ClientRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i4.Dio>(() => dioRegister.createDioClient());
  gh.factory<_i5.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i6.FileRepository>(() => _i6.FileRepository(get<_i4.Dio>()));
  gh.factory<_i7.FileService>(() => _i7.FileService(get<_i6.FileRepository>()));
  gh.factory<_i8.FlutterSecureStorage>(() => secureStorageRegister.createSp());
  gh.factory<_i9.HeaderInterceptor>(() => _i9.HeaderInterceptor());
  gh.factory<_i10.PreferenceStorage>(() => _i10.PreferenceStorage());
  await gh.factoryAsync<_i11.SharedPreferences>(() => sharedPreferenceRegister.createSp(),
      preResolve: true);
  gh.factory<_i12.AuthRepository>(() => _i12.AuthRepository(get<_i8.FlutterSecureStorage>()));
  gh.factory<_i13.Openapi>(() => clientRegister.createClient(get<_i3.AuthInterceptor>(),
      get<_i9.HeaderInterceptor>(), get<_i5.Env>(), get<_i10.PreferenceStorage>()));
  gh.factory<_i13.Openapi>(
      () => clientRegister.createGuestClient(get<_i5.Env>(), get<_i10.PreferenceStorage>()),
      instanceName: 'guest');
  gh.singleton<_i14.ColorRes>(_i14.ColorRes());
  gh.singleton<_i15.DebugService>(_i15.DebugService(), registerFor: {_prod});
  gh.singleton<_i16.AuthService>(_i16.AuthService(
      get<_i17.Openapi>(), get<_i17.Openapi>(instanceName: 'guest'), get<_i12.AuthRepository>()));
  gh.singleton<_i18.ConfigService>(_i18.ConfigService(
      get<_i17.Openapi>(), get<_i16.AuthService>(), get<_i10.PreferenceStorage>()));
  gh.singleton<_i19.PersonalService>(
      _i19.PersonalService(get<_i17.Openapi>(), get<_i16.AuthService>()));
  gh.singleton<_i20.PrescriptionService>(_i20.PrescriptionService(
      get<_i17.Openapi>(), get<_i16.AuthService>(), get<_i18.ConfigService>()));
  gh.singleton<_i21.StaffService>(_i21.StaffService(get<_i16.AuthService>(), get<_i13.Openapi>()));
  gh.singleton<_i22.AnimalService>(
      _i22.AnimalService(get<_i16.AuthService>(), get<_i17.Openapi>()));
  return get;
}

class _$DioRegister extends _i23.DioRegister {}

class _$EnvRegistrer extends _i24.EnvRegistrer {}

class _$SecureStorageRegister extends _i25.SecureStorageRegister {}

class _$SharedPreferenceRegister extends _i26.SharedPreferenceRegister {}

class _$ClientRegister extends _i27.ClientRegister {}
