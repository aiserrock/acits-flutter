import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prescriptions/prescriptions.dart';

class MockPrescriptionService extends Mock implements PrescriptionService {}

class MockRouter extends Mock implements PrescriptionsRouterService {}

class MockAnimalLoader extends Mock implements PrescriptionAnimalLoader {}

class MockTypeLabels extends Mock implements PrescriptionTypeLabels {}

void main() {
  late MockPrescriptionService service;
  late MockRouter router;
  late MockAnimalLoader animalLoader;
  late MockTypeLabels typeLabels;
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  PrescriptionEditCubit build({PrescriptionAnimalRef? initAnimal, int? initAnimalId}) => PrescriptionEditCubit(
    service,
    router,
    animalLoader,
    typeLabels,
    messengerKey,
    initAnimal: initAnimal,
    initAnimalId: initAnimalId,
  );

  setUp(() {
    service = MockPrescriptionService();
    router = MockRouter();
    animalLoader = MockAnimalLoader();
    typeLabels = MockTypeLabels();
    when(() => typeLabels.nameForWire(any())).thenReturn('Тип');
  });

  test('preset animal is loaded via the animal-loader port on creation', () async {
    when(
      () => animalLoader.loadById(777),
    ).thenAnswer((_) async => const PrescriptionAnimalRef(id: 777, name: 'Барсик'));

    final cubit = build(initAnimalId: 777);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.animal?.id, 777);
    expect(cubit.state.animal?.name, 'Барсик');
    verify(() => animalLoader.loadById(777)).called(1);
  });

  test('getTabs maps types through the type-labels port', () {
    when(() => typeLabels.nameForWire('COURSE_OF_TREATMENT')).thenReturn('Курс лечения');

    final cubit = build();

    expect(cubit.getTabs(), isNotEmpty);
    expect(cubit.getTabs().first, 'Курс лечения');
  });

  test('onAnimalPressed stores the ref picked via the router port (create mode)', () async {
    when(() => router.pickAnimal()).thenAnswer((_) async => const PrescriptionAnimalRef(id: 9, name: 'Рекс'));

    final cubit = build();
    cubit.onAnimalPressed(_FakeContext());
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.animal?.id, 9);
    verify(() => router.pickAnimal()).called(1);
  });
}

/// onAnimalPressed в режиме создания не использует context (навигация через
/// router-порт), поэтому достаточно пустой заглушки.
class _FakeContext extends Fake implements BuildContext {}
