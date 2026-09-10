import 'package:core/domain.dart' show Shelter;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:animals/animals.dart' show AnimalRepository, AnimalSpecies, CurrentShelterProvider;
import 'package:applicants/applicants.dart';
import 'package:media/media.dart';
import 'package:prescriptions/prescriptions.dart'
    show
        Prescription,
        PrescriptionAnimalLoader,
        PrescriptionAnimalRef,
        PrescriptionEditScreen,
        PrescriptionRepository,
        PrescriptionTypeLabels,
        PrescriptionsRouterService;
import 'package:personal/personal.dart'
    show AnimalNote, CommentEditScreen, CommentsRepository, PersonalRepository, PersonalScreen;
import 'package:app_services/app_services.dart' show DebugService;
import 'package:di/di.dart';
import 'package:shell/navigation/auth_screen_bindings.dart';
import 'package:shell/navigation/extra_codec.dart';
import 'package:shell/presentation/animal_detail/animal_detail_screen.dart';
import 'package:shell/presentation/animal_edit/animal_edit_screen.dart';
import 'package:shell/presentation/gallery/gallery_screen.dart';
import 'package:shell/presentation/root_screen.dart';

/// Пути и имена роутов приложения.
///
/// Навигация построена на go_router (прямое использование через getIt, без
/// interface-обёртки — mainstream-подход Flutter-команды 2026). Экраны, которые
/// возвращают значение, открываются через `context.push<T>()` + `context.pop(result)`.
/// Сложные объекты передаются через `extra` (см. [AppExtraCodec]).
abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const registration = '/registration';
  static const emailConfirmation = '/email-confirmation';
  static const root = '/root';

  static const animalDetail = '/animal/:id';
  static const animalEdit = '/animal-edit';
  static const applicantEdit = '/applicant-edit';
  static const curatorEdit = '/curator-edit';
  static const commentEdit = '/comment-edit/:animalId';
  static const prescriptionEdit = '/prescription-edit';
  static const docViewer = '/doc-viewer';
  static const photoGallery = '/photo-gallery/:animalId';
  static const personal = '/personal';
  static const pickShelter = '/pick-shelter';
  static const searchSpec = '/search-spec';
  static const search = '/search';

  /// Debug-галерея дизайн-системы (только dev-флейвор, любой build-режим).
  static const gallery = '/debug/gallery';

  /// Построить путь к экрану деталей животного.
  static String animalDetailPath(int id) => '/animal/$id';

  /// Построить путь к галерее фото животного.
  static String photoGalleryPath(int animalId) => '/photo-gallery/$animalId';

  /// Построить путь к экрану добавления/редактирования комментария.
  static String commentEditPath(int animalId) => '/comment-edit/$animalId';

  /// Построить путь к созданию назначения для preset-животного [animalId].
  static String prescriptionEditForAnimalPath(int animalId) => '/prescription-edit?animalId=$animalId';

  /// Построить путь к generic-поиску по строковому ключу типа (см. [SearchTypeKey]).
  static String searchPath(String typeKey) => '/search?type=$typeKey';
}

