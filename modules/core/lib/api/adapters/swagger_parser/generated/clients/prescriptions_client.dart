// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/paginated_prescription_execution_today_list.dart';
import '../models/paginated_prescription_list.dart';
import '../models/patched_prescription.dart';
import '../models/prescription.dart';

part 'prescriptions_client.g.dart';

@RestApi()
abstract class PrescriptionsClient {
  factory PrescriptionsClient(Dio dio, {String? baseUrl}) = _PrescriptionsClient;

  /// Full crud view for Prescription.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/prescriptions/')
  Future<PaginatedPrescriptionList> v1PrescriptionsList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('animal') int? animal,
    @Query('execute_at__gte') DateTime? executeAtGte,
    @Query('execute_at__lt') DateTime? executeAtLt,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// Full crud view for Prescription.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/prescriptions/')
  Future<Prescription> v1PrescriptionsCreate({
    @Body() Prescription? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Prescription.
  ///
  /// [id] - A unique integer value identifying this Prescription.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/prescriptions/{id}/')
  Future<Prescription> v1PrescriptionsRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Prescription.
  ///
  /// [id] - A unique integer value identifying this Prescription.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/prescriptions/{id}/')
  Future<Prescription> v1PrescriptionsUpdate({
    @Path('id') required int id,
    @Body() Prescription? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Prescription.
  ///
  /// [id] - A unique integer value identifying this Prescription.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/prescriptions/{id}/')
  Future<Prescription> v1PrescriptionsPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedPrescription? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Prescription.
  ///
  /// [id] - A unique integer value identifying this Prescription.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @DELETE('/api/v1/prescriptions/{id}/')
  Future<void> v1PrescriptionsDestroy({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// List view for PrescriptionExecution 'today'.
  ///
  /// [from] - From datetime.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [ordering] - Which field to use when ordering the results.
  ///
  /// [search] - A search term.
  ///
  /// [to] - To datetime.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/prescriptions/executions/')
  Future<PaginatedPrescriptionExecutionTodayList> v1PrescriptionsExecutionsList({
    @Path('from') required DateTime from,
    @Path('to') required DateTime to,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('search') String? search,
  });
}
