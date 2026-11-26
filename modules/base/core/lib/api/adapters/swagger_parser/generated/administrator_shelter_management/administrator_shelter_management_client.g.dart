// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrator_shelter_management_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: type=lint
// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _AdministratorShelterManagementClient
    extends AdministratorShelterManagementClient {
  _AdministratorShelterManagementClient._(
    this._dio,
    Dio _transport, {
    this.baseUrl,
    this.errorLogger,
  }) : super._(_transport);

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<PaginatedUserSheltersAdminSerializersList> v1ShelterWorkersList({
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
    bool? isVerifiedByAdmin,
    bool? isVerifiedByAdminIsnull,
    int? limit,
    int? offset,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
      r'is_verified_by_admin': isVerifiedByAdmin,
      r'is_verified_by_admin__isnull': isVerifiedByAdminIsnull,
      r'limit': limit,
      r'offset': offset,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedUserSheltersAdminSerializersList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelter/workers/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedUserSheltersAdminSerializersList _value;
    try {
      _value = PaginatedUserSheltersAdminSerializersList.fromJson(
        _result.data!,
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserSheltersAdminSerializers> v1ShelterWorkersCreate({
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
    required UserSheltersAdminSerializers body,
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
    final _options = _setStreamType<UserSheltersAdminSerializers>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/shelter/workers/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserSheltersAdminSerializers _value;
    try {
      _value = UserSheltersAdminSerializers.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserSheltersAdminSerializers> v1ShelterWorkersRetrieve({
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
    final _options = _setStreamType<UserSheltersAdminSerializers>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelter/workers/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserSheltersAdminSerializers _value;
    try {
      _value = UserSheltersAdminSerializers.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserSheltersAdminSerializers> v1ShelterWorkersUpdate({
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
    required UserSheltersAdminSerializers body,
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
    final _options = _setStreamType<UserSheltersAdminSerializers>(
      Options(
            method: 'PUT',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/shelter/workers/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserSheltersAdminSerializers _value;
    try {
      _value = UserSheltersAdminSerializers.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> v1ShelterWorkersDestroy({
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
            '/api/v1/shelter/workers/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<Approve> v1ShelterWorkersApproveUpdate({
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
    final _options = _setStreamType<Approve>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelter/workers/${id}/approve/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Approve _value;
    try {
      _value = Approve.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Decline> v1ShelterWorkersDeclineUpdate({
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
    final _options = _setStreamType<Decline>(
      Options(method: 'PUT', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelter/workers/${id}/decline/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Decline _value;
    try {
      _value = Decline.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ShelterSerializers> v1SheltersRetrieve({
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
    final _options = _setStreamType<ShelterSerializers>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelters/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ShelterSerializers _value;
    try {
      _value = ShelterSerializers.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ShelterSerializers> v1SheltersUpdate({
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
    required ShelterSerializers body,
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
    final _options = _setStreamType<ShelterSerializers>(
      Options(
            method: 'PUT',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/shelters/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late ShelterSerializers _value;
    try {
      _value = ShelterSerializers.fromJson(_result.data!);
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
