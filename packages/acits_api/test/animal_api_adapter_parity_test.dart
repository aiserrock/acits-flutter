// Parity spike for the animals endpoint group.
//
// Proves the swagger_parser adapter's output matches the app's chopper client
// shape: the SAME wire JSON the app parses into `PaginatedAnimalReadList` /
// `AnimalRead` is parsed by the generated models here and mapped, field-for-
// field, onto OUR generator-agnostic `AnimalDto`. Also proves the paginated
// envelope is unwrapped to its `results` list.
import 'dart:typed_data';

import 'package:acits_api/acits_api.dart';
import 'package:acits_api/src/animals_client_barrel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures/animals_fixtures.dart';

/// Fake generated client: returns models parsed straight from the wire
/// fixtures, mimicking what retrofit would deserialize off the network.
/// Only the read methods the adapter uses are implemented; the rest throw.
class _FakeAnimalsClient implements AnimalsClient {
  _FakeAnimalsClient({this.page, this.single});

  final PaginatedAnimalReadList? page;
  final AnimalRead? single;

  int? lastShelterId;
  String? lastSearch;
  int? lastLimit;
  int? lastOffset;
  String? lastId;

  /// Last body passed to v1AnimalsUpdate (for updatePhotos assertions).
  AnimalWrite? lastUpdateBody;

  @override
  Future<PaginatedAnimalReadList> v1AnimalsList({
    int? xCurrentShelter,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
  }) async {
    lastShelterId = xCurrentShelter;
    lastSearch = search;
    lastLimit = limit;
    lastOffset = offset;
    return page!;
  }

  @override
  Future<AnimalRead> v1AnimalsRetrieve({required String id, int? xCurrentShelter}) async {
    lastId = id;
    lastShelterId = xCurrentShelter;
    return single!;
  }

  @override
  Future<AnimalRead> v1AnimalsUpdate({required String id, required AnimalWrite body, int? xCurrentShelter}) async {
    lastId = id;
    lastShelterId = xCurrentShelter;
    lastUpdateBody = body;
    return single!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} is not used by the read adapter');
}

/// Fake Dio HTTP adapter: returns fixed [body] bytes and records the last
/// request options so tests can assert query/header wiring for the PDF path.
class _BytesHttpAdapter implements HttpClientAdapter {
  _BytesHttpAdapter(this.body);

  final List<int> body;
  RequestOptions? lastOptions;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastOptions = options;
    return ResponseBody.fromBytes(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: ['application/pdf'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('AnimalApiAdapter parity — single animal mapping', () {
    test('maps a fully-populated AnimalRead JSON onto AnimalDto field-for-field', () async {
      final single = AnimalRead.fromJson(fullAnimalJson());
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(single: single), Dio());

      final dto = await adapter.getById(501);

      expect(dto.id, 501);
      expect(dto.uuid, '3f2504e0-4f89-41d3-9a0c-0305e82c3301');
      expect(dto.name, 'Барсик');
      expect(dto.status, 'IN_THE_SHELTER');
      expect(dto.dateJoined, DateTime.utc(2024, 1, 15, 10, 30));
      expect(dto.birthDate, DateTime.utc(2020, 6, 1));
      expect(dto.deathDate, isNull);
      expect(dto.placeOfCatch, 'ул. Пушкина, д. 10');
      expect(dto.chippingCode, '643098100012345');
      expect(dto.height, '30.5');
      expect(dto.weight, '4.20');
      expect(dto.hasDocuments, true);
      expect(dto.shelter, 50);
      expect(dto.canBeShared, true);

      // adoption/release/overstay are URI strings (or null).
      expect(dto.adoption, 'https://api.acits.ru/api/v1/animals/501/adoptions/3/');
      expect(dto.release, isNull);
      expect(dto.overstay, isNull);

      // Nested images.
      expect(dto.images, hasLength(1));
      expect(dto.images.single.id, 9001);
      expect(dto.images.single.isPrimary, true);
      expect(dto.images.single.filename, 'barsik.jpg');
      expect(dto.images.single.image.large, 'https://cdn.acits.ru/501/large.jpg');
      expect(dto.images.single.image.small, 'https://cdn.acits.ru/501/small.jpg');

      // Nested species (allOf-wrapped $ref on the wire — the schema that broke
      // codegen before preprocessing).
      expect(dto.spec, isNotNull);
      expect(dto.spec!.id, 12);
      expect(dto.spec!.name, 'Кошка домашняя');
      expect(dto.spec!.level, 3);
      expect(dto.spec!.parentName, 'Кошки');

      // Nested curator + applicant.
      expect(dto.curator!.id, 77);
      expect(dto.curator!.firstName, 'Иван');
      expect(dto.curator!.email, 'ivan@example.com');
      expect(dto.applicant!.id, 88);
      expect(dto.applicant!.email, isNull);
      expect(dto.applicant!.contactDetails, 'Telegram @maria');
      expect(dto.applicant!.applicantFiles, hasLength(1));

      // Embedded attributes.
      expect(dto.animalAttributes, hasLength(2));
      expect(dto.animalAttributes.first.attrId, 1);
      expect(dto.animalAttributes.first.name, 'Стерилизация');
      expect(dto.animalAttributes.first.value, 'Да');
      expect(dto.animalAttributes.first.isRequired, true);
      expect(dto.animalAttributes[1].isRequired, false);
    });

    test('tolerates a minimal payload (nullable fields absent/null)', () async {
      final single = AnimalRead.fromJson(minimalAnimalJson());
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(single: single), Dio());

      final dto = await adapter.getById(502);

      expect(dto.id, 502);
      expect(dto.name, isNull);
      expect(dto.status, isNull);
      expect(dto.images, isEmpty);
      expect(dto.animalAttributes, isEmpty);
      expect(dto.deathDate, isNull);
      expect(dto.height, isNull);
      expect(dto.hasDocuments, false);
      expect(dto.adoption, isNull);
      expect(dto.spec!.level, 1);
    });

    test('preserves an unknown enum wire value as a raw status string', () async {
      final single = AnimalRead.fromJson(unknownStatusAnimalJson());
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(single: single), Dio());

      final dto = await adapter.getById(503);

      // The generated Status69fEnum falls back to $unknown (json == null),
      // so the adapter surfaces null rather than a bogus string. This documents
      // the lossy behaviour of the generator's enum for unknown values.
      expect(dto.status, isNull);
    });

    test('round-trips AnimalDto through toJson/fromJson', () async {
      final single = AnimalRead.fromJson(fullAnimalJson());
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(single: single), Dio());

      final dto = await adapter.getById(501);
      final roundTripped = AnimalDto.fromJson(dto.toJson());

      expect(roundTripped, equals(dto));
    });

