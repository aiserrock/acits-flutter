import 'dart:typed_data';

import 'package:acits_api/acits_api.dart';
import 'package:base/base.dart';
import 'package:animals/animals.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:mocktail/mocktail.dart';

import '../fixtures/animal_dto_fixtures.dart';

class _MockAnimalApiPort extends Mock implements AnimalApiPort {}

DioException _dio(DioExceptionType type, {int? status}) {
  final req = RequestOptions(path: '/api/v1/animals/');
  return DioException(
    requestOptions: req,
    type: type,
    response: status == null ? null : Response(requestOptions: req, statusCode: status),
  );
}

void main() {
  late _MockAnimalApiPort port;
  late AnimalRepositoryImpl repo;

  setUpAll(() {
    registerFallbackValue(
      AnimalWriteDto(
        specId: 0,
        dateJoined: DateTime.utc(2024),
        placeOfCatch: '',
        shelter: 0,
        animalAttributes: const [],
      ),
    );
  });

  setUp(() {
    port = _MockAnimalApiPort();
    repo = AnimalRepositoryImpl(AnimalRemoteDataSource(port));
  });

  group('list', () {
    test('success → Ok(list of AnimalListItem), never DTOs', () async {
      when(
        () => port.list(
          shelterId: any(named: 'shelterId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => [fullAnimalDto(), minimalAnimalDto()]);

      final result = await repo.list(shelterId: 50);

      expect(result, isA<Ok<Failure, List<AnimalListItem>>>());
      final value = result.valueOrNull!;
      expect(value, hasLength(2));
      expect(value.first, isA<AnimalListItem>());
      // DTO containment: the returned element is the domain type, not the DTO.
      expect(value.first, isNot(isA<AnimalDto>()));
      expect(value.first.name, 'Барсик');
    });

    test('DioException badResponse 404 → Err(ServerFailure(404))', () async {
      when(
        () => port.list(
          shelterId: any(named: 'shelterId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(_dio(DioExceptionType.badResponse, status: 404));

      final result = await repo.list();

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, const ServerFailure(404));
    });

    test('receiveTimeout → Err(Timeout)', () async {
      when(
        () => port.list(
          shelterId: any(named: 'shelterId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(_dio(DioExceptionType.receiveTimeout));

      final result = await repo.list();
      expect(result.failureOrNull, isA<Timeout>());
    });

    test('connectionError → Err(NoInternet)', () async {
      when(
        () => port.list(
          shelterId: any(named: 'shelterId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(_dio(DioExceptionType.connectionError));

      final result = await repo.list();
      expect(result.failureOrNull, isA<NoInternet>());
    });

    test('FormatException → Err(ParseFailure)', () async {
      when(
        () => port.list(
          shelterId: any(named: 'shelterId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(const FormatException('bad json'));

      final result = await repo.list();
      expect(result.failureOrNull, isA<ParseFailure>());
    });

    test('unexpected error → Err(UnknownFailure)', () async {
      when(
        () => port.list(
          shelterId: any(named: 'shelterId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        ),
      ).thenThrow(StateError('boom'));

      final result = await repo.list();
      expect(result.failureOrNull, isA<UnknownFailure>());
    });
  });

  group('getById', () {
    test('success → Ok(Animal)', () async {
      when(() => port.getById(501, shelterId: any(named: 'shelterId'))).thenAnswer((_) async => fullAnimalDto());

      final result = await repo.getById(501, shelterId: 50);

      expect(result.valueOrNull, isA<Animal>());
      expect(result.valueOrNull!.id, 501);
      expect(result.valueOrNull, isNot(isA<AnimalDto>()));
    });

    test('403 → Err(AuthFailure)', () async {
      when(
        () => port.getById(any(), shelterId: any(named: 'shelterId')),
      ).thenThrow(_dio(DioExceptionType.badResponse, status: 403));

      final result = await repo.getById(501);
      expect(result.failureOrNull, isA<AuthFailure>());
    });
  });

  group('delete', () {
    test('success → Ok(void)', () async {
      when(() => port.delete(501, shelterId: any(named: 'shelterId'))).thenAnswer((_) async {});

      final result = await repo.delete(501);
      expect(result.isOk, isTrue);
    });

    test('500 → Err(ServerFailure(500))', () async {
      when(
        () => port.delete(any(), shelterId: any(named: 'shelterId')),
      ).thenThrow(_dio(DioExceptionType.badResponse, status: 500));

      final result = await repo.delete(501);
      expect(result.failureOrNull, const ServerFailure(500));
    });
  });

  group('create / update', () {
    final animal = _editAnimal();

    test('create success maps write inputs and returns Animal', () async {
      when(() => port.create(any(), shelterId: any(named: 'shelterId'))).thenAnswer((_) async => fullAnimalDto());

      final result = await repo.create(
        animal,
        attributes: const [AnimalAttributeInput(attrId: 1, name: 'sex', value: 'Самец', isRequired: true)],
        newImages: const [AnimalImageInput(name: 'p.jpg', image: 'base64==', isPrimary: true)],
        shelterId: 50,
      );

      expect(result.valueOrNull, isA<Animal>());
      final captured = verify(() => port.create(captureAny(), shelterId: 50)).captured.single as AnimalWriteDto;
      expect(captured.specId, 12);
      expect(captured.placeOfCatch, 'ул. Пушкина, д. 10');
      expect(captured.shelter, 50);
      expect(captured.status, 'IN_THE_SHELTER');
      expect(captured.animalAttributes.single.attrId, 1);
      expect(captured.images!.single.image, 'base64==');
    });

    test('update success returns Ok(Animal)', () async {
      when(
        () => port.update(any(), any(), shelterId: any(named: 'shelterId')),
      ).thenAnswer((_) async => fullAnimalDto());

      final result = await repo.update(501, animal, attributes: const [], retainImageIds: const [9001], shelterId: 50);

      expect(result.valueOrNull, isA<Animal>());
      final captured = verify(() => port.update(501, captureAny(), shelterId: 50)).captured.single as AnimalWriteDto;
      expect(captured.validImages, [9001]);
    });
  });

  group('listSpecies', () {
    test('success → Ok(list of AnimalSpecies)', () async {
      when(
        () => port.listSpecies(
          level: any(named: 'level'),
          parentId: any(named: 'parentId'),
          search: any(named: 'search'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => const [SpeciesDto(id: 3, name: 'Кошки', level: 2)]);

      final result = await repo.listSpecies(level: 2);

      expect(result.valueOrNull, isA<List<AnimalSpecies>>());
      expect(result.valueOrNull!.single.name, 'Кошки');
      expect(result.valueOrNull!.single, isNot(isA<SpeciesDto>()));
    });
  });

  group('getAnimalPdf', () {
    test('success → Ok(bytes) forwarding args to the port', () async {
      final bytes = Uint8List.fromList([0x25, 0x50, 0x44, 0x46]);
      final from = DateTime.utc(2024, 1, 1);
      final to = DateTime.utc(2024, 1, 31);
      when(
        () => port.getAnimalPdf(
          id: any(named: 'id'),
          pdfType: any(named: 'pdfType'),
          from: any(named: 'from'),
          to: any(named: 'to'),
          tz: any(named: 'tz'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => bytes);

      final result = await repo.getAnimalPdf(id: 501, pdfType: 'history', from: from, to: to, shelterId: 50);

      expect(result.valueOrNull, bytes);
      verify(
        () => port.getAnimalPdf(id: 501, pdfType: 'history', from: from, to: to, tz: null, shelterId: 50),
      ).called(1);
    });

    test('DioException 404 → Err(ServerFailure(404))', () async {
      when(
        () => port.getAnimalPdf(
          id: any(named: 'id'),
          pdfType: any(named: 'pdfType'),
          from: any(named: 'from'),
          to: any(named: 'to'),
          tz: any(named: 'tz'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenThrow(_dio(DioExceptionType.badResponse, status: 404));

      final result = await repo.getAnimalPdf(
        id: 1,
        pdfType: 'history',
        from: DateTime.utc(2024),
        to: DateTime.utc(2024),
      );

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, isA<ServerFailure>());
    });
  });

  group('updatePhotos', () {
    test('success → Ok(Animal) mapping image inputs to write DTOs', () async {
      when(
        () => port.updatePhotos(
          any(),
          newImages: any(named: 'newImages'),
          retainImageIds: any(named: 'retainImageIds'),
          shelterId: any(named: 'shelterId'),
        ),
      ).thenAnswer((_) async => fullAnimalDto());

      final result = await repo.updatePhotos(
        501,
        newImages: const [AnimalImageInput(name: 'new.png', image: 'B64', isPrimary: false)],
        retainImageIds: const [9001],
        shelterId: 50,
      );

      expect(result.valueOrNull, isA<Animal>());
      final captured = verify(
        () => port.updatePhotos(
          501,
          newImages: captureAny(named: 'newImages'),
          retainImageIds: [9001],
          shelterId: 50,
        ),
      ).captured;
      final sentImages = captured.single as List<AnimalImageWriteDto>;
      expect(sentImages.single.name, 'new.png');
      expect(sentImages.single.image, 'B64');
    });
  });
}

/// Домен Animal с полями, достаточными для write-маппера (specId/placeOfCatch/
/// dateJoined/shelter обязательны на запись).
Animal _editAnimal() => Animal(
  id: 501,
  name: 'Барсик',
  shelterId: 50,
  status: AnimalStatus.inTheShelter,
  images: const [],
  attributes: const {},
  speciesId: 12,
  dateJoined: DateTime.utc(2024, 1, 15),
  placeOfCatch: 'ул. Пушкина, д. 10',
  canBeShared: true,
);
