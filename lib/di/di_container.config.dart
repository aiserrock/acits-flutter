// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:acits_flutter/domain/env.dart' as _i6;
import 'package:acits_flutter/export.dart' as _i11;
import 'package:acits_flutter/res/color.dart' as _i15;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i23;
import 'package:acits_flutter/service/auth/auth_repository.dart' as _i14;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i18;
import 'package:acits_flutter/service/auth/email_confirm_repository.dart' as _i5;
import 'package:acits_flutter/service/client/auth_client_register.dart' as _i27;
import 'package:acits_flutter/service/client/auth_interceptor.dart' as _i3;
import 'package:acits_flutter/service/client/dio_register.dart' as _i24;
import 'package:acits_flutter/service/client/header_inteceptor.dart' as _i10;
import 'package:acits_flutter/service/config/config_service.dart' as _i19;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i16;
import 'package:acits_flutter/service/env/env_register.dart' as _i25;
import 'package:acits_flutter/service/file/file_repository.dart' as _i7;
import 'package:acits_flutter/service/file/file_service.dart' as _i8;
import 'package:acits_flutter/service/link_handler/deep_link_service.dart' as _i17;
import 'package:acits_flutter/service/personal/personal_service.dart' as _i20;
import 'package:acits_flutter/service/prescription/prescription_service.dart' as _i21;
import 'package:acits_flutter/service/secure_storage/secure_storage_register.dart' as _i26;
import 'package:acits_flutter/service/shared_pref/preference_storage.dart' as _i12;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart' as _i28;
import 'package:acits_flutter/service/staff/staff_service.dart' as _i22;
import 'package:dio/dio.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

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
  final clientRegister = _$ClientRegister();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i4.Dio>(() => dioRegister.createDioClient(), registerFor: {_prod});
  gh.factory<_i5.EmailConfirmRepository>(() => _i5.EmailConfirmRepository(get<_i4.Dio>()));
  gh.factory<_i6.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i7.FileRepository>(() => _i7.FileRepository(get<_i4.Dio>()));
  gh.factory<_i8.FileService>(() => _i8.FileService(get<_i7.FileRepository>()));
  gh.factory<_i9.FlutterSecureStorage>(() => secureStorageRegister.createSp());
  gh.factory<_i10.HeaderInterceptor>(() => _i10.HeaderInterceptor());
  gh.factory<_i11.Openapi>(
      () => clientRegister.createClient(
          get<_i3.AuthInterceptor>(), get<_i10.HeaderInterceptor>(), get<_i6.Env>()),
      registerFor: {_prod});
  gh.factory<_i11.Openapi>(() => clientRegister.createGuestClient(get<_i6.Env>()),
      instanceName: 'guest', registerFor: {_prod});
  gh.factory<_i12.PreferenceStorage>(() => _i12.PreferenceStorage());
  await gh.factoryAsync<_i13.SharedPreferences>(() => sharedPreferenceRegister.createSp(),
      preResolve: true);
  gh.factory<_i14.AuthRepository>(() => _i14.AuthRepository(get<_i9.FlutterSecureStorage>()));
  gh.singleton<_i15.ColorRes>(_i15.ColorRes());
  gh.singleton<_i16.DebugService>(_i16.DebugService(), registerFor: {_prod});
  gh.singleton<_i17.DeepLinkService>(_i17.DeepLinkService());
  gh.singleton<_i18.AuthService>(_i18.AuthService(
      get<_i11.Openapi>(),
      get<_i11.Openapi>(instanceName: 'guest'),
      get<_i14.AuthRepository>(),
      get<_i5.EmailConfirmRepository>()));
  gh.singleton<_i19.ConfigService>(_i19.ConfigService(
      get<_i11.Openapi>(), get<_i18.AuthService>(), get<_i12.PreferenceStorage>()));
  gh.singleton<_i20.PersonalService>(
      _i20.PersonalService(get<_i11.Openapi>(), get<_i18.AuthService>()));
  gh.singleton<_i21.PrescriptionService>(_i21.PrescriptionService(
      get<_i11.Openapi>(), get<_i18.AuthService>(), get<_i19.ConfigService>()));
  gh.singleton<_i22.StaffService>(_i22.StaffService(get<_i18.AuthService>(), get<_i11.Openapi>()));
  gh.singleton<_i23.AnimalService>(
      _i23.AnimalService(get<_i18.AuthService>(), get<_i11.Openapi>()));
  return get;
}

class _$DioRegister extends _i24.DioRegister {}

class _$EnvRegistrer extends _i25.EnvRegistrer {}

class _$SecureStorageRegister extends _i26.SecureStorageRegister {}

class _$ClientRegister extends _i27.ClientRegister {}

class _$SharedPreferenceRegister extends _i28.SharedPreferenceRegister {}