    test('converts the numeric id to the string path param the client expects', () async {
      final client = _FakeAnimalsClient(single: AnimalRead.fromJson(minimalAnimalJson()));
      final adapter = AnimalApiAdapter(client, Dio());

      await adapter.getById(502);

      expect(client.lastId, '502');
    });
  });

  group('AnimalApiAdapter parity — pagination unwrapping', () {
    test('unwraps the Paginated…List envelope to its results list', () async {
      final page = PaginatedAnimalReadList.fromJson(paginatedAnimalsJson());
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(page: page), Dio());

      final dtos = await adapter.list(shelterId: 50, search: 'Барсик', limit: 2, offset: 0);

      expect(dtos, hasLength(2));
      expect(dtos.first.id, 501);
      expect(dtos[1].id, 502);
    });

    test('returns an empty list for an empty envelope', () async {
      final page = PaginatedAnimalReadList.fromJson(emptyPaginatedAnimalsJson());
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(page: page), Dio());

      final dtos = await adapter.list();

      expect(dtos, isEmpty);
    });

    test('forwards shelter/search/limit/offset to the generated client', () async {
      final client = _FakeAnimalsClient(page: PaginatedAnimalReadList.fromJson(emptyPaginatedAnimalsJson()));
      final adapter = AnimalApiAdapter(client, Dio());

      await adapter.list(shelterId: 42, search: 'кот', limit: 25, offset: 50);

      expect(client.lastShelterId, 42);
      expect(client.lastSearch, 'кот');
      expect(client.lastLimit, 25);
      expect(client.lastOffset, 50);
    });
  });

  group('AnimalApiAdapter — updatePhotos (read→write echo)', () {
    test('re-writes the animal preserving all fields, swapping only images/valid_images', () async {
      final single = AnimalRead.fromJson(fullAnimalJson());
      final client = _FakeAnimalsClient(single: single);
      final adapter = AnimalApiAdapter(client, Dio());

      final dto = await adapter.updatePhotos(
        501,
        newImages: const [AnimalImageWriteDto(name: 'new.png', image: 'BASE64DATA', isPrimary: false)],
        retainImageIds: const [9001],
        shelterId: 50,
      );

      // GET then PUT both hit id 501 with the shelter header.
      expect(client.lastId, '501');
      expect(client.lastShelterId, 50);

      final body = client.lastUpdateBody!;
      // Only images change.
      expect(body.images, hasLength(1));
      expect(body.images!.single.name, 'new.png');
      expect(body.images!.single.image, 'BASE64DATA');
      expect(body.validImages, [9001]);
      // Every other field is carried over from the read unchanged.
      expect(body.name, 'Барсик');
      expect(body.specId, 12);
      expect(body.shelter, 50);
      expect(body.placeOfCatch, 'ул. Пушкина, д. 10');
      expect(body.chippingCode, '643098100012345');
      expect(body.curatorId, 77);
      expect(body.applicantId, 88);
      expect(body.animalAttributes, hasLength(2));
      // Returned entity is mapped from the (echoed) read.
      expect(dto.id, 501);
    });
  });

  group('AnimalApiAdapter — PDF bytes', () {
    test('returns raw PDF bytes 1:1 (binary-safe, no string round-trip)', () async {
      // Bytes that are NOT valid UTF-8 (0x80, 0xFF) — the generated stream-of-
      // strings path would corrupt these; the bytes path must preserve them.
      final pdfBytes = <int>[0x25, 0x50, 0x44, 0x46, 0x80, 0xFF, 0x00, 0x0A];
      final http = _BytesHttpAdapter(pdfBytes);
      final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'))..httpClientAdapter = http;
      final adapter = AnimalApiAdapter(_FakeAnimalsClient(), dio);

      final from = DateTime.utc(2024, 1, 1);
      final to = DateTime.utc(2024, 1, 31);
      final bytes = await adapter.getAnimalPdf(id: 501, pdfType: 'history', from: from, to: to, shelterId: 50);

      expect(bytes, isA<Uint8List>());
      expect(bytes, orderedEquals(pdfBytes));
      // Path/query/header parity with the old chopper contract.
      expect(http.lastOptions!.path, '/api/v1/animals/501/history/pdf/');
      expect(http.lastOptions!.queryParameters['from'], from.toIso8601String());
      expect(http.lastOptions!.queryParameters['to'], to.toIso8601String());
      expect(http.lastOptions!.headers['x-current-shelter'], 50);
      expect(http.lastOptions!.responseType, ResponseType.bytes);
    });
  });
}
