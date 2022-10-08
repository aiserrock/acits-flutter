// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:acits_flutter/domain/env.dart' as _i7;
import 'package:acits_flutter/export.dart' as _i12;
import 'package:acits_flutter/res/color.dart' as _i16;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i25;
import 'package:acits_flutter/service/auth/auth_repository.dart' as _i15;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i20;
import 'package:acits_flutter/service/auth/email_confirm_repository.dart' as _i6;
import 'package:acits_flutter/service/client/auth_client_register.dart' as _i32;
import 'package:acits_flutter/service/client/auth_interceptor.dart' as _i3;
import 'package:acits_flutter/service/client/dio_register.dart' as _i26;
import 'package:acits_flutter/service/client/header_inteceptor.dart' as _i11;
import 'package:acits_flutter/service/config/config_service.dart' as _i21;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i17;
import 'package:acits_flutter/service/env/env_register.dart' as _i29;
import 'package:acits_flutter/service/file/file_repository.dart' as _i8;
import 'package:acits_flutter/service/file/file_service.dart' as _i9;
import 'package:acits_flutter/service/link_handler/deep_link_service.dart' as _i19;
import 'package:acits_flutter/service/personal/personal_service.dart' as _i22;
import 'package:acits_flutter/service/prescription/prescription_service.dart' as _i23;
import 'package:acits_flutter/service/secure_storage/secure_storage_register.dart' as _i30;
import 'package:acits_flutter/service/shared_pref/preference_storage.dart' as _i13;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart' as _i33;
import 'package:acits_flutter/service/staff/staff_service.dart' as _i24;
import 'package:dio/dio.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import '../env/env_register.dart' as _i28;
import '../service/client/client_register.dart' as _i31;
import '../service/client/dio_register.dart' as _i27;
import '../service/debug/debug_dev_service.dart' as _i18;
import '../service/shared_pref/debug_preference_storage.dart' as _i4;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initDevGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioRegister = _$DioRegister();
  final dioRegisterDev = _$DioRegisterDev();
  final envDevRegistrer = _$EnvDevRegistrer();
  final envRegistrer = _$EnvRegistrer();
  final secureStorageRegister = _$SecureStorageRegister();
  final clientRegisterDev = _$ClientRegisterDev();
  final clientRegister = _$ClientRegister();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i4.DebugPreferenceStorage>(() => _i4.DebugPreferenceStorage(), registerFor: {_dev});
  gh.factory<_i5.Dio>(() => dioRegister.createDioClient(), registerFor: {_prod});
  gh.factory<_i5.Dio>(() => dioRegisterDev.createDioClient(), registerFor: {_dev});
  gh.factory<_i6.EmailConfirmRepository>(() => _i6.EmailConfirmRepository(get<_i5.Dio>()));
  gh.factory<_i7.Env>(() => envDevRegistrer.createEnv(), registerFor: {_dev});
  gh.factory<_i7.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i8.FileRepository>(() => _i8.FileRepository(get<_i5.Dio>()));
  gh.factory<_i9.FileService>(() => _i9.FileService(get<_i8.FileRepository>()));
  gh.factory<_i10.FlutterSecureStorage>(() => secureStorageRegister.createSp());
  gh.factory<_i11.HeaderInterceptor>(() => _i11.HeaderInterceptor());
  gh.factory<_i12.Openapi>(
      () => clientRegisterDev.createClient(get<_i3.AuthInterceptor>(),
          get<_i11.HeaderInterceptor>(), get<_i7.Env>(), get<_i4.DebugPreferenceStorage>()),
      registerFor: {_dev});
  gh.factory<_i12.Openapi>(
      () => clientRegisterDev.createGuestClient(get<_i7.Env>(), get<_i4.DebugPreferenceStorage>()),
      instanceName: 'guest',
      registerFor: {_dev});
  gh.factory<_i12.Openapi>(
      () => clientRegister.createClient(
          get<_i3.AuthInterceptor>(), get<_i11.HeaderInterceptor>(), get<_i7.Env>()),
      registerFor: {_prod});
  gh.factory<_i12.Openapi>(() => clientRegister.createGuestClient(get<_i7.Env>()),
      instanceName: 'guest', registerFor: {_prod});
  gh.factory<_i13.PreferenceStorage>(() => _i13.PreferenceStorage());
  await gh.factoryAsync<_i14.SharedPreferences>(() => sharedPreferenceRegister.createSp(),
      preResolve: true);
  gh.factory<_i15.AuthRepository>(() => _i15.AuthRepository(get<_i10.FlutterSecureStorage>()));
  gh.singleton<_i16.ColorRes>(_i16.ColorRes());
  gh.singleton<_i17.DebugService>(_i18.DebugDevService(get<_i4.DebugPreferenceStorage>()),
      registerFor: {_dev});
  gh.singleton<_i17.DebugService>(_i17.DebugService(), registerFor: {_prod});
  gh.singleton<_i19.DeepLinkService>(_i19.DeepLinkService());
  gh.singleton<_i20.AuthService>(_i20.AuthService(
      get<_i12.Openapi>(),
      get<_i12.Openapi>(instanceName: 'guest'),
      get<_i15.AuthRepository>(),
      get<_i6.EmailConfirmRepository>()));
  gh.singleton<_i21.ConfigService>(_i21.ConfigService(
      get<_i12.Openapi>(), get<_i20.AuthService>(), get<_i13.PreferenceStorage>()));
  gh.singleton<_i22.PersonalService>(
      _i22.PersonalService(get<_i12.Openapi>(), get<_i20.AuthService>()));
  gh.singleton<_i23.PrescriptionService>(_i23.PrescriptionService(
      get<_i12.Openapi>(), get<_i20.AuthService>(), get<_i21.ConfigService>()));
  gh.singleton<_i24.StaffService>(_i24.StaffService(get<_i20.AuthService>(), get<_i12.Openapi>()));
  gh.singleton<_i25.AnimalService>(
      _i25.AnimalService(get<_i20.AuthService>(), get<_i12.Openapi>()));
  return get;
}

class _$DioRegister extends _i26.DioRegister {}

class _$DioRegisterDev extends _i27.DioRegisterDev {}

class _$EnvDevRegistrer extends _i28.EnvDevRegistrer {}

class _$EnvRegistrer extends _i29.EnvRegistrer {}

class _$SecureStorageRegister extends _i30.SecureStorageRegister {}

class _$ClientRegisterDev extends _i31.ClientRegisterDev {}

class _$ClientRegister extends _i32.ClientRegister {}

class _$SharedPreferenceRegister extends _i33.SharedPreferenceRegister {}
