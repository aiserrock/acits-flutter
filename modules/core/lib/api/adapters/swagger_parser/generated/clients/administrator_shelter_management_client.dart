// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/approve.dart';
import '../models/decline.dart';
import '../models/paginated_user_shelters_admin_serializers_list.dart';
import '../models/patched_shelter_serializers.dart';
import '../models/patched_user_shelters_admin_serializers.dart';
import '../models/shelter_serializers.dart';
import '../models/user_shelters_admin_serializers.dart';

part 'administrator_shelter_management_client.g.dart';

@RestApi()
abstract class AdministratorShelterManagementClient {
  factory AdministratorShelterManagementClient(Dio dio, {String? baseUrl}) = _AdministratorShelterManagementClient;

  /// Full crud of user shelters workers.
  ///
  /// [isVerifiedByAdmin] - Is verified by admin (true/false).
  ///
  /// [isVerifiedByAdminIsnull] - Is verified by admin isnull (true/false).
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/shelter/workers/')
  Future<PaginatedUserSheltersAdminSerializersList> v1ShelterWorkersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('is_verified_by_admin') bool? isVerifiedByAdmin,
    @Query('is_verified_by_admin__isnull') bool? isVerifiedByAdminIsnull,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// Full crud of user shelters workers.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/shelter/workers/')
  Future<UserSheltersAdminSerializers> v1ShelterWorkersCreate({
    @Body() required UserSheltersAdminSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud of user shelters workers.
  ///
  /// [id] - A unique integer value identifying this user shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/shelter/workers/{id}/')
  Future<UserSheltersAdminSerializers> v1ShelterWorkersRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud of user shelters workers.
  ///
  /// [id] - A unique integer value identifying this user shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/shelter/workers/{id}/')
  Future<UserSheltersAdminSerializers> v1ShelterWorkersUpdate({
    @Path('id') required int id,
    @Body() required UserSheltersAdminSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud of user shelters workers.
  ///
  /// [id] - A unique integer value identifying this user shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/shelter/workers/{id}/')
  Future<UserSheltersAdminSerializers> v1ShelterWorkersPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedUserSheltersAdminSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud of user shelters workers.
  ///
  /// [id] - A unique integer value identifying this user shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @DELETE('/api/v1/shelter/workers/{id}/')
  Future<void> v1ShelterWorkersDestroy({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Approve user to shelter.
  ///
  /// [id] - A unique integer value identifying this user shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/shelter/workers/{id}/approve/')
  Future<Approve> v1ShelterWorkersApproveUpdate({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Decline user to shelter.
  ///
  /// [id] - A unique integer value identifying this user shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/shelter/workers/{id}/decline/')
  Future<Decline> v1ShelterWorkersDeclineUpdate({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve/Update shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/shelters/{id}/')
  Future<ShelterSerializers> v1SheltersRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve/Update shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/shelters/{id}/')
  Future<ShelterSerializers> v1SheltersUpdate({
    @Path('id') required int id,
    @Body() required ShelterSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve/Update shelter.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/shelters/{id}/')
  Future<ShelterSerializers> v1SheltersPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedShelterSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
