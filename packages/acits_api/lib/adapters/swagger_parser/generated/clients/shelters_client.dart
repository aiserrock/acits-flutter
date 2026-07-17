// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/paginated_shelter_drug_list.dart';
import '../models/paginated_shelter_short_serializers_list.dart';
import '../models/user_shelters_worker_serializers.dart';

part 'shelters_client.g.dart';

@RestApi()
abstract class SheltersClient {
  factory SheltersClient(Dio dio, {String? baseUrl}) = _SheltersClient;

  /// List of available shelters for authenticated user.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/available-shelters/')
  Future<PaginatedShelterShortSerializersList> v1AvailableSheltersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
  });

  /// List of shelter drugs.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/shelter/drugs/')
  Future<PaginatedShelterDrugList> v1ShelterDrugsList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
  });

  /// List of shelters.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/shelters/')
  Future<PaginatedShelterShortSerializersList> v1SheltersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
  });

  /// Add user to shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/shelters/add/')
  Future<UserSheltersWorkerSerializers> v1SheltersAddCreate({
    @Body() required UserSheltersWorkerSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
