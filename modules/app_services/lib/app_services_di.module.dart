// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:animals/animals.dart' as _i616;
import 'package:app_services/src/domain/env.dart' as _i417;
import 'package:app_services/src/service/animal/animal_service.dart' as _i911;
import 'package:app_services/src/service/auth/auth_repository.dart' as _i358;
import 'package:app_services/src/service/auth/auth_service.dart' as _i397;
import 'package:app_services/src/service/auth/email_confirm_repository.dart' as _i672;
import 'package:app_services/src/service/client/acits_api_register.dart' as _i472;
import 'package:app_services/src/service/client/animals_port_bridges.dart' as _i694;
import 'package:app_services/src/service/client/animals_register.dart' as _i121;
import 'package:app_services/src/service/client/applicants_register.dart' as _i14;
import 'package:app_services/src/service/client/auth_port_bridges.dart' as _i299;
import 'package:app_services/src/service/client/dio_register.dart' as _i1042;
import 'package:app_services/src/service/client/media_register.dart' as _i428;
import 'package:app_services/src/service/client/personal_register.dart' as _i118;
import 'package:app_services/src/service/client/prescriptions_register.dart' as _i68;
import 'package:app_services/src/service/config/config_service.dart' as _i277;
import 'package:app_services/src/service/debug/debug_service.dart' as _i64;
import 'package:app_services/src/service/document/document_export_service_bridge.dart' as _i11;
import 'package:app_services/src/service/env/env_register.dart' as _i311;
import 'package:app_services/src/service/file/file_repository.dart' as _i530;
import 'package:app_services/src/service/file/file_service.dart' as _i589;
import 'package:app_services/src/service/link_handler/deep_link_service.dart' as _i542;
import 'package:app_services/src/service/secure_storage/secure_storage_register.dart' as _i922;
import 'package:app_services/src/service/shared_pref/preference_storage.dart' as _i614;
import 'package:app_services/src/service/shared_pref/shared_pref_register.dart' as _i100;
import 'package:app_services/src/service/theme/theme_storage.dart' as _i520;
import 'package:applicants/applicants.dart' as _i20;
import 'package:core/api.dart' as _i995;
import 'package:core/core.dart' as _i494;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:injectable/injectable.dart' as _i526;
import 'package:media/media.dart' as _i249;
import 'package:network/network.dart' as _i372;
import 'package:personal/personal.dart' as _i1007;
import 'package:prescriptions/prescriptions.dart' as _i857;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:util/util.dart' as _i609;

const String _prod = 'prod';

class AppServicesPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final secureStorageRegister = _$SecureStorageRegister();
    final sharedPreferenceRegister = _$SharedPreferenceRegister();
    final dioRegister = _$DioRegister();
    final envRegistrer = _$EnvRegistrer();
    final acitsApiRegister = _$AcitsApiRegister();
    final animalsRegister = _$AnimalsRegister();
    final applicantsRegister = _$ApplicantsRegister();
    final personalRegister = _$PersonalRegister();
    final mediaRegister = _$MediaRegister();
    final prescriptionsRegister = _$PrescriptionsRegister();
    gh.factory<_i558.FlutterSecureStorage>(() => secureStorageRegister.createSp());
    gh.factory<_i614.PreferenceStorage>(() => _i614.PreferenceStorage());
    await gh.factoryAsync<_i460.SharedPreferences>(() => sharedPreferenceRegister.createSp(), preResolve: true);
    gh.singleton<_i911.AnimalService>(() => _i911.AnimalService());
    gh.singleton<_i542.DeepLinkService>(() => _i542.DeepLinkService());
    gh.factory<_i372.SessionInvalidator>(() => const _i299.AuthServiceSessionInvalidator());
    gh.factory<_i249.PdfjsReadyPort>(() => const _i428.AppPdfjsReady());
    gh.factory<_i372.TokenRefresher>(() => const _i299.AuthServiceTokenRefresher());
    gh.factory<_i609.DocumentExportService>(() => _i11.DocumentExportServiceBridge());
    gh.factory<_i249.DocExporterPort>(() => _i428.AppDocExporter());
    gh.factory<_i372.LocaleProvider>(() => const _i299.ConfigServiceLocaleProvider());
    gh.factory<_i372.TokenStore>(() => const _i299.AuthServiceTokenStore());
    gh.factory<_i358.AuthRepository>(() => _i358.AuthRepository(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i520.ThemeStorage>(() => _i520.ThemeStorage(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i64.DebugService>(() => _i64.DebugService(), registerFor: {_prod});
    gh.factory<_i361.Dio>(() => dioRegister.createDioClient(), registerFor: {_prod});
    gh.factory<_i417.Env>(() => envRegistrer.createEnv(), registerFor: {_prod});
    gh.factory<_i672.EmailConfirmRepository>(() => _i672.EmailConfirmRepository(gh<_i361.Dio>()));
    gh.factory<_i530.FileRepository>(() => _i530.FileRepository(gh<_i361.Dio>()));
    gh.factory<_i361.Dio>(
      () => acitsApiRegister.createAcitsApiGuestDio(gh<_i417.Env>()),
      instanceName: 'acitsApiGuest',
      registerFor: {_prod},
    );
    gh.factory<_i361.Dio>(
      () => acitsApiRegister.createAcitsApiDio(
        gh<_i372.TokenStore>(),
        gh<_i372.TokenRefresher>(),
        gh<_i372.SessionInvalidator>(),
        gh<_i372.LocaleProvider>(),
        gh<_i417.Env>(),
      ),
      instanceName: 'acitsApi',
      registerFor: {_prod},
    );
    gh.factory<_i589.FileService>(() => _i589.FileService(gh<_i530.FileRepository>()));
    gh.factory<_i995.SheltersClient>(
      () => acitsApiRegister.sheltersClient(gh<_i361.Dio>(instanceName: 'acitsApiGuest')),
      registerFor: {_prod},
    );
    gh.factory<_i995.UsersRegistrationClient>(
      () => acitsApiRegister.usersRegistrationClient(gh<_i361.Dio>(instanceName: 'acitsApiGuest')),
      registerFor: {_prod},
    );
    gh.factory<_i995.AnimalsClient>(
      () => acitsApiRegister.animalsClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
      registerFor: {_prod},
    );
    gh.factory<_i995.UsersClient>(
      () => acitsApiRegister.usersClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
      registerFor: {_prod},
    );
    gh.factory<_i995.PrescriptionsClient>(
      () => acitsApiRegister.prescriptionsClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
      registerFor: {_prod},
    );
    gh.factory<_i995.ApplicantsClient>(
      () => acitsApiRegister.applicantsClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
      registerFor: {_prod},
    );
    gh.factory<_i995.CuratorsClient>(
      () => acitsApiRegister.curatorsClient(gh<_i361.Dio>(instanceName: 'acitsApi')),
      registerFor: {_prod},
    );
    gh.factory<_i995.AnimalApiPort>(
      () => acitsApiRegister.animalApiPort(gh<_i361.Dio>(instanceName: 'acitsApi'), gh<_i995.AnimalsClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i995.AnimalNotesApiPort>(
      () => acitsApiRegister.animalNotesApiPort(gh<_i361.Dio>(instanceName: 'acitsApi'), gh<_i995.AnimalsClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i995.SelectionApiPort>(
      () => acitsApiRegister.selectionApiPort(gh<_i361.Dio>(instanceName: 'acitsApi'), gh<_i995.AnimalsClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i995.SheltersClient>(
      () => acitsApiRegister.sheltersClientAuthed(gh<_i361.Dio>(instanceName: 'acitsApi')),
      instanceName: 'acitsApiSheltersAuthed',
      registerFor: {_prod},
    );
    gh.factory<_i995.TokenClient>(
      () => acitsApiRegister.tokenClientAuthed(gh<_i361.Dio>(instanceName: 'acitsApi')),
      instanceName: 'acitsApiTokenAuthed',
      registerFor: {_prod},
    );
    gh.factory<_i616.AnimalRemoteDataSource>(() => animalsRegister.animalRemoteDataSource(gh<_i995.AnimalApiPort>()));
    gh.factory<_i1007.CommentFileOpener>(() => _i118.FileServiceCommentFileOpener(gh<_i589.FileService>()));
    gh.factory<_i995.PrescriptionApiPort>(
      () => acitsApiRegister.prescriptionApiPort(
        gh<_i361.Dio>(instanceName: 'acitsApi'),
        gh<_i995.PrescriptionsClient>(),
        gh<_i995.SheltersClient>(instanceName: 'acitsApiSheltersAuthed'),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i995.ProfileApiPort>(
      () => acitsApiRegister.profileApiPort(gh<_i361.Dio>(instanceName: 'acitsApi'), gh<_i995.UsersClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i616.AnimalRepository>(() => animalsRegister.animalRepository(gh<_i616.AnimalRemoteDataSource>()));
    gh.factory<_i995.StaffApiPort>(
      () => acitsApiRegister.staffApiPort(gh<_i995.ApplicantsClient>(), gh<_i995.CuratorsClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i995.AuthApiPort>(
      () => acitsApiRegister.authApiPort(
        gh<_i361.Dio>(instanceName: 'acitsApiGuest'),
        gh<_i995.TokenClient>(instanceName: 'acitsApiTokenAuthed'),
        gh<_i995.UsersClient>(),
        gh<_i995.SheltersClient>(),
        gh<_i995.UsersRegistrationClient>(),
      ),
      registerFor: {_prod},
    );
    gh.singleton<_i397.AuthService>(
      () => _i397.AuthService(
        gh<_i494.AuthApiPort>(),
        gh<_i358.AuthRepository>(),
        gh<_i672.EmailConfirmRepository>(),
        gh<_i614.PreferenceStorage>(),
      ),
    );
    gh.singleton<_i277.ConfigService>(
      () => _i277.ConfigService(gh<_i995.SelectionApiPort>(), gh<_i397.AuthService>(), gh<_i614.PreferenceStorage>()),
    );
    gh.factory<_i20.ApplicantsShelterProvider>(() => _i14.AuthServiceApplicantsShelter(gh<_i397.AuthService>()));
    gh.factory<_i249.MediaShelterProvider>(() => _i428.AuthServiceMediaShelter(gh<_i397.AuthService>()));
    gh.factory<_i1007.PersonalShelterProvider>(() => _i118.AuthServicePersonalShelter(gh<_i397.AuthService>()));
    gh.factory<_i616.CurrentShelterProvider>(() => _i694.AuthServiceCurrentShelter(gh<_i397.AuthService>()));
    gh.factory<_i857.PrescriptionAnimalLoader>(
      () => _i68.AnimalRepositoryPrescriptionAnimalLoader(gh<_i616.AnimalRepository>(), gh<_i397.AuthService>()),
    );
    gh.singleton<_i20.StaffRepository>(
      () => applicantsRegister.staffRepository(gh<_i20.ApplicantsShelterProvider>(), gh<_i995.StaffApiPort>()),
    );
    gh.singleton<_i1007.PersonalRepository>(
      () => personalRegister.personalRepository(gh<_i995.ProfileApiPort>(), gh<_i1007.PersonalShelterProvider>()),
    );
    gh.factory<_i857.PrescriptionsShelterProvider>(() => _i68.AuthServicePrescriptionsShelter(gh<_i397.AuthService>()));
    gh.factory<_i616.AnimalPermissions>(() => _i694.AuthServiceAnimalPermissions(gh<_i397.AuthService>()));
    gh.factory<_i249.DocumentRepository>(
      () => mediaRegister.documentRepository(gh<_i616.AnimalRepository>(), gh<_i616.CurrentShelterProvider>()),
    );
    gh.factory<_i857.PrescriptionTypeLabels>(() => _i68.ConfigServicePrescriptionTypeLabels(gh<_i277.ConfigService>()));
    gh.factory<_i616.AnimalStatusLabels>(() => _i694.ConfigServiceAnimalStatusLabels(gh<_i277.ConfigService>()));
    gh.singleton<_i857.PrescriptionRepository>(
      () => prescriptionsRegister.prescriptionRepository(
        gh<_i995.PrescriptionApiPort>(),
        gh<_i857.PrescriptionsShelterProvider>(),
        gh<_i857.PrescriptionTypeLabels>(),
      ),
    );
    gh.singleton<_i1007.CommentsRepository>(
      () => personalRegister.commentsRepository(gh<_i995.AnimalNotesApiPort>(), gh<_i1007.PersonalShelterProvider>()),
    );
    gh.singleton<_i20.StaffService>(() => applicantsRegister.staffService(gh<_i20.StaffRepository>()));
    gh.singleton<_i857.PrescriptionService>(
      () => prescriptionsRegister.prescriptionService(gh<_i857.PrescriptionRepository>()),
    );
    gh.factory<_i249.SearchDeps>(
      () => mediaRegister.searchDeps(
        gh<_i616.AnimalRepository>(),
        gh<_i20.StaffService>(),
        gh<_i857.PrescriptionService>(),
        gh<_i249.MediaShelterProvider>(),
      ),
    );
  }
}

class _$SecureStorageRegister extends _i922.SecureStorageRegister {}

class _$SharedPreferenceRegister extends _i100.SharedPreferenceRegister {}

class _$DioRegister extends _i1042.DioRegister {}

class _$EnvRegistrer extends _i311.EnvRegistrer {}

class _$AcitsApiRegister extends _i472.AcitsApiRegister {}

class _$AnimalsRegister extends _i121.AnimalsRegister {}

class _$ApplicantsRegister extends _i14.ApplicantsRegister {}

class _$PersonalRegister extends _i118.PersonalRegister {}

class _$MediaRegister extends _i428.MediaRegister {}

class _$PrescriptionsRegister extends _i68.PrescriptionsRegister {}
