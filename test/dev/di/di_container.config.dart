// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:acits_flutter/api/openapi.swagger.dart' as _i5;
import 'package:acits_flutter/domain/env.dart' as _i4;
import 'package:acits_flutter/export.dart' as _i11;
import 'package:acits_flutter/res/color.dart' as _i7;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i14;
import 'package:acits_flutter/service/auth/auth_client_register.dart' as _i3;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i9;
import 'package:acits_flutter/service/config/config_service.dart' as _i10;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i8;
import 'package:acits_flutter/service/env/env_register.dart' as _i16;
import 'package:acits_flutter/service/prescription/prescription_service.dart'
    as _i12;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart'
    as _i17;
import 'package:acits_flutter/service/staff/staff_service.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../env/env_register.dart' as _i15;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initDevGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final envDevRegistrer = _$EnvDevRegistrer();
  final envRegistrer = _$EnvRegistrer();
  final authClientRegister = _$AuthClientRegister();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i4.Env>(() => envDevRegistrer.createEnv(), registerFor: {_dev});
  gh.factory<_i4.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i3.HeaderInterceptor>(() => _i3.HeaderInterceptor());
  gh.factory<_i5.Openapi>(() => authClientRegister.createClient(
      get<_i3.AuthInterceptor>(),
      get<_i3.HeaderInterceptor>(),
      get<_i4.Env>()));
  gh.factory<_i5.Openapi>(
      () => authClientRegister.createGuestClient(get<_i4.Env>()),
      instanceName: 'guest');
  await gh.factoryAsync<_i6.SharedPreferences>(
      () => sharedPreferenceRegister.createSp(),
      preResolve: true);
  gh.singleton<_i7.ColorRes>(_i7.ColorRes());
  gh.singleton<_i8.DebugService>(_i8.DebugService());
  gh.singleton<_i9.AuthService>(_i9.AuthService(
      get<_i5.Openapi>(), get<_i5.Openapi>(instanceName: 'guest')));
  gh.singleton<_i10.ConfigService>(
      _i10.ConfigService(get<_i11.Openapi>(), get<_i9.AuthService>()));
  gh.singleton<_i12.PrescriptionService>(_i12.PrescriptionService(
      get<_i5.Openapi>(), get<_i9.AuthService>(), get<_i10.ConfigService>()));
  gh.singleton<_i13.StaffService>(
      _i13.StaffService(get<_i9.AuthService>(), get<_i5.Openapi>()));
  gh.singleton<_i14.AnimalService>(
      _i14.AnimalService(get<_i9.AuthService>(), get<_i5.Openapi>()));
  return get;
}

class _$EnvDevRegistrer extends _i15.EnvDevRegistrer {}

class _$EnvRegistrer extends _i16.EnvRegistrer {}

class _$AuthClientRegister extends _i3.AuthClientRegister {}

class _$SharedPreferenceRegister extends _i17.SharedPreferenceRegister {}
