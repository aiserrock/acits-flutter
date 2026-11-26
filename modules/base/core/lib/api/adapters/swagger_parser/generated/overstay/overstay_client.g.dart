// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overstay_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: type=lint
// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _OverstayClient extends OverstayClient {
  _OverstayClient._(this._dio, Dio _transport, {this.baseUrl, this.errorLogger})
    : super._(_transport);

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<PaginatedOverstayList> v1AnimalsOverstaysList({
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
    required int animalPk,
    int? limit,
    int? offset,
    int? xCurrentShelter = 2,
  }) async {
    final _extra = <String, dynamic>{};
    _extra.addAll(extra);
    final queryParameters = <String, dynamic>{
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
    final _options = _setStreamType<PaginatedOverstayList>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/${animalPk}/overstays/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late PaginatedOverstayList _value;
    try {
      _value = PaginatedOverstayList.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Overstay> v1AnimalsOverstaysRetrieve({
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
    required int animalPk,
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
    final _options = _setStreamType<Overstay>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/animals/${animalPk}/overstays/${id}/',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late Overstay _value;
    try {
      _value = Overstay.fromJson(_result.data!);
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
