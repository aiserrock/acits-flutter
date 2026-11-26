// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/animal_sitter.dart';
import '../models/paginated_animal_sitter_list.dart';
import '../models/patched_animal_sitter.dart';

part 'animal_sitter_client.g.dart';

@RestApi()
abstract class AnimalSitterClient {
  factory AnimalSitterClient(Dio dio, {String? baseUrl}) = _AnimalSitterClient;

  /// Full crud view for AnimalSitter.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animal_sitters/')
  Future<PaginatedAnimalSitterList> v1AnimalSittersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
  });

  /// Full crud view for AnimalSitter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animal_sitters/')
  Future<AnimalSitter> v1AnimalSittersCreate({
    @Body() required AnimalSitter body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for AnimalSitter.
  ///
  /// [id] - A unique integer value identifying this AnimalSitter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animal_sitters/{id}/')
  Future<AnimalSitter> v1AnimalSittersRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for AnimalSitter.
  ///
  /// [id] - A unique integer value identifying this AnimalSitter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animal_sitters/{id}/')
  Future<AnimalSitter> v1AnimalSittersUpdate({
    @Path('id') required int id,
    @Body() required AnimalSitter body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for AnimalSitter.
  ///
  /// [id] - A unique integer value identifying this AnimalSitter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/animal_sitters/{id}/')
  Future<AnimalSitter> v1AnimalSittersPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedAnimalSitter? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
