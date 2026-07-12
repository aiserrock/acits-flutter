import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/gen/api/openapi.swagger.dart';
import 'package:acits_flutter/domain/prescription_model.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/extra_codec.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/service/document/pdf_doc_mixin.dart';
import 'package:acits_flutter/ui/screen/animal_detail/animal_detail_screen.dart';
import 'package:acits_flutter/ui/screen/animal_edit/animal_edit_screen.dart';
import 'package:acits_flutter/ui/screen/applicant/applicant_edit_screen.dart';
import 'package:acits_flutter/ui/screen/auth/pick_shelter_screen.dart';
import 'package:acits_flutter/ui/screen/auth/view/login_screen.dart';
import 'package:acits_flutter/ui/screen/comments/comment_edit_screen.dart';
import 'package:acits_flutter/ui/screen/curator/curator_edit_screen.dart';
import 'package:acits_flutter/ui/screen/doc_viewer/doc_viewer_screen.dart';
import 'package:acits_flutter/ui/screen/onboarding/bloc/onboarding_bloc.dart';
import 'package:acits_flutter/ui/screen/onboarding/view/onboarding_screen.dart';
import 'package:acits_flutter/ui/screen/personal_screen/personal_screen.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/photo_gallery_screen.dart';
import 'package:acits_flutter/ui/screen/prescription/prescription_edit_screen.dart';
import 'package:acits_flutter/ui/screen/registration/email_confirmation_screen.dart';
import 'package:acits_flutter/ui/screen/registration/registration_screen.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_spec_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Пути и имена роутов приложения.
///
/// Навигация построена на go_router (прямое использование через getIt, без
/// interface-обёртки — mainstream-подход Flutter-команды 2026). Экраны, которые
/// возвращают значение, открываются через `context.push<T>()` + `context.pop(result)`.
/// Сложные объекты передаются через `extra` (см. [AppExtraCodec]).
abstract final class AppRoutes {
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

  /// Построить путь к экрану деталей животного.
  static String animalDetailPath(int id) => '/animal/$id';

  /// Построить путь к галерее фото животного.
  static String photoGalleryPath(int animalId) => '/photo-gallery/$animalId';

  /// Построить путь к экрану добавления/редактирования комментария.
  static String commentEditPath(int animalId) => '/comment-edit/$animalId';

  /// Построить путь к generic-поиску по строковому ключу типа (см. [SearchTypeKey]).
  static String searchPath(String typeKey) => '/search?type=$typeKey';
}

/// Создать [GoRouter] приложения. Вызывается из DI (см. `di_container.dart`).
///
/// Навигация авторизации остаётся явной (logout/login вызывают `go` напрямую),
/// т.к. флоу входа многошаговый (login → выбор приюта → root) и авто-redirect
/// по наличию токена конфликтовал бы с промежуточным выбором приюта.
GoRouter createAppRouter() {
  final config = getIt<ConfigService>();

  return GoRouter(
    navigatorKey: getIt<GlobalKey<NavigatorState>>(),
    initialLocation: config.isFirstLaunch ? AppRoutes.onboarding : AppRoutes.login,
    extraCodec: const AppExtraCodec(),
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) =>
            BlocProvider(create: (_) => OnboardingBloc(), child: const OnboardingScreen()),
      ),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.registration,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailConfirmation,
        builder: (context, state) =>
            EmailConfirmationScreen(confirmLink: state.uri.queryParameters['link'] ?? ''),
      ),
      GoRoute(path: AppRoutes.root, builder: (context, state) => const RootScreen()),
      GoRoute(
        path: AppRoutes.animalDetail,
        builder: (context, state) => AnimalDetailScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: AppRoutes.animalEdit,
        builder: (context, state) =>
            AnimalEditScreen(id: int.tryParse(state.uri.queryParameters['id'] ?? '')),
      ),
      GoRoute(
        path: AppRoutes.applicantEdit,
        builder: (context, state) => ApplicantEditScreen(
          applicantId: int.tryParse(state.uri.queryParameters['applicantId'] ?? ''),
        ),
      ),
      GoRoute(
        path: AppRoutes.curatorEdit,
        builder: (context, state) => CuratorEditScreen(
          curatorId: int.tryParse(state.uri.queryParameters['curatorId'] ?? ''),
        ),
      ),
      GoRoute(
        path: AppRoutes.commentEdit,
        builder: (context, state) => CommentEditScreen(
          animalId: int.parse(state.pathParameters['animalId']!),
          comment: state.extra as AnimalNote?,
        ),
      ),
      GoRoute(
        path: AppRoutes.prescriptionEdit,
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>?;
          return PrescriptionEditScreen(
            editPrescriptionId: int.tryParse(state.uri.queryParameters['id'] ?? ''),
            editPrescription: extra?['prescription'] as PrescriptionModel?,
            animal: extra?['animal'] as AnimalRead?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.docViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>?;
          return DocViewerScreen(
            extra?['fetcher'] as PdfDocFetcher,
            title: extra?['title'] as String?,
            fileName: extra?['fileName'] as String?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.photoGallery,
        builder: (context, state) =>
            PhotoGalleryScreen(animalId: int.parse(state.pathParameters['animalId']!)),
      ),
      GoRoute(
        path: AppRoutes.personal,
        builder: (context, state) =>
            PersonalScreen(isChangePass: state.uri.queryParameters['changePass'] == 'true'),
      ),
      GoRoute(
        path: AppRoutes.pickShelter,
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>?;
          return PickShelterScreen(
            autoSelectSingle: extra?['autoSelectSingle'] as bool? ?? true,
            shelterList: extra?['shelterList'] as PaginatedShelterShortSerializersList?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.searchSpec,
        builder: (context, state) => SearchScreen(parentSearch: state.extra as Species?),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) =>
            Search.byTypeKey(state.uri.queryParameters['type'] ?? SearchTypeKey.animal),
      ),
    ],
  );
}
