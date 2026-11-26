import 'package:core/domain.dart' show Shelter;
import 'package:util/util.dart' show Failure, Result;
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:animals/animals.dart' show AnimalRepository, AnimalSpecies, CurrentShelterProvider;
import 'package:applicants/applicants.dart';
import 'package:media/media.dart';
import 'package:prescriptions/prescriptions.dart'
    show
        CalendarScreen,
        DrugsScreen,
        PrescriptionAnimalLoader,
        PrescriptionEditScreen,
        PrescriptionRepository,
        PrescriptionTypeLabels,
        PrescriptionsRouterService;
import 'package:personal/personal.dart'
    show
        AnimalNote,
        CommentEditScreen,
        CommentsRepository,
        MySheltersScreen,
        MySheltersSource,
        PersonalRepository,
        PersonalScreen;
import 'package:app_services/app_services.dart' show AnimalService, AuthService, ConfigService, DebugService;
import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart' show LocaleKeys;
import 'package:di/di.dart';
import 'package:shell/navigation/auth_screen_bindings.dart';
import 'package:shell/navigation/extra_codec.dart';
import 'package:shell/navigation/route_error_screen.dart';
import 'package:shell/presentation/animal_detail/animal_detail_screen.dart';
import 'package:shell/presentation/animal_edit/animal_edit_screen.dart';
import 'package:shell/presentation/animals_section.dart';
import 'package:shell/presentation/main/main_screen.dart';
import 'package:shell/presentation/gallery/gallery_screen.dart';
import 'package:shell/presentation/root_screen.dart';

