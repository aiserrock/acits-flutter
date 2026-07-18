// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/applicant.dart';
import '../models/paginated_applicant_list.dart';
import '../models/patched_applicant.dart';

part 'applicants_client.g.dart';

@RestApi()
abstract class ApplicantsClient {
  factory ApplicantsClient(Dio dio, {String? baseUrl}) = _ApplicantsClient;

  /// Full crud view for Applicant.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [ordering] - Which field to use when ordering the results.
  ///
  /// [search] - A search term.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/applicants/')
  Future<PaginatedApplicantList> v1ApplicantsList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('search') String? search,
  });

  /// Full crud view for Applicant.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/applicants/')
  Future<Applicant> v1ApplicantsCreate({
    @Body() required Applicant body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Applicant.
  ///
  /// [id] - A unique integer value identifying this Applicant.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/applicants/{id}/')
  Future<Applicant> v1ApplicantsRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Applicant.
  ///
  /// [id] - A unique integer value identifying this Applicant.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/applicants/{id}/')
  Future<Applicant> v1ApplicantsUpdate({
    @Path('id') required int id,
    @Body() required Applicant body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Applicant.
  ///
  /// [id] - A unique integer value identifying this Applicant.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/applicants/{id}/')
  Future<Applicant> v1ApplicantsPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedApplicant? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Applicant.
  ///
  /// [id] - A unique integer value identifying this Applicant.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @DELETE('/api/v1/applicants/{id}/')
  Future<void> v1ApplicantsDestroy({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
