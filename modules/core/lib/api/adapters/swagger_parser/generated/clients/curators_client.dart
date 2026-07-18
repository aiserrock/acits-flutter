// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/curator.dart';
import '../models/paginated_curator_list.dart';
import '../models/patched_curator.dart';

part 'curators_client.g.dart';

@RestApi()
abstract class CuratorsClient {
  factory CuratorsClient(Dio dio, {String? baseUrl}) = _CuratorsClient;

  /// Full crud view for Curator.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/curators/')
  Future<PaginatedCuratorList> v1CuratorsList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
  });

  /// Full crud view for Curator.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/curators/')
  Future<Curator> v1CuratorsCreate({
    @Body() required Curator body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Curator.
  ///
  /// [id] - A unique integer value identifying this Curator.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/curators/{id}/')
  Future<Curator> v1CuratorsRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Curator.
  ///
  /// [id] - A unique integer value identifying this Curator.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/curators/{id}/')
  Future<Curator> v1CuratorsUpdate({
    @Path('id') required int id,
    @Body() required Curator body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Curator.
  ///
  /// [id] - A unique integer value identifying this Curator.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/curators/{id}/')
  Future<Curator> v1CuratorsPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedCurator? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
