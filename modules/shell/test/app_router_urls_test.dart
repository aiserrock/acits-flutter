import 'dart:typed_data';

import 'package:animals/animals.dart';
import 'package:app_services/app_services.dart' show AnimalService, AuthService, ConfigService, DebugService;
import 'package:auth/auth.dart' show AuthRouterService, PickShelterScreen;
import 'package:core/domain.dart' show Shelter;
import 'package:di/di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:media/media.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';
import 'package:prescriptions/prescriptions.dart';
import 'package:shell/navigation/app_router.dart';
import 'package:shell/navigation/route_error_screen.dart';
import 'package:ui_kit/ui_kit.dart' show AppTheme;
import 'package:util/util.dart';

/// Every route that used to depend on `extra` opens here from the URL alone (the
/// state of a web reload / a pasted link): the test starts the real router at the
/// URL with no `extra` and expects the screen, not a crash or an empty page.
/// Repositories and services are fakes; nothing touches the network.

class _MockAuthService extends Mock implements AuthService {}

class _MockConfigService extends Mock implements ConfigService {}

class _MockAuthRouter extends Mock implements AuthRouterService {}

class _MockAnimalRepository extends Mock implements AnimalRepository {}

class _MockShelterProvider extends Mock implements CurrentShelterProvider {}

class _MockCommentsRepository extends Mock implements CommentsRepository {}

class _MockPrescriptionRepository extends Mock implements PrescriptionRepository {}

class _MockPrescriptionsRouter extends Mock implements PrescriptionsRouterService {}

class _MockAnimalLoader extends Mock implements PrescriptionAnimalLoader {}

class _MockTypeLabels extends Mock implements PrescriptionTypeLabels {}

class _MockExporter extends Mock implements DocExporterPort {}

class _MockPdfjsReady extends Mock implements PdfjsReadyPort {}

/// Records the animals whose card was requested; the fetch itself fails (no network).
class _FakeAnimalService extends AnimalService {
  final requested = <int>[];

  @override
  Future<Uint8List> fetchPdfAnimalCard(int animalId) async {
    requested.add(animalId);
    throw StateError('no network in tests');
  }
}

const _alpha = Shelter(id: 1, name: 'Alpha');
const _beta = Shelter(id: 2, name: 'Beta');

