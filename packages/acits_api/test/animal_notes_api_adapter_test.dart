// Parity spike for the animal notes endpoint group.
//
// List/delete use the typed generated client; create/patch go through the raw
// Dio (the generated write types demand server-only fields). Proves the wire
// shape maps onto OUR AnimalNoteDto and the write payload is posted flat.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:acits_api/acits_api.dart';
import 'package:acits_api/src/animal_notes_client_barrel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures/animal_notes_fixtures.dart';

class _StubHttpAdapter implements HttpClientAdapter {
  _StubHttpAdapter(this._body);

  final Map<String, dynamic> _body;
  RequestOptions? lastRequest;
  Object? lastRequestData;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    lastRequestData = options.data;
    return ResponseBody.fromString(
      jsonEncode(_body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeAnimalsClient implements AnimalsClient {
  _FakeAnimalsClient(this.page);

  final PaginatedAnimalNoteList page;
  int? lastAnimal;
  int? lastShelterId;
  String? lastOrdering;
  int? lastDeletedId;

  @override
  Future<PaginatedAnimalNoteList> v1AnimalsNotesList({
    int? xCurrentShelter,
    int? animal,
    int? limit,
    int? offset,
    String? ordering,
  }) async {
    lastAnimal = animal;
    lastShelterId = xCurrentShelter;
    lastOrdering = ordering;
    return page;
  }

  @override
  Future<void> v1AnimalsNotesDestroy({required int id, int? xCurrentShelter}) async {
    lastDeletedId = id;
    lastShelterId = xCurrentShelter;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

void main() {
  group('AnimalNotesApiAdapter — list (typed client)', () {
    test('maps notes list, unwraps results, requests newest-first', () async {
      final client = _FakeAnimalsClient(PaginatedAnimalNoteList.fromJson(animalNotesListJson()));
      final dio = Dio();
      final adapter = AnimalNotesApiAdapter(dio, client);

      final notes = await adapter.listByAnimal(501, limit: 25, shelterId: 50);

      expect(notes, hasLength(2));
      expect(notes.first.id, 5);
      expect(notes.first.content, 'Второй комментарий');
      expect(notes.first.files, hasLength(1));
      expect(notes.first.files!.single.filename, 'note5.pdf');
      expect(notes.first.isUserCanEditOrDelete, isTrue);
      expect(notes[1].files, isNull);
      expect(client.lastAnimal, 501);
      expect(client.lastShelterId, 50);
      expect(client.lastOrdering, '-created_at');
    });

    test('delete forwards id + shelter to the typed client', () async {
      final client = _FakeAnimalsClient(PaginatedAnimalNoteList.fromJson(animalNotesListJson()));
      final adapter = AnimalNotesApiAdapter(Dio(), client);

      await adapter.delete(5, shelterId: 50);

      expect(client.lastDeletedId, 5);
      expect(client.lastShelterId, 50);
    });
  });

  group('AnimalNotesApiAdapter — create (raw Dio)', () {
    test('posts the flat write payload and parses the created note', () async {
      final stub = _StubHttpAdapter(createdAnimalNoteJson());
      final dio = Dio(BaseOptions(baseUrl: 'https://api.acits.ru'));
      dio.httpClientAdapter = stub;
      final client = _FakeAnimalsClient(PaginatedAnimalNoteList.fromJson(animalNotesListJson()));
      final adapter = AnimalNotesApiAdapter(dio, client);

      final note = await adapter.create(
        const AnimalNoteWriteDto(
          animal: 501,
          content: 'Новый комментарий',
          files: [AnimalNoteFileWriteDto(name: 'f', file: 'data:application/pdf;base64,AAA')],
        ),
        shelterId: 50,
      );

      expect(note.id, 6);
      expect(note.content, 'Новый комментарий');
      expect(stub.lastRequest!.method, 'POST');
      expect(stub.lastRequest!.headers['x-current-shelter'], 50);
      final sent = stub.lastRequestData as Map<String, dynamic>;
      expect(sent['animal'], 501);
      expect(sent['content'], 'Новый комментарий');
      expect((sent['files'] as List).single['file'], 'data:application/pdf;base64,AAA');
      // id опущен на create (includeIfNull: false).
      expect(sent.containsKey('id'), isFalse);
    });
  });
}
