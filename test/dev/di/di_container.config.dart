// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acits_api/acits_api.dart' as _i101;
import 'package:acits_flutter/domain/env.dart' as _i531;
import 'package:acits_flutter/navigation/animals_router_service.dart' as _i514;
import 'package:acits_flutter/navigation/applicants_router_service.dart'
    as _i314;
import 'package:acits_flutter/navigation/auth_router_service.dart' as _i501;
import 'package:acits_flutter/navigation/media_router_service.dart' as _i561;
import 'package:acits_flutter/navigation/personal_router_service.dart' as _i176;
import 'package:acits_flutter/navigation/prescriptions_router_service.dart'
    as _i338;
import 'package:acits_flutter/service/animal/animal_service.dart' as _i876;
import 'package:acits_flutter/service/auth/auth_repository.dart' as _i622;
import 'package:acits_flutter/service/auth/auth_service.dart' as _i21;
import 'package:acits_flutter/service/auth/email_confirm_repository.dart'
    as _i422;
import 'package:acits_flutter/service/client/acits_api_register.dart' as _i382;
import 'package:acits_flutter/service/client/animals_port_bridges.dart'
    as _i434;
import 'package:acits_flutter/service/client/animals_register.dart' as _i286;
import 'package:acits_flutter/service/client/applicants_register.dart' as _i144;
import 'package:acits_flutter/service/client/auth_port_bridges.dart' as _i350;
import 'package:acits_flutter/service/client/dio_register.dart' as _i693;
import 'package:acits_flutter/service/client/media_register.dart' as _i466;
import 'package:acits_flutter/service/client/personal_register.dart' as _i220;
import 'package:acits_flutter/service/client/prescriptions_register.dart'
    as _i71;
import 'package:acits_flutter/service/config/config_service.dart' as _i245;
import 'package:acits_flutter/service/debug/debug_service.dart' as _i47;
import 'package:acits_flutter/service/document/document_export_service_bridge.dart'
    as _i109;
import 'package:acits_flutter/service/env/env_register.dart' as _i143;
import 'package:acits_flutter/service/file/file_repository.dart' as _i830;
import 'package:acits_flutter/service/file/file_service.dart' as _i499;
import 'package:acits_flutter/service/link_handler/deep_link_service.dart'
    as _i705;
import 'package:acits_flutter/service/secure_storage/secure_storage_register.dart'
    as _i539;
import 'package:acits_flutter/service/shared_pref/preference_storage.dart'
    as _i2;
import 'package:acits_flutter/service/shared_pref/shared_pref_register.dart'
    as _i718;
import 'package:acits_flutter/service/theme/theme_storage.dart' as _i924;
import 'package:acits_flutter/util/logger/app_logger.dart' as _i197;
import 'package:animals/animals.dart' as _i616;
import 'package:applicants/applicants.dart' as _i20;
import 'package:auth/auth.dart' as _i662;
import 'package:base/base.dart' as _i905;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:media/media.dart' as _i249;
import 'package:personal/personal.dart' as _i1007;
import 'package:prescriptions/prescriptions.dart' as _i857;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

import '../env/env_register.dart' as _i962;
import '../service/client/acits_api_register.dart' as _i39;
import '../service/client/dio_register.dart' as _i230;
import '../service/debug/debug_dev_service.dart' as _i218;
import '../service/logger/logger_register.dart' as _i175;
import '../service/shared_pref/debug_preference_storage.dart' as _i1058;