void main() {
  late _MockAuthService auth;
  late _MockAnimalRepository animals;
  late _MockCommentsRepository comments;
  late _MockPrescriptionRepository prescriptions;
  late _MockAnimalLoader animalLoader;
  late _FakeAnimalService animalService;
  late GoRouter router;

  setUp(() {
    auth = _MockAuthService();
    animals = _MockAnimalRepository();
    comments = _MockCommentsRepository();
    prescriptions = _MockPrescriptionRepository();
    animalLoader = _MockAnimalLoader();
    animalService = _FakeAnimalService();

    final shelterProvider = _MockShelterProvider();
    when(() => shelterProvider.shelterId).thenReturn(50);
    // Session without a shelter list: what a reloaded page looks like.
    when(() => auth.shelterList).thenReturn(const []);
    when(() => auth.getShelterList()).thenAnswer((_) async => const Ok([_alpha, _beta]));
    when(
      () => animals.listSpecies(
        level: any(named: 'level'),
        parentId: any(named: 'parentId'),
        search: any(named: 'search'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => const Ok(<AnimalSpecies>[AnimalSpecies(id: 9, name: 'Барсик', level: 2)]));
    when(() => prescriptions.getById(5)).thenAnswer(
      (_) async => Ok(
        Prescription(id: 5, animal: 77, type: PrescriptionType.selectable.first, drugs: const [], executions: const []),
      ),
    );
    when(() => animalLoader.loadById(77)).thenAnswer((_) async => const PrescriptionAnimalRef(id: 77, name: 'Рекс'));
    final typeLabels = _MockTypeLabels();
    when(() => typeLabels.nameForWire(any())).thenReturn('Тип');
    final pdfjsReady = _MockPdfjsReady();
    when(pdfjsReady.ensure).thenAnswer((_) async {});

    getIt
      ..registerSingleton(GlobalKey<NavigatorState>())
      ..registerSingleton(GlobalKey<ScaffoldMessengerState>())
      ..registerSingleton(DebugService())
      ..registerSingleton<AuthService>(auth)
      ..registerSingleton<ConfigService>(_MockConfigService())
      ..registerSingleton<AuthRouterService>(_MockAuthRouter())
      ..registerSingleton<AnimalRepository>(animals)
      ..registerSingleton<CurrentShelterProvider>(shelterProvider)
      ..registerSingleton<CommentsRepository>(comments)
      ..registerSingleton<PrescriptionRepository>(prescriptions)
      ..registerSingleton<PrescriptionsRouterService>(_MockPrescriptionsRouter())
      ..registerSingleton<PrescriptionAnimalLoader>(animalLoader)
      ..registerSingleton<PrescriptionTypeLabels>(typeLabels)
      ..registerSingleton<DocExporterPort>(_MockExporter())
      ..registerSingleton<PdfjsReadyPort>(pdfjsReady)
      ..registerSingleton<AnimalService>(animalService);
  });

  tearDown(() async {
    router.dispose();
    await getIt.reset();
  });

  /// Starts the real app router at [location] (optionally with a cached [extra]).
  Future<void> open(
    WidgetTester tester,
    String location, {
    Object? extra,
    Size size = const Size(900, 1600),
    double textScale = 1,
  }) async {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    router = createAppRouter(initialLocation: location, initialExtra: extra);
    await tester.pumpWidget(MaterialApp.router(theme: AppTheme.light, routerConfig: router));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  group('/comment-edit/:animalId', () {
    testWidgets('opens the «new comment» screen from the path alone', (tester) async {
      await open(tester, AppRoutes.commentEditPath(7));

      final screen = tester.widget<CommentEditScreen>(find.byType(CommentEditScreen));
      expect(screen.animalId, 7);
      expect(screen.comment, isNull);
    });

    testWidgets('an edit link without the cached note loads the note by id', (tester) async {
      const note = AnimalNote(id: 3, animal: 7, content: 'from the server');
      when(() => comments.getById(3)).thenAnswer((_) async => const Ok(note));
      await open(tester, AppRoutes.commentEditPath(7, commentId: 3));
      await tester.pump();

      verify(() => comments.getById(3)).called(1);
      expect(tester.widget<CommentEditScreen>(find.byType(CommentEditScreen)).comment, note);
    });

    testWidgets('an edit link for a note that cannot be loaded shows the error screen', (tester) async {
      when(() => comments.getById(3)).thenAnswer((_) async => const Err(ServerFailure(404)));
      await open(tester, AppRoutes.commentEditPath(7, commentId: 3));
      await tester.pump();

      expect(find.byType(RouteErrorScreen), findsOneWidget);
      expect(find.byType(CommentEditScreen), findsNothing);
    });

    testWidgets('the cached note in extra prefills the edit screen', (tester) async {
      const note = AnimalNote(id: 3, animal: 7, content: 'hello');
      await open(tester, AppRoutes.commentEditPath(7, commentId: 3), extra: note);

      expect(tester.widget<CommentEditScreen>(find.byType(CommentEditScreen)).comment, note);
    });

    testWidgets('a non-numeric animal id shows the error screen', (tester) async {
      await open(tester, '/comment-edit/abc');

      expect(find.byType(RouteErrorScreen), findsOneWidget);
    });
  });

  group('/prescription-edit', () {
    testWidgets('?id= loads the prescription and its animal through the repository', (tester) async {
      await open(tester, '${AppRoutes.prescriptionEdit}?id=5');

      final screen = tester.widget<PrescriptionEditScreen>(find.byType(PrescriptionEditScreen));
      expect(screen.editPrescriptionId, 5);
      expect(screen.editPrescription, isNull);
      verify(() => prescriptions.getById(5)).called(1);
      verify(() => animalLoader.loadById(77)).called(1);
    });

    testWidgets('?animalId= loads the preset animal through the loader', (tester) async {
      await open(tester, AppRoutes.prescriptionEditForAnimalPath(77));

      expect(tester.widget<PrescriptionEditScreen>(find.byType(PrescriptionEditScreen)).animalId, 77);
      verify(() => animalLoader.loadById(77)).called(1);
    });
  });

  group('/doc-viewer', () {
    testWidgets('kind + id in the query resolve to the animal card fetcher', (tester) async {
      await open(
        tester,
        AppRoutes.docViewerPath(DocKind.animalCard, 42, title: 'Животное 42', fileName: 'animal_42.pdf'),
      );

      final screen = tester.widget<DocViewerScreen>(find.byType(DocViewerScreen));
      expect(screen.title, 'Животное 42');
      expect(screen.fileName, 'animal_42.pdf');
      // The cubit started the fetch the DI-resolved fetcher performs.
      expect(animalService.requested, [42]);
    });

    testWidgets('an unknown kind or a missing id shows the error screen', (tester) async {
      await open(tester, '${AppRoutes.docViewer}?kind=nope&id=1');
      expect(find.byType(RouteErrorScreen), findsOneWidget);
      expect(find.byType(DocViewerScreen), findsNothing);
    });

    testWidgets('a bare /doc-viewer shows the error screen', (tester) async {
      await open(tester, AppRoutes.docViewer);
      expect(find.byType(RouteErrorScreen), findsOneWidget);
    });
  });

  group('/pick-shelter', () {
    testWidgets('without extra the screen loads the shelter list itself', (tester) async {
      await open(tester, AppRoutes.pickShelterPath(autoSelectSingle: false));

      final screen = tester.widget<PickShelterScreen>(find.byType(PickShelterScreen));
      expect(screen.autoSelectSingle, isFalse);
      expect(screen.shelterList, isNull);
      verify(() => auth.getShelterList()).called(1);
      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
    });

    testWidgets('autoSelectSingle defaults to true', (tester) async {
      await open(tester, AppRoutes.pickShelter);

      expect(tester.widget<PickShelterScreen>(find.byType(PickShelterScreen)).autoSelectSingle, isTrue);
    });

    testWidgets('the cached list in extra is used without a request', (tester) async {
      await open(tester, AppRoutes.pickShelterPath(autoSelectSingle: false), extra: const [_alpha]);

      expect(tester.widget<PickShelterScreen>(find.byType(PickShelterScreen)).shelterList, const [_alpha]);
      verifyNever(() => auth.getShelterList());
    });
  });

  group('/search-spec', () {
    testWidgets('without a parent searches the top level', (tester) async {
      await open(tester, AppRoutes.searchSpecPath());

      expect(tester.widget<SearchScreen>(find.byType(SearchScreen)).parentId, isNull);
      verify(
        () => animals.listSpecies(level: 1, parentId: null, search: null, offset: 0, shelterId: 50),
      ).called(greaterThan(0));
    });

    testWidgets('parentId + parentLevel in the query scope the search to the parent', (tester) async {
      await open(tester, AppRoutes.searchSpecPath(parent: const AnimalSpecies(id: 3, name: 'Кошки', level: 1)));

      final screen = tester.widget<SearchScreen>(find.byType(SearchScreen));
      expect(screen.parentId, 3);
      expect(screen.parentLevel, 1);
      verify(
        () => animals.listSpecies(level: 2, parentId: 3, search: null, offset: 0, shelterId: 50),
      ).called(greaterThan(0));
    });
  });

  // Every screen reachable by URL renders at each window class without an
  // overflow or an exception: narrow phone, phone in landscape, tablet in
  // portrait (medium), small laptop (expanded), desktop (large).
  group('every breakpoint', () {
    const sizes = <String, Size>{
      'compact 360x780': Size(360, 780),
      'compact landscape 780x360': Size(780, 360),
      'medium 700x1000': Size(700, 1000),
      'expanded 1000x800': Size(1000, 800),
      'large 1440x900': Size(1440, 900),
    };
    final locations = <String, (String, Type)>{
      'new comment': (AppRoutes.commentEditPath(7), CommentEditScreen),
      'prescription edit': ('${AppRoutes.prescriptionEdit}?id=5', PrescriptionEditScreen),
      'pick shelter': (AppRoutes.pickShelterPath(autoSelectSingle: false), PickShelterScreen),
      'species search': (AppRoutes.searchSpecPath(), SearchScreen),
    };

    for (final screen in locations.entries) {
      for (final size in sizes.entries) {
        testWidgets('${screen.key} at ${size.key}', (tester) async {
          await open(tester, screen.value.$1, size: size.value);
          await tester.pump(const Duration(milliseconds: 300));

          expect(tester.takeException(), isNull);
          expect(find.byType(screen.value.$2), findsOneWidget);
        });
      }

      // Largest system font on the narrowest phone: the hardest case for overflow.
      testWidgets('${screen.key} at compact 360x780 with text scale 2', (tester) async {
        await open(tester, screen.value.$1, size: const Size(360, 780), textScale: 2);
        await tester.pump(const Duration(milliseconds: 300));

        expect(tester.takeException(), isNull);
        expect(find.byType(screen.value.$2), findsOneWidget);
      });
    }
  });
}
