// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelters_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: type=lint
// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _SheltersClient extends SheltersClient {
  _SheltersClient._(this._dio, Dio _transport, {this.baseUrl, this.errorLogger})
    : super._(_transport);

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<PaginatedShelterShortSerializersList> v1AvailableSheltersList({
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
    String? search,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'offset': offset,
      r'search': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedShelterShortSerializersList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/available-shelters/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedShelterShortSerializersList _value;
    try {
      _value = PaginatedShelterShortSerializersList.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<PaginatedShelterDrugList> v1ShelterDrugsList({
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
    String? search,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'offset': offset,
      r'search': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedShelterDrugList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelter/drugs/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedShelterDrugList _value;
    try {
      _value = PaginatedShelterDrugList.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<PaginatedShelterShortSerializersList> v1SheltersList({
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
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'offset': offset,
      r'search': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Accept': 'application/json',
      r'x-current-shelter': xCurrentShelter,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PaginatedShelterShortSerializersList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/shelters/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedShelterShortSerializersList _value;
    try {
      _value = PaginatedShelterShortSerializersList.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UserSheltersWorkerSerializers> v1SheltersAddCreate({
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
    required UserSheltersWorkerSerializers body,
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
    final _options = _setStreamType<UserSheltersWorkerSerializers>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
          .compose(
            _dio.options,
            '/api/v1/shelters/add/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late UserSheltersWorkerSerializers _value;
    try {
      _value = UserSheltersWorkerSerializers.fromJson(_result.data!);
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
