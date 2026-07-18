// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/animal_attribute.dart';
import '../models/animal_note.dart';
import '../models/animal_read.dart';
import '../models/animal_stats_response.dart';
import '../models/animal_write.dart';
import '../models/applicant_file.dart';
import '../models/created_at_range.dart';
import '../models/format2.dart';
import '../models/level.dart';
import '../models/paginated_animal_history_snapshot_list.dart';
import '../models/paginated_animal_note_list.dart';
import '../models/paginated_animal_read_list.dart';
import '../models/paginated_species_list.dart';
import '../models/patched_animal_note.dart';
import '../models/patched_animal_write.dart';
import '../models/species.dart';
import '../models/status.dart';

part 'animals_client.g.dart';

@RestApi()
abstract class AnimalsClient {
  factory AnimalsClient(Dio dio, {String? baseUrl}) = _AnimalsClient;

  /// Full crud view for Animal.
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
  @GET('/api/v1/animals/')
  Future<PaginatedAnimalReadList> v1AnimalsList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('search') String? search,
  });

  /// Full crud view for Animal.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animals/')
  Future<AnimalRead> v1AnimalsCreate({
    @Body() required AnimalWrite body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Animal.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{id}/')
  Future<AnimalRead> v1AnimalsRetrieve({
    @Path('id') required String id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Animal.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/{id}/')
  Future<AnimalRead> v1AnimalsUpdate({
    @Path('id') required String id,
    @Body() required AnimalWrite body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Animal.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/animals/{id}/')
  Future<AnimalRead> v1AnimalsPartialUpdate({
    @Path('id') required String id,
    @Body() PatchedAnimalWrite? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Full crud view for Animal.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @DELETE('/api/v1/animals/{id}/')
  Future<void> v1AnimalsDestroy({
    @Path('id') required String id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Generate PDF File by Animal, AnimalHistorySnapshot and Prescriptions.
  ///
  /// [from] - From datetime, should be UTC.
  ///
  /// [pdfType] - One of ('history', 'history-editing', 'history-prescriptions').
  ///
  /// [to] - To datetime, should be UTC.
  ///
  /// [tz] - Time Zone. It is only used inside pdf rendering.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{id}/{pdf_type}/pdf/')
  @DioResponseType(ResponseType.stream)
  Stream<String> v1AnimalsPdfRetrieve({
    @Query('from') required DateTime from,
    @Path('id') required int id,
    @Path('pdf_type') required String pdfType,
    @Query('to') required DateTime to,
    @Query('tz') String? tz = 'UTC',
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Get all files between animal and applicant.
  ///
  /// [id] - A unique integer value identifying this Applicant File.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{id}/files/')
  Future<List<ApplicantFile>> v1AnimalsFilesList({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// List of Animal History Snapshot.
  ///
  /// [createdAtAfter] - Date range from - to.
  ///
  /// [createdAtBefore] - Date range from - to.
  ///
  /// [createdAtRange] - Date range.
  ///
  /// * `today` - Today.
  /// * `yesterday` - Yesterday.
  /// * `week` - Past 7 days.
  /// * `month` - This month.
  /// * `year` - This year.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [ordering] - Which field to use when ordering the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/{id}/history/')
  Future<PaginatedAnimalHistorySnapshotList> v1AnimalsHistoryList({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('created_at_after') DateTime? createdAtAfter,
    @Query('created_at_before') DateTime? createdAtBefore,
    @Query('created_at_range') CreatedAtRange? createdAtRange,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
  });

  /// Change animal primary photo.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/{id}/primary_image/{image_pk}/')
  Future<Status> v1AnimalsPrimaryImageUpdate({
    @Path('id') required String id,
    @Path('image_pk') required String imagePk,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Restore soft deleted animal.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/{id}/restore/')
  Future<Status> v1AnimalsRestoreUpdate({
    @Path('id') required String id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Readonly view (list, detail) for AnimalAttribute.
  ///
  /// [ordering] - Which field to use when ordering the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/attributes/')
  Future<List<AnimalAttribute>> v1AnimalsAttributesList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('is_required') bool? isRequired,
    @Query('ordering') String? ordering,
  });

  /// Readonly view (list, detail) for AnimalAttribute.
  ///
  /// [id] - A unique integer value identifying this Animal Attribute.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/attributes/{id}/')
  Future<AnimalAttribute> v1AnimalsAttributesRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// List and Create view for AnimalNote.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [ordering] - Which field to use when ordering the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/notes/')
  Future<PaginatedAnimalNoteList> v1AnimalsNotesList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('animal') int? animal,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
  });

  /// List and Create view for AnimalNote.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animals/notes/')
  Future<AnimalNote> v1AnimalsNotesCreate({
    @Body() required AnimalNote body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve, Update, Delete view for AnimalNote.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/notes/{id}/')
  Future<AnimalNote> v1AnimalsNotesRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve, Update, Delete view for AnimalNote.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/animals/notes/{id}/')
  Future<AnimalNote> v1AnimalsNotesUpdate({
    @Path('id') required int id,
    @Body() required AnimalNote body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve, Update, Delete view for AnimalNote.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/animals/notes/{id}/')
  Future<AnimalNote> v1AnimalsNotesPartialUpdate({
    @Path('id') required int id,
    @Body() PatchedAnimalNote? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Retrieve, Update, Delete view for AnimalNote.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @DELETE('/api/v1/animals/notes/{id}/')
  Future<void> v1AnimalsNotesDestroy({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Readonly view (list, detail) for Species.
  ///
  /// [level] - Level of species.
  ///
  /// * `1` - One.
  /// * `2` - Two.
  /// * `3` - Three.
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
  @GET('/api/v1/animals/species/')
  Future<PaginatedSpeciesList> v1AnimalsSpeciesList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('level') Level? level,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('parent_id') int? parentId,
    @Query('search') String? search,
  });

  /// Readonly view (list, detail) for Species.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/animals/species/')
  Future<Species> v1AnimalsSpeciesCreate({
    @Body() required Species body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Readonly view (list, detail) for Species.
  ///
  /// [id] - A unique integer value identifying this Species.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/species/{id}/')
  Future<Species> v1AnimalsSpeciesRetrieve({
    @Path('id') required int id,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// An endpoint to collect statistical information about animals.
  /// The endpoint provides the number of animals with respect to different factors.
  /// Currently breeds, species, date_joined_from, date_joined_to, status_transitions_from,.
  /// status_transitions_to and status_transitions are supported.
  /// Individual IDs of breeds or species should be separated by comas.
  /// If numbers across all breeds are necessary, then pass `all`.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/animals/stats/')
  Future<AnimalStatsResponse> v1AnimalsStatsRetrieve({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('breeds') String? breeds,
    @Query('date_joined_from') String? dateJoinedFrom,
    @Query('date_joined_to') String? dateJoinedTo,
    @Query('format') Format2? format,
    @Query('species') String? species,
    @Query('status_transitions') String? statusTransitions,
    @Query('status_transitions_from') String? statusTransitionsFrom,
    @Query('status_transitions_to') String? statusTransitionsTo,
  });

  /// Public view of an animal, without authorization.
  /// Supports retrieving only now, to prevent scraping.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/ext/animals/{uuid}/')
  Future<AnimalRead> v1ExtAnimalsRetrieve({
    @Path('uuid') required String uuid,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
