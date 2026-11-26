// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animals_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: type=lint
// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _AnimalsClient extends AnimalsClient {
  _AnimalsClient._(this._dio, Dio _transport, {this.baseUrl, this.errorLogger})
    : super._(_transport);

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<PaginatedAnimalReadList> v1AnimalsList({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'offset': offset,
      r'ordering': ordering,
      r'search': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedAnimalReadList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedAnimalReadList _value;
    try {
      _value = PaginatedAnimalReadList.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalRead> v1AnimalsCreate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    int? xCurrentShelter = 2,
    required AnimalWrite body,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'Content-Type': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<AnimalRead>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/animals/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalRead _value;
    try {
      _value = AnimalRead.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalRead> v1AnimalsRetrieve({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required String id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AnimalRead>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalRead _value;
    try {
      _value = AnimalRead.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalRead> v1AnimalsUpdate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required String id,
    int? xCurrentShelter = 2,
    required AnimalWrite body,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'Content-Type': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<AnimalRead>(
      Options(
            method: 'PUT',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/animals/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalRead _value;
    try {
      _value = AnimalRead.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> v1AnimalsDestroy({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required String id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'DELETE', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<Status> v1AnimalsPrimaryImageUpdate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required String id,
    required String imagePk,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Status>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/${id}/primary_image/${imagePk}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Status _value;
    try {
      _value = Status.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Status> v1AnimalsRestoreUpdate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required String id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Status>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/${id}/restore/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Status _value;
    try {
      _value = Status.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalAttribute> v1AnimalsAttributesRetrieve({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required int id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AnimalAttribute>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/attributes/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalAttribute _value;
    try {
      _value = AnimalAttribute.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<PaginatedAnimalNoteList> v1AnimalsNotesList({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    int? animal,
    int? limit,
    int? offset,
    String? ordering,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
      r'animal': animal,
      r'limit': limit,
      r'offset': offset,
      r'ordering': ordering,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedAnimalNoteList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/notes/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedAnimalNoteList _value;
    try {
      _value = PaginatedAnimalNoteList.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalNote> v1AnimalsNotesCreate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    int? xCurrentShelter = 2,
    required AnimalNote body,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'Content-Type': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<AnimalNote>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/animals/notes/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalNote _value;
    try {
      _value = AnimalNote.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalNote> v1AnimalsNotesRetrieve({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required int id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AnimalNote>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/notes/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalNote _value;
    try {
      _value = AnimalNote.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalNote> v1AnimalsNotesUpdate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required int id,
    int? xCurrentShelter = 2,
    required AnimalNote body,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'Content-Type': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<AnimalNote>(
      Options(
            method: 'PUT',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/animals/notes/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalNote _value;
    try {
      _value = AnimalNote.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> v1AnimalsNotesDestroy({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required int id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'DELETE', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/notes/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<Species> v1AnimalsSpeciesCreate({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    int? xCurrentShelter = 2,
    required Species body,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'Content-Type': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _options = _setStreamType<Species>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/animals/species/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Species _value;
    try {
      _value = Species.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Species> v1AnimalsSpeciesRetrieve({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required int id,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Species>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/species/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Species _value;
    try {
      _value = Species.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AnimalRead> v1ExtAnimalsRetrieve({
    Map<String, Object?> extra = const {
      "openapi.security": [
        {"cookieAuth": []},
        {"jwtAuth": []},
        {},
      ],
      "openapi.securitySchemes": {
        "cookieAuth": {"type": "apiKey", "name": "sessionid", "in": "cookie"},
        "jwtAuth": {"type": "http", "scheme": "bearer", "bearerFormat": "JWT"},
      },
    },
    CancelToken? cancelToken,
    Options? options,
    required String uuid,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AnimalRead>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/ext/animals/${uuid}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late AnimalRead _value;
    try {
      _value = AnimalRead.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
