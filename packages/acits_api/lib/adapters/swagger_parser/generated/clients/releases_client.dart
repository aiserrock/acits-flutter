// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/paginated_release_serializers_list.dart';
import '../models/patched_release_serializers.dart';
import '../models/release_serializers.dart';

part 'releases_client.g.dart';

@RestApi()
abstract class ReleasesClient {
  factory ReleasesClient(Dio dio, {String? baseUrl}) = _ReleasesClient;

  /// Create, Read and Update view for Release.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{animal_pk}/releases/')
  Future<PaginatedReleaseSerializersList> v1AnimalsReleasesList({
    @Path('animal_pk') required int animalPk,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// Create, Read and Update view for Release.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animals/{animal_pk}/releases/')
  Future<ReleaseSerializers> v1AnimalsReleasesCreate({
    @Path('animal_pk') required int animalPk,
    @Body() ReleaseSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Create, Read and Update view for Release.
  ///
  /// [id] - A unique integer value identifying this Release.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{animal_pk}/releases/{id}/')
  Future<ReleaseSerializers> v1AnimalsReleasesRetrieve({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Create, Read and Update view for Release.
  ///
  /// [id] - A unique integer value identifying this Release.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/{animal_pk}/releases/{id}/')
  Future<ReleaseSerializers> v1AnimalsReleasesUpdate({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Body() ReleaseSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Create, Read and Update view for Release.
  ///
  /// [id] - A unique integer value identifying this Release.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/animals/{animal_pk}/releases/{id}/')
  Future<ReleaseSerializers> v1AnimalsReleasesPartialUpdate({
    @Path('animal_pk') required int animalPk,
    @Path('id') required int id,
    @Body() PatchedReleaseSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
