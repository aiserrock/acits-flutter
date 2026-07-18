// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/overstay.dart';
import '../models/paginated_overstay_list.dart';
import '../models/patched_overstay.dart';

part 'overstay_client.g.dart';

@RestApi()
abstract class OverstayClient {
  factory OverstayClient(Dio dio, {String? baseUrl}) = _OverstayClient;

  /// Full crud view for Overstay.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{animal_pk}/overstays/')
  Future<PaginatedOverstayList> v1AnimalsOverstaysList({
    @Path('animal_pk') required int animalPk,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// Full crud view for Overstay.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animals/{animal_pk}/overstays/')
  Future<Overstay> v1AnimalsOverstaysCreate({
    @Path('animal_pk') required int animalPk,
    @Body() Overstay? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Overstay.
  ///
  /// [id] - A unique integer value identifying this Overstay.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{animal_pk}/overstays/{id}/')
  Future<Overstay> v1AnimalsOverstaysRetrieve({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Overstay.
  ///
  /// [id] - A unique integer value identifying this Overstay.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/{animal_pk}/overstays/{id}/')
  Future<Overstay> v1AnimalsOverstaysUpdate({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Body() Overstay? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Overstay.
  ///
  /// [id] - A unique integer value identifying this Overstay.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/animals/{animal_pk}/overstays/{id}/')
  Future<Overstay> v1AnimalsOverstaysPartialUpdate({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Body() PatchedOverstay? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
