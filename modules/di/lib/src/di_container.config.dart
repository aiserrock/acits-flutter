// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_services/app_services.dart' as _i579;
import 'package:di/src/app_logger.dart' as _i867;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shell/shell.dart' as _i889;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appLoggerModule = _$AppLoggerModule();
  gh.singleton<_i207.Talker>(
    () => appLoggerModule.talker(),
    registerFor: {_prod},
  );
  await _i579.AppServicesPackageModule().init(gh);
  await _i889.ShellPackageModule().init(gh);
  return getIt;
}

class _$AppLoggerModule extends _i867.AppLoggerModule {}
