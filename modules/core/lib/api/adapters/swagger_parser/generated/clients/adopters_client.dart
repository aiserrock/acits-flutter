// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/adopter.dart';
import '../models/paginated_adopter_list.dart';
import '../models/patched_adopter.dart';

part 'adopters_client.g.dart';

@RestApi()
abstract class AdoptersClient {
  factory AdoptersClient(Dio dio, {String? baseUrl}) = _AdoptersClient;

  /// Full crud view for Adopter.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/adopters/')
  Future<PaginatedAdopterList> v1AdoptersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
  });

  /// Full crud view for Adopter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/adopters/')
  Future<Adopter> v1AdoptersCreate({
    @Body() required Adopter body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Adopter.
  ///
  /// [id] - A unique integer value identifying this Adopter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/adopters/{id}/')
  Future<Adopter> v1AdoptersRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Adopter.
  ///
  /// [id] - A unique integer value identifying this Adopter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/adopters/{id}/')
  Future<Adopter> v1AdoptersUpdate({
    @Path('id') required int id,
    @Body() required Adopter body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Adopter.
  ///
  /// [id] - A unique integer value identifying this Adopter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/adopters/{id}/')
  Future<Adopter> v1AdoptersPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedAdopter? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
