// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/adoption.dart';
import '../models/paginated_adoption_list.dart';
import '../models/patched_adoption.dart';

part 'adoptions_client.g.dart';

@RestApi()
abstract class AdoptionsClient {
  factory AdoptionsClient(Dio dio, {String? baseUrl}) = _AdoptionsClient;

  /// Full crud view for Adopter.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{animal_pk}/adoptions/')
  Future<PaginatedAdoptionList> v1AnimalsAdoptionsList({
    @Path('animal_pk') required int animalPk,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// Full crud view for Adopter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animals/{animal_pk}/adoptions/')
  Future<Adoption> v1AnimalsAdoptionsCreate({
    @Path('animal_pk') required int animalPk,
    @Body() Adoption? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Adopter.
  ///
  /// [id] - A unique integer value identifying this Adoption.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{animal_pk}/adoptions/{id}/')
  Future<Adoption> v1AnimalsAdoptionsRetrieve({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Adopter.
  ///
  /// [id] - A unique integer value identifying this Adoption.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/{animal_pk}/adoptions/{id}/')
  Future<Adoption> v1AnimalsAdoptionsUpdate({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Body() Adoption? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Adopter.
  ///
  /// [id] - A unique integer value identifying this Adoption.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/animals/{animal_pk}/adoptions/{id}/')
  Future<Adoption> v1AnimalsAdoptionsPartialUpdate({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Body() PatchedAdoption? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