/// Пути и имена роутов приложения.
///
/// Навигация построена на go_router (прямое использование через getIt, без
/// interface-обёртки — mainstream-подход Flutter-команды 2026). Экраны, которые
/// возвращают значение, открываются через `context.push<T>()` + `context.pop(result)`.
///
/// Идентичность экрана целиком лежит в path/query: ссылка открывается после
/// перезагрузки web-страницы, по «назад/вперёд» браузера и при восстановлении
/// состояния. `extra` (см. [AppExtraCodec]) допустим только как необязательный
/// in-memory кэш уже загруженной сущности; он живёт в рамках процесса и
/// извлекается один раз, поэтому билдеры роутов обязаны работать и без него.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const registration = '/registration';
  static const emailConfirmation = '/email-confirmation';

  /// New password from an e-mailed reset link (`?link=<the link>`).
  static const resetPassword = '/reset-password';

  /// The signed-in shell; lands on the «Today» tab.
  static const root = today;

  // Tabs of the signed-in shell. Each tab keeps its own navigation stack.
  static const today = '/today';
  static const animals = '/animals';
  static const calendar = '/calendar';
  static const drugs = '/drugs';

  /// Animal card inside the animals tab (next to the list on wide windows).
  static const animalDetail = '/animals/:id';
  static const animalEdit = '/animal-edit';
  static const applicantEdit = '/applicant-edit';
  static const curatorEdit = '/curator-edit';
  static const commentEdit = '/comment-edit/:animalId';
  static const prescriptionEdit = '/prescription-edit';
  static const docViewer = '/doc-viewer';
  static const photoGallery = '/photo-gallery/:animalId';
  static const personal = '/personal';
  static const pickShelter = '/pick-shelter';
  static const myShelters = '/my-shelters';
  static const searchSpec = '/search-spec';
  static const search = '/search';

  /// Debug-галерея дизайн-системы (только dev-флейвор, любой build-режим).
  static const gallery = '/debug/gallery';

  /// Построить путь к экрану деталей животного.
  static String animalDetailPath(int id) => '/animals/$id';

  /// Построить путь к галерее фото животного.
  static String photoGalleryPath(int animalId) => '/photo-gallery/$animalId';

  /// Построить путь к экрану добавления/редактирования комментария. С
  /// [commentId] открывается правка существующего комментария; сама заметка
  /// может ехать в `extra` как кэш.
  static String commentEditPath(int animalId, {int? commentId}) =>
      commentId == null ? '/comment-edit/$animalId' : '/comment-edit/$animalId?id=$commentId';

  /// Построить путь к просмотрщику документа [kind] с идентификатором [id].
  /// [title] и [fileName] едут в query, чтобы ссылка воспроизводилась целиком.
  static String docViewerPath(DocKind kind, int id, {String? title, String? fileName}) => Uri(
    path: docViewer,
    queryParameters: <String, String>{'kind': kind.name, 'id': '$id', 'title': ?title, 'fileName': ?fileName},
  ).toString();

  /// Построить путь к выбору приюта. Без автовыбора единственного приюта
  /// добавляется `autoSelectSingle=false` (по умолчанию автовыбор включён).
  static String pickShelterPath({bool autoSelectSingle = true}) =>
      autoSelectSingle ? pickShelter : '$pickShelter?autoSelectSingle=false';

  /// Построить путь к поиску вида животного; [parent] — вид, внутри которого
  /// ищем (его id и уровень едут в query).
  static String searchSpecPath({AnimalSpecies? parent}) => parent == null
      ? searchSpec
      : Uri(
          path: searchSpec,
          queryParameters: <String, String>{'parentId': '${parent.id}', 'parentLevel': '${parent.level}'},
        ).toString();

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
///
/// [initialLocation] и [initialExtra] нужны тестам, чтобы открыть конкретный URL
/// (с кэшем в `extra` или без него) вместо splash.
GoRouter createAppRouter({
  @visibleForTesting String initialLocation = AppRoutes.splash,
  @visibleForTesting Object? initialExtra,
}) {
  return GoRouter(
    navigatorKey: getIt<GlobalKey<NavigatorState>>(),
    observers: getIt.isRegistered<List<NavigatorObserver>>() ? getIt<List<NavigatorObserver>>() : null,
    // Всегда стартуем со splash: он делает refresh токена и решает, куда идти
    // (onboarding / login / pick-shelter / root), без мелькания login.
    initialLocation: initialLocation,
    initialExtra: initialExtra,
    extraCodec: const AppExtraCodec(),
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => AuthScreenBindings.splash()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => AuthScreenBindings.onboarding()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => AuthScreenBindings.login()),
      GoRoute(path: AppRoutes.registration, builder: (context, state) => AuthScreenBindings.registration()),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => AuthScreenBindings.resetPassword(state.uri.queryParameters['link'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.emailConfirmation,
        builder: (context, state) => AuthScreenBindings.emailConfirmation(state.uri.queryParameters['link'] ?? ''),
      ),
      // Paths used before the tabs had their own URLs: saved links and bookmarks keep working.
      GoRoute(path: '/root', redirect: (_, _) => AppRoutes.today),
      GoRoute(
        path: '/animal/:id',
        redirect: (_, state) => AppRoutes.animalDetailPath(int.parse(state.pathParameters['id']!)),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => RootScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.today, builder: (context, state) => const MainScreen())],
          ),
          StatefulShellBranch(
            routes: [
              ShellRoute(
                builder: (context, state, child) => AnimalsSection(child: child),
                routes: [
                  GoRoute(
                    path: AppRoutes.animals,
                    builder: (context, state) => const AnimalsRootPage(),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (context, state) => AnimalDetailScreen(
                          key: ValueKey(state.pathParameters['id']),
                          id: int.parse(state.pathParameters['id']!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.calendar,
                builder: (context, state) => CalendarScreen(
                  repository: getIt<PrescriptionRepository>(),
                  onMenuPressed: RootDrawerProvider.of(context)?.openDrawer,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.drugs,
                builder: (context, state) => DrugsScreen(
                  repository: getIt<PrescriptionRepository>(),
                  onMenuPressed: RootDrawerProvider.of(context)?.openDrawer,
                ),
              ),
            ],
          ),
        ],
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
        builder: (context, state) {
          final animalId = int.tryParse(state.pathParameters['animalId'] ?? '');
          if (animalId == null) return const RouteErrorScreen();
          // Identity: `?id=<noteId>` marks an edit. The note may ride in `extra` as an
          // in-memory cache; without it (reload, back/forward) it is loaded by id.
          final extra = state.extra;
          final cached = extra is AnimalNote ? extra : null;
          final rawId = state.uri.queryParameters['id'];
          final repository = getIt<CommentsRepository>();
          if (rawId == null) return CommentEditScreen(repository: repository, animalId: animalId);
          final noteId = int.tryParse(rawId);
          if (noteId == null) return const RouteErrorScreen();
          if (cached != null && cached.id == noteId) {
            return CommentEditScreen(repository: repository, animalId: animalId, comment: cached);
          }
          return _CommentEditById(repository: repository, animalId: animalId, noteId: noteId);
        },
      ),
      // Identity is `id` (edit) / `animalId` (preset animal) in the query; the screen loads
      // the prescription and the animal itself through its repository and loader.
      GoRoute(
        path: AppRoutes.prescriptionEdit,
        builder: (context, state) => PrescriptionEditScreen(
          repository: getIt<PrescriptionRepository>(),
          router: getIt<PrescriptionsRouterService>(),
          animalLoader: getIt<PrescriptionAnimalLoader>(),
          typeLabels: getIt<PrescriptionTypeLabels>(),
          scaffoldMessengerKey: getIt<GlobalKey<ScaffoldMessengerState>>(),
          editPrescriptionId: int.tryParse(state.uri.queryParameters['id'] ?? ''),
          animalId: int.tryParse(state.uri.queryParameters['animalId'] ?? ''),
        ),
      ),
      // The document is described by `kind` + `id` (+ optional `title`/`fileName`) and the
      // byte fetcher is resolved here through DI.
      GoRoute(
        path: AppRoutes.docViewer,
        builder: (context, state) {
          final query = state.uri.queryParameters;
          final kind = DocKind.fromName(query['kind']);
          final id = int.tryParse(query['id'] ?? '');
          if (kind == null || id == null) return const RouteErrorScreen();
          return DocViewerScreen(
            _docFetcher(kind, id),
            exporter: getIt<DocExporterPort>(),
            pdfjsReady: getIt<PdfjsReadyPort>(),
            title: query['title'],
            fileName: query['fileName'],
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
        path: AppRoutes.myShelters,
        builder: (context, state) =>
            MySheltersScreen(source: getIt<MySheltersSource>(), onSwitch: (shelter) => _switchShelter(shelter)),
      ),
      GoRoute(
        path: AppRoutes.pickShelter,
        builder: (context, state) {
          // `autoSelectSingle` lives in the query. The shelter list may ride in `extra` as a
          // cache; without it the screen takes the session's list or loads it itself.
          final extra = state.extra;
          return AuthScreenBindings.pickShelter(
            autoSelectSingle: state.uri.queryParameters['autoSelectSingle'] != 'false',
            shelterList: extra is List<Shelter> ? extra : null,
          );
        },
      ),
      // The parent species is `parentId` + `parentLevel` in the query (no parent: top level).
      GoRoute(
        path: AppRoutes.searchSpec,
        builder: (context, state) {
          final query = state.uri.queryParameters;
          final parentId = int.tryParse(query['parentId'] ?? '');
          return SearchScreen(
            repository: getIt<AnimalRepository>(),
            shelterProvider: getIt<CurrentShelterProvider>(),
            parentId: parentId,
            parentLevel: parentId == null ? 0 : int.tryParse(query['parentLevel'] ?? '') ?? 1,
          );
        },
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

/// Byte source of the document described by [kind] + [id], resolved through DI.
PdfDocFetcher _docFetcher(DocKind kind, int id) => switch (kind) {
  DocKind.animalCard => () => getIt<AnimalService>().fetchPdfAnimalCard(id),
};

bool _switchingShelter = false;

/// Makes [shelter] current and lands on the root screen.
///
/// Mirrors what the pick-shelter screen does after a tap: set the current
/// shelter, reload the shelter-scoped config, then `go` to the root (the same
/// call as `AuthRouterService.toRoot`), which rebuilds the tabs for the new
/// shelter. On failure the user stays on the list and gets a message.
Future<void> _switchShelter(Shelter shelter) async {
  if (_switchingShelter) return;
  _switchingShelter = true;
  try {
    final failure =
        (await getIt<AuthService>().setCurrentShelter(shelter.id)).failureOrNull ??
        (await getIt<ConfigService>().initConfig(currentShelterId: shelter.id)).failureOrNull;
    if (failure != null) {
      getIt<GlobalKey<ScaffoldMessengerState>>().currentState?.showSnackBar(
        SnackBar(content: Text(LocaleKeys.errorDefaultMsg.tr())),
      );
      return;
    }
    getIt<GoRouter>().go(AppRoutes.root);
  } finally {
    _switchingShelter = false;
  }
}

/// Loads a note by id, then opens it for editing; the error screen when it cannot.
class _CommentEditById extends StatelessWidget {
  const _CommentEditById({required this.repository, required this.animalId, required this.noteId});

  final CommentsRepository repository;
  final int animalId;
  final int noteId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<Failure, AnimalNote>>(
      future: repository.getById(noteId),
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        final note = result.valueOrNull;
        if (note == null) return const RouteErrorScreen();
        return CommentEditScreen(repository: repository, animalId: animalId, comment: note);
      },
    );
  }
}
