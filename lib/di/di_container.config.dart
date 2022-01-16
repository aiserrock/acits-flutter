// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/openapi.swagger.dart' as _i4;
import '../export.dart' as _i9;
import '../res/color.dart' as _i5;
import '../service/animal/animal_service.dart' as _i11;
import '../service/auth/auth_client_register.dart' as _i3;
import '../service/auth/auth_service.dart' as _i7;
import '../service/config/config_service.dart' as _i8;
import '../service/debug/debug_service.dart' as _i6;
import '../service/prescription/prescription_service.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final authClientRegister = _$AuthClientRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i3.HeaderInterceptor>(() => _i3.HeaderInterceptor());
  gh.factory<_i4.Openapi>(() => authClientRegister.createClient(
      get<_i3.AuthInterceptor>(), get<_i3.HeaderInterceptor>()));
  gh.factory<_i4.Openapi>(() => authClientRegister.createGuestClient(),
      instanceName: 'guest');
  gh.singleton<_i5.ColorRes>(_i5.ColorRes());
  gh.singleton<_i6.DebugService>(_i6.DebugService());
  gh.singleton<_i7.AuthService>(_i7.AuthService(
      get<_i4.Openapi>(), get<_i4.Openapi>(instanceName: 'guest')));
  gh.singleton<_i8.ConfigService>(
      _i8.ConfigService(get<_i9.Openapi>(), get<_i7.AuthService>()));
  gh.singleton<_i10.PrescriptionService>(_i10.PrescriptionService(
      get<_i4.Openapi>(), get<_i7.AuthService>(), get<_i8.ConfigService>()));
  gh.singleton<_i11.AnimalService>(
      _i11.AnimalService(get<_i7.AuthService>(), get<_i4.Openapi>()));
  return get;
}

class _$AuthClientRegister extends _i3.AuthClientRegister {}
