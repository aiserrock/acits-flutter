import 'package:acits_core/acits_core.dart';
import 'package:animals/animals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media/media.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AnimalRepository {}

class _MockShelter extends Mock implements CurrentShelterProvider {}

Animal _animalWithImages() => const Animal(
  id: 501,
  name: 'Барсик',
  shelterId: 50,
  status: AnimalStatus.inTheShelter,
  images: [
    AnimalImage(id: 9001, small: 's1', isPrimary: true),
    AnimalImage(id: 9002, small: 's2'),
  ],
  attributes: {},
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockRepo repo;
  late _MockShelter shelter;

  setUp(() {
    repo = _MockRepo();
    shelter = _MockShelter();
    when(() => shelter.shelterId).thenReturn(50);
    when(
      () => repo.getById(any(), shelterId: any(named: 'shelterId')),
    ).thenAnswer((_) async => Ok(_animalWithImages()));
  });

  test('init loads existing images as chosen gallery items', () async {
    final cubit = PhotoGalleryCubit(repo, shelter, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final items = cubit.state.data.valueOrNull!;
    // 2 network images (chosen) + preset avatars (not chosen).
    final network = items.where((e) => e.network != null).toList();
    expect(network, hasLength(2));
    expect(network.every((e) => e.isChoosed), isTrue);
    expect(cubit.choosedCount, 2);
    await cubit.close();
  });

  test('submit retains chosen network image ids and adds no new images', () async {
    when(
      () => repo.updatePhotos(
        any(),
        newImages: any(named: 'newImages'),
        retainImageIds: any(named: 'retainImageIds'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => Ok(_animalWithImages()));

    final cubit = PhotoGalleryCubit(repo, shelter, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final ok = await cubit.submit();

    expect(ok, isTrue);
    final captured = verify(
      () => repo.updatePhotos(
        501,
        newImages: captureAny(named: 'newImages'),
        retainImageIds: captureAny(named: 'retainImageIds'),
        shelterId: 50,
      ),
    ).captured;
    final newImages = captured[0] as List<AnimalImageInput>;
    final retainIds = captured[1] as List<int>;
    expect(newImages, isEmpty);
    expect(retainIds, [9001, 9002]);
    await cubit.close();
  });

  test('submit surfaces repository failure as error state', () async {
    when(
      () => repo.updatePhotos(
        any(),
        newImages: any(named: 'newImages'),
        retainImageIds: any(named: 'retainImageIds'),
        shelterId: any(named: 'shelterId'),
      ),
    ).thenAnswer((_) async => const Err(NoInternet()));

    final cubit = PhotoGalleryCubit(repo, shelter, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final ok = await cubit.submit();

    expect(ok, isFalse);
    expect(cubit.state.data.hasError, isTrue);
    await cubit.close();
  });
}
