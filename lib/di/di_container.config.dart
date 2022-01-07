// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/openapi.swagger.dart' as _i4;
import '../export.dart' as _i8;
import '../res/color.dart' as _i5;
import '../service/animal/animal_service.dart' as _i10;
import '../service/auth/auth_client_register.dart' as _i3;
import '../service/auth/auth_service.dart' as _i6;
import '../service/config/config_service.dart' as _i7;
import '../service/prescription/prescription_service.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i6.AuthService>(_i6.AuthService(
      get<_i4.Openapi>(), get<_i4.Openapi>(instanceName: 'guest')));
  gh.singleton<_i7.ConfigService>(
      _i7.ConfigService(get<_i8.Openapi>(), get<_i6.AuthService>()));
  gh.singleton<_i9.PrescriptionService>(_i9.PrescriptionService(
      get<_i4.Openapi>(), get<_i6.AuthService>(), get<_i7.ConfigService>()));
  gh.singleton<_i10.AnimalService>(_i10.AnimalService(
      get<_i6.AuthService>(), get<_i4.Openapi>(), get<_i7.ConfigService>()));
  return get;
}

class _$AuthClientRegister extends _i3.AuthClientRegister {}
