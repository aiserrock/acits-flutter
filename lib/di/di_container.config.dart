// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/openapi.swagger.dart' as _i4;
import '../res/color.dart' as _i5;
import '../service/animal/animal_service.dart' as _i9;
import '../service/auth/auth_client_register.dart' as _i3;
import '../service/auth/auth_service.dart' as _i6;
import '../service/config/config_service.dart' as _i7;
import '../service/prescription/prescription_service.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final authClientRegister = _$AuthClientRegister();
  gh.factory<_i3.AuthInterceptor>(() => _i3.AuthInterceptor());
  gh.factory<_i3.HeaderInterceptor>(() => _i3.HeaderInterceptor());
  gh.factoryAsync<_i4.Openapi>(() => authClientRegister.createClient(
      get<_i3.AuthInterceptor>(), get<_i3.HeaderInterceptor>()));
  gh.factoryAsync<_i4.Openapi>(() => authClientRegister.createGuestClient(),
      instanceName: 'guest');
  gh.singleton<_i5.ColorRes>(_i5.ColorRes());
  gh.singletonAsync<_i6.AuthService>(() async => _i6.AuthService(
      await get.getAsync<_i4.Openapi>(),
      await get.getAsync<_i4.Openapi>(instanceName: 'guest')));
  gh.singletonAsync<_i7.ConfigService>(() async => _i7.ConfigService(
      await get.getAsync<_i4.Openapi>(),
      await get.getAsync<_i6.AuthService>()));
  gh.singletonAsync<_i8.PrescriptionService>(() async =>
      _i8.PrescriptionService(
          await get.getAsync<_i4.Openapi>(),
          await get.getAsync<_i6.AuthService>(),
          await get.getAsync<_i7.ConfigService>()));
  gh.singletonAsync<_i9.AnimalService>(() async => _i9.AnimalService(
      await get.getAsync<_i6.AuthService>(),
      await get.getAsync<_i4.Openapi>(),
      await get.getAsync<_i7.ConfigService>()));
  return get;
}

class _$AuthClientRegister extends _i3.AuthClientRegister {}