/// Создать [GoRouter] приложения. Вызывается из DI (см. `di_container.dart`).
///
/// Навигация авторизации остаётся явной (logout/login вызывают `go` напрямую),
/// т.к. флоу входа многошаговый (login → выбор приюта → root) и авто-redirect
/// по наличию токена конфликтовал бы с промежуточным выбором приюта.
GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: getIt<GlobalKey<NavigatorState>>(),
    // Всегда стартуем со splash: он делает refresh токена и решает, куда идти
    // (onboarding / login / pick-shelter / root), без мелькания login.
    initialLocation: AppRoutes.splash,
    extraCodec: const AppExtraCodec(),
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => AuthScreenBindings.splash()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => AuthScreenBindings.onboarding()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => AuthScreenBindings.login()),
      GoRoute(path: AppRoutes.registration, builder: (context, state) => AuthScreenBindings.registration()),
      GoRoute(
        path: AppRoutes.emailConfirmation,
        builder: (context, state) => AuthScreenBindings.emailConfirmation(state.uri.queryParameters['link'] ?? ''),
      ),
      GoRoute(path: AppRoutes.root, builder: (context, state) => const RootScreen()),
      GoRoute(
        path: AppRoutes.animalDetail,
        builder: (context, state) => AnimalDetailScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: AppRoutes.animalEdit,
        builder: (context, state) => AnimalEditScreen(id: int.tryParse(state.uri.queryParameters['id'] ?? '')),
      ),
      GoRoute(
        path: AppRoutes.applicantEdit,
        builder: (context, state) => ApplicantEditScreen(
          staffRepository: getIt<StaffRepository>(),
          applicantId: int.tryParse(state.uri.queryParameters['applicantId'] ?? ''),
        ),
      ),
      GoRoute(
        path: AppRoutes.curatorEdit,
        builder: (context, state) => CuratorEditScreen(
          staffRepository: getIt<StaffRepository>(),
          curatorId: int.tryParse(state.uri.queryParameters['curatorId'] ?? ''),
        ),
      ),
      GoRoute(
        path: AppRoutes.commentEdit,
        builder: (context, state) => CommentEditScreen(
          repository: getIt<CommentsRepository>(),
          animalId: int.parse(state.pathParameters['animalId']!),
          comment: state.extra as AnimalNote?,
        ),
      ),
      GoRoute(
        path: AppRoutes.prescriptionEdit,
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>?;
          return PrescriptionEditScreen(
            repository: getIt<PrescriptionRepository>(),
            router: getIt<PrescriptionsRouterService>(),
            animalLoader: getIt<PrescriptionAnimalLoader>(),
            typeLabels: getIt<PrescriptionTypeLabels>(),
            scaffoldMessengerKey: getIt<GlobalKey<ScaffoldMessengerState>>(),
            editPrescriptionId: int.tryParse(state.uri.queryParameters['id'] ?? ''),
            animalId: int.tryParse(state.uri.queryParameters['animalId'] ?? ''),
            editPrescription: extra?['prescription'] as Prescription?,
            animal: extra?['animal'] as PrescriptionAnimalRef?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.docViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>?;
          return DocViewerScreen(
            extra?['fetcher'] as PdfDocFetcher,
            exporter: getIt<DocExporterPort>(),
            pdfjsReady: getIt<PdfjsReadyPort>(),
            title: extra?['title'] as String?,
            fileName: extra?['fileName'] as String?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.photoGallery,
        builder: (context, state) => PhotoGalleryScreen(
          animalId: int.parse(state.pathParameters['animalId']!),
          repository: getIt<AnimalRepository>(),
          shelterProvider: getIt<CurrentShelterProvider>(),
        ),
      ),
      GoRoute(
        path: AppRoutes.personal,
        builder: (context, state) => PersonalScreen(
          repository: getIt<PersonalRepository>(),
          isChangePass: state.uri.queryParameters['changePass'] == 'true',
        ),
      ),
      GoRoute(
        path: AppRoutes.pickShelter,
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>?;
          return AuthScreenBindings.pickShelter(
            autoSelectSingle: extra?['autoSelectSingle'] as bool? ?? true,
            shelterList: extra?['shelterList'] as List<Shelter>?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.searchSpec,
        builder: (context, state) => SearchScreen(
          repository: getIt<AnimalRepository>(),
          shelterProvider: getIt<CurrentShelterProvider>(),
          parentSearch: state.extra as AnimalSpecies?,
        ),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) =>
            Search.byTypeKey(state.uri.queryParameters['type'] ?? SearchTypeKey.animal, getIt<SearchDeps>()),
      ),
      // Debug-галерея дизайн-системы: та же ui_kit-витрина, что и standalone
      // example. Гейт по dev-флейвору (а не kDebugMode), поэтому доступна в dev
      // в ЛЮБОМ build-режиме (debug/profile/release). В prod-флейворе
      // `isDevFlavor == false` → роут не регистрируется.
      if (getIt<DebugService>().isDevFlavor)
        GoRoute(path: AppRoutes.gallery, builder: (context, state) => const GalleryScreen()),
    ],
  );
}
