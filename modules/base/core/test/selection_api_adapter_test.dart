// Parity spike for the config endpoint group (values-for-selection + attributes).
//
// values-for-selection goes through the raw Dio (the app reads arbitrary groups
// off the whole decoded body); attributes map onto the typed AnimalsClient.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:core/api.dart';
import 'package:core/api/src/selection_client_barrel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubHttpAdapter implements HttpClientAdapter {
  _StubHttpAdapter(this._body);

  final Map<String, dynamic> _body;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
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
  List<AnimalAttribute> attributes = const [];
  int? lastShelterId;

  @override
  Future<List<AnimalAttribute>> v1AnimalsAttributesList({
    int? xCurrentShelter,
    bool? isRequired,
    String? ordering,
  }) async {
    lastShelterId = xCurrentShelter;
    return attributes;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError('${invocation.memberName} unused');
}

Map<String, dynamic> _selectionJson() => {
  'animal_status': [
    {'value': 'IN_THE_SHELTER', 'display_name': 'В приюте'},
    {'value': 'RELEASED', 'display_name': 'Выпущено'},
  ],
  'prescription_types': [
    {'value': 'VACCINATION', 'display_name': 'Вакцинация'},
  ],
};

void main() {
  test('valuesForSelection returns the whole decoded body verbatim + shelter header', () async {
    final stub = _StubHttpAdapter(_selectionJson());
    final dio = Dio(BaseOptions(baseUrl: 'https://api.acits.ru'))..httpClientAdapter = stub;
    final adapter = SelectionApiAdapter(dio, _FakeAnimalsClient());

    final dto = await adapter.valuesForSelection(shelterId: 50);

    expect(dto.values.keys, containsAll(<String>['animal_status', 'prescription_types']));
    final statuses = dto.values['animal_status'] as List<dynamic>;
    expect(statuses.first['value'], 'IN_THE_SHELTER');
    expect(statuses.first['display_name'], 'В приюте');
    expect(stub.lastRequest!.headers['x-current-shelter'], 50);
  });

  test('animalAttributes maps the catalog entries and passes the shelter', () async {
    final animals = _FakeAnimalsClient()
      ..attributes = const [
        AnimalAttribute(id: 1, name: 'sex', isRequired: true),
        AnimalAttribute(id: 2, name: 'color'),
      ];
    final dio = Dio(BaseOptions(baseUrl: 'https://api.acits.ru'));
    final adapter = SelectionApiAdapter(dio, animals);

    final list = await adapter.animalAttributes(shelterId: 50);

    expect(list, hasLength(2));
    expect(list.first.id, 1);
    expect(list.first.name, 'sex');
    expect(list.first.isRequired, isTrue);
    expect(list[1].isRequired, isNull);
    expect(animals.lastShelterId, 50);
  });
}