const String _dev = 'dev';
const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initDevGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final secureStorageRegister = _$SecureStorageRegister();
  final sharedPreferenceRegister = _$SharedPreferenceRegister();
  final envDevRegistrer = _$EnvDevRegistrer();
  final dioRegisterDev = _$DioRegisterDev();
  final loggerRegisterDev = _$LoggerRegisterDev();
  final appLoggerModule = _$AppLoggerModule();
  final dioRegister = _$DioRegister();
  final envRegistrer = _$EnvRegistrer();
  final acitsApiRegisterDev = _$AcitsApiRegisterDev();
  final acitsApiRegister = _$AcitsApiRegister();
  final animalsRegister = _$AnimalsRegister();
  final applicantsRegister = _$ApplicantsRegister();
  final personalRegister = _$PersonalRegister();
  final mediaRegister = _$MediaRegister();
  final prescriptionsRegister = _$PrescriptionsRegister();
  gh.factory<_i558.FlutterSecureStorage>(
    () => secureStorageRegister.createSp(),
  );
  gh.factory<_i2.PreferenceStorage>(() => _i2.PreferenceStorage());
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => sharedPreferenceRegister.createSp(),
    preResolve: true,
  );
  gh.singleton<_i876.AnimalService>(() => _i876.AnimalService());
  gh.singleton<_i705.DeepLinkService>(() => _i705.DeepLinkService());
  gh.factory<_i249.PdfjsReadyPort>(() => const _i466.AppPdfjsReady());
  gh.factory<_i249.DocExporterPort>(() => _i466.AppDocExporter());
  gh.factory<_i1007.PersonalRouterService>(
    () => const _i176.PersonalRouterServiceImpl(),
  );
  gh.factory<_i662.SplashNavigator>(() => const _i501.SplashNavigatorImpl());
  gh.factory<_i905.SessionInvalidator>(
    () => const _i350.AuthServiceSessionInvalidator(),
  );
  gh.factory<_i20.ApplicantsRouterService>(
    () => const _i314.ApplicantsRouterServiceImpl(),
  );
  gh.factory<_i905.LocaleProvider>(
    () => const _i350.ConfigServiceLocaleProvider(),
  );
  gh.factory<_i905.TokenStore>(() => const _i350.AuthServiceTokenStore());
  gh.factory<_i531.Env>(() => envDevRegistrer.createEnv(), registerFor: {_dev});
  gh.factory<_i361.Dio>(
    () => dioRegisterDev.createDioClient(),
    registerFor: {_dev},
  );
  gh.factory<_i1058.DebugPreferenceStorage>(
    () => _i1058.DebugPreferenceStorage(),
    registerFor: {_dev},
  );
  gh.singleton<_i207.Talker>(
    () => loggerRegisterDev.talker(),
    registerFor: {_dev},
  );
  gh.factory<_i616.AnimalsRouterService>(
    () => _i514.AnimalsRouterServiceImpl(gh<_i876.AnimalService>()),
  );
  gh.factory<_i905.DocumentExportService>(
    () => _i109.DocumentExportServiceBridge(),
  );
  gh.factory<_i662.AuthRouterService>(
    () => const _i501.AuthRouterServiceImpl(),
  );
  gh.factory<_i905.TokenRefresher>(
    () => const _i350.AuthServiceTokenRefresher(),
  );
  gh.factory<_i249.MediaRouterService>(
    () => const _i561.MediaRouterServiceImpl(),
  );
  gh.singleton<_i47.DebugService>(
    () => _i218.DebugDevService(gh<_i1058.DebugPreferenceStorage>()),
    registerFor: {_dev},
  );
  gh.factory<_i857.PrescriptionsRouterService>(
    () => const _i338.PrescriptionsRouterServiceImpl(),
  );
  gh.factory<_i622.AuthRepository>(
    () => _i622.AuthRepository(gh<_i558.FlutterSecureStorage>()),
  );
  gh.factory<_i924.ThemeStorage>(
    () => _i924.ThemeStorage(gh<_i558.FlutterSecureStorage>()),
  );
  gh.singleton<_i47.DebugService>(
    () => _i47.DebugService(),
    registerFor: {_prod},
  );
  gh.singleton<_i207.Talker>(
    () => appLoggerModule.talker(),
    registerFor: {_prod},
  );
  gh.factory<_i361.Dio>(
    () => dioRegister.createDioClient(),
    registerFor: {_prod},
  );
  gh.factory<_i531.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
  gh.factory<_i361.Dio>(
    () => acitsApiRegisterDev.createAcitsApiGuestDio(
      gh<_i531.Env>(),
      gh<_i1058.DebugPreferenceStorage>(),
    ),
    instanceName: 'acitsApiGuest',
    registerFor: {_dev},
  );
  gh.factory<_i361.Dio>(
    () => acitsApiRegisterDev.createAcitsApiDio(
      gh<_i905.TokenStore>(),
      gh<_i905.TokenRefresher>(),
      gh<_i905.SessionInvalidator>(),
      gh<_i905.LocaleProvider>(),
      gh<_i531.Env>(),
      gh<_i1058.DebugPreferenceStorage>(),
    ),
    instanceName: 'acitsApi',
    registerFor: {_dev},
  );
  gh.factory<_i101.TokenClient>(
    () => acitsApiRegisterDev.tokenClientAuthed(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    instanceName: 'acitsApiTokenAuthed',
    registerFor: {_dev},
  );
  gh.factory<_i361.Dio>(
    () => acitsApiRegister.createAcitsApiDio(
      gh<_i905.TokenStore>(),
      gh<_i905.TokenRefresher>(),
      gh<_i905.SessionInvalidator>(),
      gh<_i905.LocaleProvider>(),
      gh<_i531.Env>(),
    ),
    instanceName: 'acitsApi',
    registerFor: {_prod},
  );
  gh.factory<_i101.AnimalsClient>(
    () =>
        acitsApiRegister.animalsClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
    registerFor: {_prod},
  );
  gh.factory<_i101.UsersClient>(
    () => acitsApiRegister.usersClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
    registerFor: {_prod},
  );
  gh.factory<_i101.PrescriptionsClient>(
    () => acitsApiRegister.prescriptionsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.ApplicantsClient>(
    () => acitsApiRegister.applicantsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.CuratorsClient>(
    () => acitsApiRegister.curatorsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i422.EmailConfirmRepository>(
    () => _i422.EmailConfirmRepository(gh<_i361.Dio>()),
  );
  gh.factory<_i830.FileRepository>(() => _i830.FileRepository(gh<_i361.Dio>()));
  gh.factory<_i101.SheltersClient>(
    () => acitsApiRegister.sheltersClientAuthed(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    instanceName: 'acitsApiSheltersAuthed',
    registerFor: {_prod},
  );
  gh.factory<_i101.TokenClient>(
    () => acitsApiRegister.tokenClientAuthed(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    instanceName: 'acitsApiTokenAuthed',
    registerFor: {_prod},
  );
  gh.factory<_i101.TokenClient>(
    () => acitsApiRegisterDev.tokenClientGuest(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    instanceName: 'acitsApiTokenGuest',
    registerFor: {_dev},
  );
  gh.factory<_i361.Dio>(
    () => acitsApiRegister.createAcitsApiGuestDio(gh<_i531.Env>()),
    instanceName: 'acitsApiGuest',
    registerFor: {_prod},
  );
  gh.factory<_i499.FileService>(
    () => _i499.FileService(gh<_i830.FileRepository>()),
  );
  gh.factory<_i101.SheltersClient>(
    () => acitsApiRegisterDev.sheltersClient(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i101.UsersRegistrationClient>(
    () => acitsApiRegisterDev.usersRegistrationClient(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i101.AnimalApiPort>(
    () => acitsApiRegister.animalApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i101.AnimalsClient>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.AnimalNotesApiPort>(
    () => acitsApiRegister.animalNotesApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i101.AnimalsClient>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.SelectionApiPort>(
    () => acitsApiRegister.selectionApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i101.AnimalsClient>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i1007.CommentFileOpener>(
    () => _i220.FileServiceCommentFileOpener(gh<_i499.FileService>()),
  );
  gh.factory<_i101.AnimalsClient>(
    () => acitsApiRegisterDev.animalsClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i101.UsersClient>(
    () => acitsApiRegisterDev.usersClient(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i101.PrescriptionApiPort>(
    () => acitsApiRegister.prescriptionApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i101.PrescriptionsClient>(),
      gh<_i101.SheltersClient>(instanceName: 'acitsApiSheltersAuthed'),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.TokenClient>(
    () => acitsApiRegister.tokenClientGuest(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    instanceName: 'acitsApiTokenGuest',
    registerFor: {_prod},
  );
  gh.factory<_i101.AuthApiPort>(
    () => acitsApiRegisterDev.authApiPort(
      gh<_i101.TokenClient>(instanceName: 'acitsApiTokenGuest'),
      gh<_i101.TokenClient>(instanceName: 'acitsApiTokenAuthed'),
      gh<_i101.UsersClient>(),
      gh<_i101.SheltersClient>(),
      gh<_i101.UsersRegistrationClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i101.StaffApiPort>(
    () => acitsApiRegister.staffApiPort(
      gh<_i101.ApplicantsClient>(),
      gh<_i101.CuratorsClient>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.SheltersClient>(
    () => acitsApiRegister.sheltersClient(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.UsersRegistrationClient>(
    () => acitsApiRegister.usersRegistrationClient(
      gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.AnimalApiPort>(
    () => acitsApiRegisterDev.animalApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i101.AnimalsClient>(),
    ),
    registerFor: {_dev},
  );
  gh.factory<_i101.ProfileApiPort>(
    () => acitsApiRegister.profileApiPort(
      gh<_i361.Dio>(instanceName: 'acitsApi'),
      gh<_i101.UsersClient>(),
    ),
    registerFor: {_prod},
  );
  gh.factory<_i101.AuthApiPort>(
    () => acitsApiRegister.authApiPort(
      gh<_i101.TokenClient>(instanceName: 'acitsApiTokenGuest'),
      gh<_i101.TokenClient>(instanceName: 'acitsApiTokenAuthed'),
      gh<_i101.UsersClient>(),
      gh<_i101.SheltersClient>(),
      gh<_i101.UsersRegistrationClient>(),
    ),
    registerFor: {_prod},
  );
  gh.singleton<_i21.AuthService>(
    () => _i21.AuthService(
      gh<_i101.AuthApiPort>(),
      gh<_i622.AuthRepository>(),
      gh<_i422.EmailConfirmRepository>(),
      gh<_i2.PreferenceStorage>(),
    ),
  );
  gh.factory<_i616.AnimalRemoteDataSource>(
    () => animalsRegister.animalRemoteDataSource(gh<_i101.AnimalApiPort>()),
  );
  gh.singleton<_i245.ConfigService>(
    () => _i245.ConfigService(
      gh<_i101.SelectionApiPort>(),
      gh<_i21.AuthService>(),
      gh<_i2.PreferenceStorage>(),
    ),
  );
  gh.factory<_i616.AnimalRepository>(
    () => animalsRegister.animalRepository(gh<_i616.AnimalRemoteDataSource>()),
  );
  gh.factory<_i857.PrescriptionAnimalLoader>(
    () => _i71.AnimalRepositoryPrescriptionAnimalLoader(
      gh<_i616.AnimalRepository>(),
      gh<_i21.AuthService>(),
    ),
  );
  gh.factory<_i616.AnimalPermissions>(
    () => _i434.AuthServiceAnimalPermissions(gh<_i21.AuthService>()),
  );
  gh.factory<_i857.PrescriptionTypeLabels>(
    () => _i71.ConfigServicePrescriptionTypeLabels(gh<_i245.ConfigService>()),
  );
  gh.factory<_i249.MediaShelterProvider>(
    () => _i466.AuthServiceMediaShelter(gh<_i21.AuthService>()),
  );
  gh.factory<_i857.PrescriptionsShelterProvider>(
    () => _i71.AuthServicePrescriptionsShelter(gh<_i21.AuthService>()),
  );
  gh.factory<_i20.ApplicantsShelterProvider>(
    () => _i144.AuthServiceApplicantsShelter(gh<_i21.AuthService>()),
  );
  gh.factory<_i616.AnimalStatusLabels>(
    () => _i434.ConfigServiceAnimalStatusLabels(gh<_i245.ConfigService>()),
  );
  gh.factory<_i616.CurrentShelterProvider>(
    () => _i434.AuthServiceCurrentShelter(gh<_i21.AuthService>()),
  );
  gh.singleton<_i20.StaffService>(
    () => applicantsRegister.staffService(
      gh<_i20.ApplicantsShelterProvider>(),
      gh<_i101.StaffApiPort>(),
    ),
  );
  gh.factory<_i1007.PersonalShelterProvider>(
    () => _i220.AuthServicePersonalShelter(gh<_i21.AuthService>()),
  );
  gh.singleton<_i1007.CommentsService>(
    () => personalRegister.commentsService(
      gh<_i101.AnimalNotesApiPort>(),
      gh<_i1007.PersonalShelterProvider>(),
    ),
  );
  gh.factory<_i249.DocumentRepository>(
    () => mediaRegister.documentRepository(
      gh<_i616.AnimalRepository>(),
      gh<_i616.CurrentShelterProvider>(),
    ),
  );
  gh.singleton<_i857.PrescriptionService>(
    () => prescriptionsRegister.prescriptionService(
      gh<_i101.PrescriptionApiPort>(),
      gh<_i857.PrescriptionsShelterProvider>(),
      gh<_i857.PrescriptionTypeLabels>(),
    ),
  );
  gh.singleton<_i1007.PersonalService>(
    () => personalRegister.personalService(
      gh<_i101.ProfileApiPort>(),
      gh<_i1007.PersonalShelterProvider>(),
    ),
  );
  gh.factory<_i249.SearchDeps>(
    () => mediaRegister.searchDeps(
      gh<_i616.AnimalRepository>(),
      gh<_i20.StaffService>(),
      gh<_i857.PrescriptionService>(),
      gh<_i249.MediaShelterProvider>(),
    ),
  );
  return getIt;
}

class _$SecureStorageRegister extends _i539.SecureStorageRegister {}

class _$SharedPreferenceRegister extends _i718.SharedPreferenceRegister {}

class _$EnvDevRegistrer extends _i962.EnvDevRegistrer {}

class _$DioRegisterDev extends _i230.DioRegisterDev {}

class _$LoggerRegisterDev extends _i175.LoggerRegisterDev {}

class _$AppLoggerModule extends _i197.AppLoggerModule {}

class _$DioRegister extends _i693.DioRegister {}

class _$EnvRegistrer extends _i143.EnvRegistrer {}

class _$AcitsApiRegisterDev extends _i39.AcitsApiRegisterDev {}

class _$AcitsApiRegister extends _i382.AcitsApiRegister {}

class _$AnimalsRegister extends _i286.AnimalsRegister {}

class _$ApplicantsRegister extends _i144.ApplicantsRegister {}

class _$PersonalRegister extends _i220.PersonalRegister {}

class _$MediaRegister extends _i466.MediaRegister {}

class _$PrescriptionsRegister extends _i71.PrescriptionsRegister {}
