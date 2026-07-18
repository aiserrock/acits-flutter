// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/format.dart';
import '../models/lang.dart';

part 'schema_client.g.dart';

@RestApi()
abstract class SchemaClient {
  factory SchemaClient(Dio dio, {String? baseUrl}) = _SchemaClient;

  /// OpenApi3 schema for this API. Format can be selected via content negotiation.
  ///
  /// - YAML: application/vnd.oai.openapi.
  /// - JSON: application/vnd.oai.openapi+json.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/schema/')
  Future<dynamic> schemaRetrieve({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('format') Format? format,
    @Query('lang') Lang? lang,
  });
}
