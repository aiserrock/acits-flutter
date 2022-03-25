import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'openapi.enums.swagger.dart' as enums;
export 'openapi.enums.swagger.dart';

part 'openapi.swagger.chopper.dart';
part 'openapi.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Openapi extends ChopperService {
  static Openapi create([ChopperClient? client]) {
    if (client != null) {
      return _$Openapi(client);
    }

    final newClient = ChopperClient(
        services: [_$Openapi()], converter: $JsonSerializableConverter(), baseUrl: 'https://');
    return _$Openapi(newClient);
  }

  ///
  ///@param format
  ///@param lang
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Object>> apiSchemaGet(
      {enums.ApiSchemaGetFormat? format, enums.ApiSchemaGetLang? lang, String? xCurrentShelter}) {
    return _apiSchemaGet(
        format: enums.$ApiSchemaGetFormatMap[format],
        lang: enums.$ApiSchemaGetLangMap[lang],
        xCurrentShelter: xCurrentShelter);
  }

  ///
  ///@param format
  ///@param lang
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/schema/')
  Future<chopper.Response<Object>> _apiSchemaGet(
      {@Query('format') String? format,
      @Query('lang') String? lang,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/token/')
  Future<chopper.Response<TokenObtainPair>> apiTokenPost(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required TokenObtainPair? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/token/refresh/')
  Future<chopper.Response<TokenRefresh>> apiTokenRefreshPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required TokenRefresh? body});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/')
  Future<chopper.Response<PaginatedAnimalReadList>> apiV1AnimalsGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('ordering') String? ordering,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/animals/')
  Future<chopper.Response<AnimalRead>> apiV1AnimalsPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required AnimalWrite? body});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/{id}/')
  Future<chopper.Response<AnimalRead>> apiV1AnimalsIdGet(
      {@Path('id') required String? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/animals/{id}/')
  Future<chopper.Response<AnimalRead>> apiV1AnimalsIdPut(
      {@Path('id') required String? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required AnimalWrite? body});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/animals/{id}/')
  Future<chopper.Response<AnimalRead>> apiV1AnimalsIdPatch(
      {@Path('id') required String? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedAnimalWrite? body});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Delete(path: '/api/v1/animals/{id}/')
  Future<chopper.Response> apiV1AnimalsIdDelete(
      {@Path('id') required String? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id
  ///@param pdf_type One of ('history', 'history-editing', 'history-prescriptions')
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/{id}/{pdf_type}/pdf/')
  Future<chopper.Response<String>> apiV1AnimalsIdPdfTypePdfGet(
      {@Path('id') required int? id,
      @Path('pdf_type') required String? pdfType,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this Applicant File.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/{id}/files/')
  Future<chopper.Response<List<ApplicantFile>>> apiV1AnimalsIdFilesGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param created_at_after Date range from - to
  ///@param created_at_before Date range from - to
  ///@param created_at_range Date range
  ///@param id
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAnimalHistorySnapshotList>> apiV1AnimalsIdHistoryGet(
      {String? createdAtAfter,
      String? createdAtBefore,
      enums.ApiV1AnimalsIdHistoryGetCreatedAtRange? createdAtRange,
      required int? id,
      int? limit,
      int? offset,
      String? ordering,
      String? xCurrentShelter}) {
    return _apiV1AnimalsIdHistoryGet(
        createdAtAfter: createdAtAfter,
        createdAtBefore: createdAtBefore,
        createdAtRange: enums.$ApiV1AnimalsIdHistoryGetCreatedAtRangeMap[createdAtRange],
        id: id,
        limit: limit,
        offset: offset,
        ordering: ordering,
        xCurrentShelter: xCurrentShelter);
  }

  ///
  ///@param created_at_after Date range from - to
  ///@param created_at_before Date range from - to
  ///@param created_at_range Date range
  ///@param id
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/{id}/history/')
  Future<chopper.Response<PaginatedAnimalHistorySnapshotList>> _apiV1AnimalsIdHistoryGet(
      {@Query('created_at_after') String? createdAtAfter,
      @Query('created_at_before') String? createdAtBefore,
      @Query('created_at_range') String? createdAtRange,
      @Path('id') required int? id,
      @Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('ordering') String? ordering,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id
  ///@param image_pk
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/animals/{id}/primary_image/{image_pk}/', optionalBody: true)
  Future<chopper.Response<Status>> apiV1AnimalsIdPrimaryImageImagePkPut(
      {@Path('id') required String? id,
      @Path('image_pk') required String? imagePk,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/animals/{id}/restore/', optionalBody: true)
  Future<chopper.Response<Status>> apiV1AnimalsIdRestorePut(
      {@Path('id') required String? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param is_required
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/attributes/')
  Future<chopper.Response<List<AnimalAttribute>>> apiV1AnimalsAttributesGet(
      {@Query('is_required') bool? isRequired,
      @Query('ordering') String? ordering,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this Animal Attribute.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/attributes/{id}/')
  Future<chopper.Response<AnimalAttribute>> apiV1AnimalsAttributesIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param animal
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/notes/')
  Future<chopper.Response<PaginatedAnimalNoteList>> apiV1AnimalsNotesGet(
      {@Query('animal') int? animal,
      @Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('ordering') String? ordering,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/animals/notes/')
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required AnimalNote? body});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/notes/{id}/')
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/animals/notes/{id}/')
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesIdPut(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required AnimalNote? body});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/animals/notes/{id}/')
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesIdPatch(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedAnimalNote? body});

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @Delete(path: '/api/v1/animals/notes/{id}/')
  Future<chopper.Response> apiV1AnimalsNotesIdDelete(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param level Level of species
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param parent_id
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedSpeciesList>> apiV1AnimalsSpeciesGet(
      {enums.ApiV1AnimalsSpeciesGetLevel? level,
      int? limit,
      int? offset,
      String? ordering,
      int? parentId,
      String? search,
      String? xCurrentShelter}) {
    return _apiV1AnimalsSpeciesGet(
        level: enums.$ApiV1AnimalsSpeciesGetLevelMap[level],
        limit: limit,
        offset: offset,
        ordering: ordering,
        parentId: parentId,
        search: search,
        xCurrentShelter: xCurrentShelter);
  }

  ///
  ///@param level Level of species
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param parent_id
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/species/')
  Future<chopper.Response<PaginatedSpeciesList>> _apiV1AnimalsSpeciesGet(
      {@Query('level') String? level,
      @Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('ordering') String? ordering,
      @Query('parent_id') int? parentId,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/animals/species/')
  Future<chopper.Response<Species>> apiV1AnimalsSpeciesPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required Species? body});

  ///
  ///@param id A unique integer value identifying this Species.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/animals/species/{id}/')
  Future<chopper.Response<Species>> apiV1AnimalsSpeciesIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/applicants/')
  Future<chopper.Response<PaginatedApplicantList>> apiV1ApplicantsGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('ordering') String? ordering,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/applicants/')
  Future<chopper.Response<Applicant>> apiV1ApplicantsPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required Applicant? body});

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/applicants/{id}/')
  Future<chopper.Response<Applicant>> apiV1ApplicantsIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/applicants/{id}/')
  Future<chopper.Response<Applicant>> apiV1ApplicantsIdPut(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required Applicant? body});

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/applicants/{id}/')
  Future<chopper.Response<Applicant>> apiV1ApplicantsIdPatch(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedApplicant? body});

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @Delete(path: '/api/v1/applicants/{id}/')
  Future<chopper.Response> apiV1ApplicantsIdDelete(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/available-shelters/')
  Future<chopper.Response<PaginatedShelterShortSerializersList>> apiV1AvailableSheltersGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/curators/')
  Future<chopper.Response<PaginatedCuratorList>> apiV1CuratorsGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/curators/')
  Future<chopper.Response<Curator>> apiV1CuratorsPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required Curator? body});

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/curators/{id}/')
  Future<chopper.Response<Curator>> apiV1CuratorsIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/curators/{id}/')
  Future<chopper.Response<Curator>> apiV1CuratorsIdPut(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required Curator? body});

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/curators/{id}/')
  Future<chopper.Response<Curator>> apiV1CuratorsIdPatch(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedCurator? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/feedback/')
  Future<chopper.Response<Feedback>> apiV1FeedbackPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required Feedback? body});

  ///
  ///@param animal
  ///@param execute_at__gte
  ///@param execute_at__lt
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/prescriptions/')
  Future<chopper.Response<PaginatedPrescriptionList>> apiV1PrescriptionsGet(
      {@Query('animal') int? animal,
      @Query('execute_at__gte') String? executeAtGte,
      @Query('execute_at__lt') String? executeAtLt,
      @Query('limit') int? limit,
      @Query('offset') int? offset,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/prescriptions/')
  Future<chopper.Response<Prescription>> apiV1PrescriptionsPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required Prescription? body});

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/prescriptions/{id}/')
  Future<chopper.Response<Prescription>> apiV1PrescriptionsIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/prescriptions/{id}/')
  Future<chopper.Response<Prescription>> apiV1PrescriptionsIdPut(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required Prescription? body});

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/prescriptions/{id}/')
  Future<chopper.Response<Prescription>> apiV1PrescriptionsIdPatch(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedPrescription? body});

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @Delete(path: '/api/v1/prescriptions/{id}/')
  Future<chopper.Response> apiV1PrescriptionsIdDelete(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param from From datetime
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param to To datetime
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/prescriptions/executions/')
  Future<chopper.Response<PaginatedPrescriptionExecutionTodayList>> apiV1PrescriptionsExecutionsGet(
      {@Path('from') required String? from,
      @Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('ordering') String? ordering,
      @Query('search') String? search,
      @Path('to') required String? to,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/shelter/drugs/')
  Future<chopper.Response<PaginatedShelterDrugList>> apiV1ShelterDrugsGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param is_verified_by_admin Is verified by admin (true/false)
  ///@param is_verified_by_admin__isnull Is verified by admin isnull (true/false)
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/shelter/workers/')
  Future<chopper.Response<PaginatedUserSheltersAdminSerializersList>> apiV1ShelterWorkersGet(
      {@Query('is_verified_by_admin') bool? isVerifiedByAdmin,
      @Query('is_verified_by_admin__isnull') bool? isVerifiedByAdminIsnull,
      @Query('limit') int? limit,
      @Query('offset') int? offset,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/shelter/workers/')
  Future<chopper.Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersPost(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserSheltersAdminSerializers? body});

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/shelter/workers/{id}/')
  Future<chopper.Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdGet(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/shelter/workers/{id}/')
  Future<chopper.Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdPut(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserSheltersAdminSerializers? body});

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/shelter/workers/{id}/')
  Future<chopper.Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdPatch(
      {@Path('id') required int? id,
      @Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedUserSheltersAdminSerializers? body});

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @Delete(path: '/api/v1/shelter/workers/{id}/')
  Future<chopper.Response> apiV1ShelterWorkersIdDelete(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/shelter/workers/{id}/approve/', optionalBody: true)
  Future<chopper.Response<Approve>> apiV1ShelterWorkersIdApprovePut(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/shelter/workers/{id}/decline/', optionalBody: true)
  Future<chopper.Response<Decline>> apiV1ShelterWorkersIdDeclinePut(
      {@Path('id') required int? id, @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/shelters/')
  Future<chopper.Response<PaginatedShelterShortSerializersList>> apiV1SheltersGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Query('search') String? search,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/shelters/add/')
  Future<chopper.Response<UserSheltersWorkerSerializers>> apiV1SheltersAddPost(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserSheltersWorkerSerializers? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/users/admin-register/')
  Future<chopper.Response<UserShelterAdminSerializers>> apiV1UsersAdminRegisterPost(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserShelterAdminSerializers? body});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/available-workers/')
  Future<chopper.Response<PaginatedUserShortSerializersList>> apiV1UsersAvailableWorkersGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/me/')
  Future<chopper.Response<UserSerializers>> apiV1UsersMeGet(
      {@Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/users/me/')
  Future<chopper.Response<UserSerializers>> apiV1UsersMePut(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserSerializers? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/users/me/')
  Future<chopper.Response<UserSerializers>> apiV1UsersMePatch(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedUserSerializers? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Put(path: '/api/v1/users/me/change_password/')
  Future<chopper.Response<UserChangePasswordSerializers>> apiV1UsersMeChangePasswordPut(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserChangePasswordSerializers? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Patch(path: '/api/v1/users/me/change_password/')
  Future<chopper.Response<UserChangePasswordSerializers>> apiV1UsersMeChangePasswordPatch(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required PatchedUserChangePasswordSerializers? body});

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/me/shelters/')
  Future<chopper.Response<PaginatedShelterShortSerializersList>> apiV1UsersMeSheltersGet(
      {@Query('limit') int? limit,
      @Query('offset') int? offset,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/me/shelters/current/')
  Future<chopper.Response<UserCurrentShelterSerializers>> apiV1UsersMeSheltersCurrentGet(
      {@Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/users/reset-password/')
  Future<chopper.Response> apiV1UsersResetPasswordPost(
      {@Header('x-current-shelter') String? xCurrentShelter, @Body() required Email? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/users/reset-password/complete/')
  Future<chopper.Response> apiV1UsersResetPasswordCompletePost(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserResetPasswordComplete? body});

  ///
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/reset-password/confirm/{uidb64}/{token}/')
  Future<chopper.Response> apiV1UsersResetPasswordConfirmUidb64TokenGet(
      {@Path('token') required String? token,
      @Path('uidb64') required String? uidb64,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param sidb64
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/verify-email/{uidb64}/{sidb64}/{token}/')
  Future<chopper.Response> apiV1UsersVerifyEmailUidb64Sidb64TokenGet(
      {@Path('sidb64') required String? sidb64,
      @Path('token') required String? token,
      @Path('uidb64') required String? uidb64,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param sidb64
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/users/verify-worker/{uidb64}/{sidb64}/{token}/')
  Future<chopper.Response> apiV1UsersVerifyWorkerUidb64Sidb64TokenGet(
      {@Path('sidb64') required String? sidb64,
      @Path('token') required String? token,
      @Path('uidb64') required String? uidb64,
      @Header('x-current-shelter') String? xCurrentShelter});

  ///
  ///@param x-current-shelter Set current shelter id
  @Post(path: '/api/v1/users/worker-register/')
  Future<chopper.Response<UserShelterWorkerSerializers>> apiV1UsersWorkerRegisterPost(
      {@Header('x-current-shelter') String? xCurrentShelter,
      @Body() required UserShelterWorkerSerializers? body});

  ///
  ///@param x-current-shelter Set current shelter id
  @Get(path: '/api/v1/values-for-selection/')
  Future<chopper.Response<ValuesForSelection>> apiV1ValuesForSelectionGet(
      {@Header('x-current-shelter') String? xCurrentShelter});
}

final Map<Type, Object Function(Map<String, dynamic>)> OpenapiJsonDecoderMappings = {
  AnimalAttribute: AnimalAttribute.fromJsonFactory,
  AnimalAttributeValue: AnimalAttributeValue.fromJsonFactory,
  AnimalHistorySnapshot: AnimalHistorySnapshot.fromJsonFactory,
  AnimalImageRead: AnimalImageRead.fromJsonFactory,
  AnimalImageWrite: AnimalImageWrite.fromJsonFactory,
  AnimalNote: AnimalNote.fromJsonFactory,
  AnimalNoteFile: AnimalNoteFile.fromJsonFactory,
  AnimalRead: AnimalRead.fromJsonFactory,
  AnimalShort: AnimalShort.fromJsonFactory,
  AnimalWrite: AnimalWrite.fromJsonFactory,
  Applicant: Applicant.fromJsonFactory,
  ApplicantFile: ApplicantFile.fromJsonFactory,
  Approve: Approve.fromJsonFactory,
  Curator: Curator.fromJsonFactory,
  Decline: Decline.fromJsonFactory,
  Drug: Drug.fromJsonFactory,
  Email: Email.fromJsonFactory,
  Feedback: Feedback.fromJsonFactory,
  ImageThumbnails: ImageThumbnails.fromJsonFactory,
  PaginatedAnimalHistorySnapshotList: PaginatedAnimalHistorySnapshotList.fromJsonFactory,
  PaginatedAnimalNoteList: PaginatedAnimalNoteList.fromJsonFactory,
  PaginatedAnimalReadList: PaginatedAnimalReadList.fromJsonFactory,
  PaginatedApplicantList: PaginatedApplicantList.fromJsonFactory,
  PaginatedCuratorList: PaginatedCuratorList.fromJsonFactory,
  PaginatedPrescriptionExecutionTodayList: PaginatedPrescriptionExecutionTodayList.fromJsonFactory,
  PaginatedPrescriptionList: PaginatedPrescriptionList.fromJsonFactory,
  PaginatedShelterDrugList: PaginatedShelterDrugList.fromJsonFactory,
  PaginatedShelterShortSerializersList: PaginatedShelterShortSerializersList.fromJsonFactory,
  PaginatedSpeciesList: PaginatedSpeciesList.fromJsonFactory,
  PaginatedUserSheltersAdminSerializersList:
      PaginatedUserSheltersAdminSerializersList.fromJsonFactory,
  PaginatedUserShortSerializersList: PaginatedUserShortSerializersList.fromJsonFactory,
  PatchedAnimalNote: PatchedAnimalNote.fromJsonFactory,
  PatchedAnimalWrite: PatchedAnimalWrite.fromJsonFactory,
  PatchedApplicant: PatchedApplicant.fromJsonFactory,
  PatchedCurator: PatchedCurator.fromJsonFactory,
  PatchedPrescription: PatchedPrescription.fromJsonFactory,
  PatchedUserChangePasswordSerializers: PatchedUserChangePasswordSerializers.fromJsonFactory,
  PatchedUserSerializers: PatchedUserSerializers.fromJsonFactory,
  PatchedUserSheltersAdminSerializers: PatchedUserSheltersAdminSerializers.fromJsonFactory,
  Prescription: Prescription.fromJsonFactory,
  PrescriptionDrug: PrescriptionDrug.fromJsonFactory,
  PrescriptionExecution: PrescriptionExecution.fromJsonFactory,
  PrescriptionExecutionToday: PrescriptionExecutionToday.fromJsonFactory,
  PrescriptionFile: PrescriptionFile.fromJsonFactory,
  PrescriptionShort: PrescriptionShort.fromJsonFactory,
  ShelterDrug: ShelterDrug.fromJsonFactory,
  ShelterSerializers: ShelterSerializers.fromJsonFactory,
  ShelterShortSerializers: ShelterShortSerializers.fromJsonFactory,
  Species: Species.fromJsonFactory,
  Status: Status.fromJsonFactory,
  TokenObtainPair: TokenObtainPair.fromJsonFactory,
  TokenRefresh: TokenRefresh.fromJsonFactory,
  UserChangePasswordSerializers: UserChangePasswordSerializers.fromJsonFactory,
  UserCurrentShelterSerializers: UserCurrentShelterSerializers.fromJsonFactory,
  UserResetPasswordComplete: UserResetPasswordComplete.fromJsonFactory,
  UserSerializers: UserSerializers.fromJsonFactory,
  UserShelterAdminSerializers: UserShelterAdminSerializers.fromJsonFactory,
  UserShelterWorkerSerializers: UserShelterWorkerSerializers.fromJsonFactory,
  UserSheltersAdminSerializers: UserSheltersAdminSerializers.fromJsonFactory,
  UserSheltersWorkerSerializers: UserSheltersWorkerSerializers.fromJsonFactory,
  UserShortSerializers: UserShortSerializers.fromJsonFactory,
  ValuesForSelection: ValuesForSelection.fromJsonFactory,
  ValuesForSelectionItem: ValuesForSelectionItem.fromJsonFactory,
};

@JsonSerializable(explicitToJson: true)
class AnimalAttribute {
  AnimalAttribute({
    this.id,
    this.name,
    this.isRequired,
  });

  factory AnimalAttribute.fromJson(Map<String, dynamic> json) => _$AnimalAttributeFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'is_required')
  final bool? isRequired;
  static const fromJsonFactory = _$AnimalAttributeFromJson;
  static const toJsonFactory = _$AnimalAttributeToJson;
  Map<String, dynamic> toJson() => _$AnimalAttributeToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalAttribute &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.isRequired, isRequired) ||
                const DeepCollectionEquality().equals(other.isRequired, isRequired)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(isRequired) ^
      runtimeType.hashCode;
}

extension $AnimalAttributeExtension on AnimalAttribute {
  AnimalAttribute copyWith({int? id, String? name, bool? isRequired}) {
    return AnimalAttribute(
        id: id ?? this.id, name: name ?? this.name, isRequired: isRequired ?? this.isRequired);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalAttributeValue {
  AnimalAttributeValue({
    this.attrId,
    this.name,
    this.value,
    this.isRequired,
  });

  factory AnimalAttributeValue.fromJson(Map<String, dynamic> json) =>
      _$AnimalAttributeValueFromJson(json);

  @JsonKey(name: 'attr_id')
  final int? attrId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'is_required')
  final bool? isRequired;
  static const fromJsonFactory = _$AnimalAttributeValueFromJson;
  static const toJsonFactory = _$AnimalAttributeValueToJson;
  Map<String, dynamic> toJson() => _$AnimalAttributeValueToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalAttributeValue &&
            (identical(other.attrId, attrId) ||
                const DeepCollectionEquality().equals(other.attrId, attrId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.isRequired, isRequired) ||
                const DeepCollectionEquality().equals(other.isRequired, isRequired)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(attrId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(isRequired) ^
      runtimeType.hashCode;
}

extension $AnimalAttributeValueExtension on AnimalAttributeValue {
  AnimalAttributeValue copyWith({int? attrId, String? name, String? value, bool? isRequired}) {
    return AnimalAttributeValue(
        attrId: attrId ?? this.attrId,
        name: name ?? this.name,
        value: value ?? this.value,
        isRequired: isRequired ?? this.isRequired);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalHistorySnapshot {
  AnimalHistorySnapshot({
    this.animal,
    this.createdAt,
    this.status,
    this.height,
    this.weight,
    this.shelterName,
    this.editor,
  });

  factory AnimalHistorySnapshot.fromJson(Map<String, dynamic> json) =>
      _$AnimalHistorySnapshotFromJson(json);

  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'status', toJson: status131EnumToJson, fromJson: status131EnumFromJson)
  final enums.Status131Enum? status;
  @JsonKey(name: 'height')
  final String? height;
  @JsonKey(name: 'weight')
  final String? weight;
  @JsonKey(name: 'shelter_name')
  final String? shelterName;
  @JsonKey(name: 'editor')
  final String? editor;
  static const fromJsonFactory = _$AnimalHistorySnapshotFromJson;
  static const toJsonFactory = _$AnimalHistorySnapshotToJson;
  Map<String, dynamic> toJson() => _$AnimalHistorySnapshotToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalHistorySnapshot &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.shelterName, shelterName) ||
                const DeepCollectionEquality().equals(other.shelterName, shelterName)) &&
            (identical(other.editor, editor) ||
                const DeepCollectionEquality().equals(other.editor, editor)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(weight) ^
      const DeepCollectionEquality().hash(shelterName) ^
      const DeepCollectionEquality().hash(editor) ^
      runtimeType.hashCode;
}

extension $AnimalHistorySnapshotExtension on AnimalHistorySnapshot {
  AnimalHistorySnapshot copyWith(
      {int? animal,
      DateTime? createdAt,
      enums.Status131Enum? status,
      String? height,
      String? weight,
      String? shelterName,
      String? editor}) {
    return AnimalHistorySnapshot(
        animal: animal ?? this.animal,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        shelterName: shelterName ?? this.shelterName,
        editor: editor ?? this.editor);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalImageRead {
  AnimalImageRead({
    this.id,
    this.isPrimary,
    this.filename,
    this.image,
  });

  factory AnimalImageRead.fromJson(Map<String, dynamic> json) => _$AnimalImageReadFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'image')
  final ImageThumbnails? image;
  static const fromJsonFactory = _$AnimalImageReadFromJson;
  static const toJsonFactory = _$AnimalImageReadToJson;
  Map<String, dynamic> toJson() => _$AnimalImageReadToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalImageRead &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isPrimary, isPrimary) ||
                const DeepCollectionEquality().equals(other.isPrimary, isPrimary)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(other.filename, filename)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isPrimary) ^
      const DeepCollectionEquality().hash(filename) ^
      const DeepCollectionEquality().hash(image) ^
      runtimeType.hashCode;
}

extension $AnimalImageReadExtension on AnimalImageRead {
  AnimalImageRead copyWith({int? id, bool? isPrimary, String? filename, ImageThumbnails? image}) {
    return AnimalImageRead(
        id: id ?? this.id,
        isPrimary: isPrimary ?? this.isPrimary,
        filename: filename ?? this.filename,
        image: image ?? this.image);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalImageWrite {
  AnimalImageWrite({
    this.isPrimary,
    this.name,
    this.image,
  });

  factory AnimalImageWrite.fromJson(Map<String, dynamic> json) => _$AnimalImageWriteFromJson(json);

  @JsonKey(name: 'is_primary')
  final bool? isPrimary;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  static const fromJsonFactory = _$AnimalImageWriteFromJson;
  static const toJsonFactory = _$AnimalImageWriteToJson;
  Map<String, dynamic> toJson() => _$AnimalImageWriteToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalImageWrite &&
            (identical(other.isPrimary, isPrimary) ||
                const DeepCollectionEquality().equals(other.isPrimary, isPrimary)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isPrimary) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(image) ^
      runtimeType.hashCode;
}

extension $AnimalImageWriteExtension on AnimalImageWrite {
  AnimalImageWrite copyWith({bool? isPrimary, String? name, String? image}) {
    return AnimalImageWrite(
        isPrimary: isPrimary ?? this.isPrimary,
        name: name ?? this.name,
        image: image ?? this.image);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalNote {
  AnimalNote({
    this.id,
    this.url,
    this.animal,
    this.content,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isUserCanEditOrDelete,
  });

  factory AnimalNote.fromJson(Map<String, dynamic> json) => _$AnimalNoteFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'files', defaultValue: <AnimalNoteFile>[])
  final List<AnimalNoteFile>? files;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'is_user_can_edit_or_delete')
  final bool? isUserCanEditOrDelete;
  static const fromJsonFactory = _$AnimalNoteFromJson;
  static const toJsonFactory = _$AnimalNoteToJson;
  Map<String, dynamic> toJson() => _$AnimalNoteToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalNote &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(other.updatedAt, updatedAt)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.isUserCanEditOrDelete, isUserCanEditOrDelete) ||
                const DeepCollectionEquality()
                    .equals(other.isUserCanEditOrDelete, isUserCanEditOrDelete)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(files) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(isUserCanEditOrDelete) ^
      runtimeType.hashCode;
}

extension $AnimalNoteExtension on AnimalNote {
  AnimalNote copyWith(
      {int? id,
      String? url,
      int? animal,
      String? content,
      List<AnimalNoteFile>? files,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? createdBy,
      String? updatedBy,
      bool? isUserCanEditOrDelete}) {
    return AnimalNote(
        id: id ?? this.id,
        url: url ?? this.url,
        animal: animal ?? this.animal,
        content: content ?? this.content,
        files: files ?? this.files,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        isUserCanEditOrDelete: isUserCanEditOrDelete ?? this.isUserCanEditOrDelete);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalNoteFile {
  AnimalNoteFile({
    this.id,
    this.file,
    this.name,
    this.filename,
    this.createdAt,
  });

  factory AnimalNoteFile.fromJson(Map<String, dynamic> json) => _$AnimalNoteFileFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'file')
  final String? file;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$AnimalNoteFileFromJson;
  static const toJsonFactory = _$AnimalNoteFileToJson;
  Map<String, dynamic> toJson() => _$AnimalNoteFileToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalNoteFile &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(other.filename, filename)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(filename) ^
      const DeepCollectionEquality().hash(createdAt) ^
      runtimeType.hashCode;
}

extension $AnimalNoteFileExtension on AnimalNoteFile {
  AnimalNoteFile copyWith(
      {int? id, String? file, String? name, String? filename, DateTime? createdAt}) {
    return AnimalNoteFile(
        id: id ?? this.id,
        file: file ?? this.file,
        name: name ?? this.name,
        filename: filename ?? this.filename,
        createdAt: createdAt ?? this.createdAt);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalRead {
  AnimalRead({
    this.id,
    this.url,
    this.name,
    this.images,
    this.spec,
    this.status,
    this.dateJoined,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    this.placeOfCatch,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.hasDocuments,
    this.shelter,
    this.curator,
    this.applicant,
    this.animalAttributes,
    this.deletedAt,
  });

  factory AnimalRead.fromJson(Map<String, dynamic> json) => _$AnimalReadFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'images', defaultValue: <AnimalImageRead>[])
  final List<AnimalImageRead>? images;
  @JsonKey(name: 'spec')
  final dynamic spec;
  @JsonKey(name: 'status', toJson: status131EnumToJson, fromJson: status131EnumFromJson)
  final enums.Status131Enum? status;
  @JsonKey(name: 'date_joined', toJson: _dateToJson)
  final DateTime? dateJoined;
  @JsonKey(name: 'birth_date', toJson: _dateToJson)
  final DateTime? birthDate;
  @JsonKey(name: 'death_date', toJson: _dateToJson)
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String? placeOfCatch;
  @JsonKey(name: 'place_of_release')
  final String? placeOfRelease;
  @JsonKey(name: 'date_of_chipping', toJson: _dateToJson)
  final DateTime? dateOfChipping;
  @JsonKey(name: 'chipping_code')
  final String? chippingCode;
  @JsonKey(name: 'height')
  final String? height;
  @JsonKey(name: 'weight')
  final String? weight;
  @JsonKey(name: 'has_documents')
  final bool? hasDocuments;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'curator')
  final dynamic curator;
  @JsonKey(name: 'applicant')
  final dynamic applicant;
  @JsonKey(name: 'animal_attributes', defaultValue: <AnimalAttributeValue>[])
  final List<AnimalAttributeValue>? animalAttributes;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  static const fromJsonFactory = _$AnimalReadFromJson;
  static const toJsonFactory = _$AnimalReadToJson;
  Map<String, dynamic> toJson() => _$AnimalReadToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalRead &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.spec, spec) ||
                const DeepCollectionEquality().equals(other.spec, spec)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(other.dateJoined, dateJoined)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality().equals(other.birthDate, birthDate)) &&
            (identical(other.deathDate, deathDate) ||
                const DeepCollectionEquality().equals(other.deathDate, deathDate)) &&
            (identical(other.deathReason, deathReason) ||
                const DeepCollectionEquality().equals(other.deathReason, deathReason)) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(other.defaultImageId, defaultImageId)) &&
            (identical(other.placeOfCatch, placeOfCatch) ||
                const DeepCollectionEquality().equals(other.placeOfCatch, placeOfCatch)) &&
            (identical(other.placeOfRelease, placeOfRelease) ||
                const DeepCollectionEquality().equals(other.placeOfRelease, placeOfRelease)) &&
            (identical(other.dateOfChipping, dateOfChipping) ||
                const DeepCollectionEquality().equals(other.dateOfChipping, dateOfChipping)) &&
            (identical(other.chippingCode, chippingCode) ||
                const DeepCollectionEquality().equals(other.chippingCode, chippingCode)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.hasDocuments, hasDocuments) ||
                const DeepCollectionEquality().equals(other.hasDocuments, hasDocuments)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.curator, curator) ||
                const DeepCollectionEquality().equals(other.curator, curator)) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality().equals(other.applicant, applicant)) &&
            (identical(other.animalAttributes, animalAttributes) ||
                const DeepCollectionEquality().equals(other.animalAttributes, animalAttributes)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality().equals(other.deletedAt, deletedAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(spec) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(deathDate) ^
      const DeepCollectionEquality().hash(deathReason) ^
      const DeepCollectionEquality().hash(defaultImageId) ^
      const DeepCollectionEquality().hash(placeOfCatch) ^
      const DeepCollectionEquality().hash(placeOfRelease) ^
      const DeepCollectionEquality().hash(dateOfChipping) ^
      const DeepCollectionEquality().hash(chippingCode) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(weight) ^
      const DeepCollectionEquality().hash(hasDocuments) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(curator) ^
      const DeepCollectionEquality().hash(applicant) ^
      const DeepCollectionEquality().hash(animalAttributes) ^
      const DeepCollectionEquality().hash(deletedAt) ^
      runtimeType.hashCode;
}

extension $AnimalReadExtension on AnimalRead {
  AnimalRead copyWith(
      {int? id,
      String? url,
      String? name,
      List<AnimalImageRead>? images,
      dynamic? spec,
      enums.Status131Enum? status,
      DateTime? dateJoined,
      DateTime? birthDate,
      DateTime? deathDate,
      String? deathReason,
      int? defaultImageId,
      String? placeOfCatch,
      String? placeOfRelease,
      DateTime? dateOfChipping,
      String? chippingCode,
      String? height,
      String? weight,
      bool? hasDocuments,
      int? shelter,
      dynamic? curator,
      dynamic? applicant,
      List<AnimalAttributeValue>? animalAttributes,
      DateTime? deletedAt}) {
    return AnimalRead(
        id: id ?? this.id,
        url: url ?? this.url,
        name: name ?? this.name,
        images: images ?? this.images,
        spec: spec ?? this.spec,
        status: status ?? this.status,
        dateJoined: dateJoined ?? this.dateJoined,
        birthDate: birthDate ?? this.birthDate,
        deathDate: deathDate ?? this.deathDate,
        deathReason: deathReason ?? this.deathReason,
        defaultImageId: defaultImageId ?? this.defaultImageId,
        placeOfCatch: placeOfCatch ?? this.placeOfCatch,
        placeOfRelease: placeOfRelease ?? this.placeOfRelease,
        dateOfChipping: dateOfChipping ?? this.dateOfChipping,
        chippingCode: chippingCode ?? this.chippingCode,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        hasDocuments: hasDocuments ?? this.hasDocuments,
        shelter: shelter ?? this.shelter,
        curator: curator ?? this.curator,
        applicant: applicant ?? this.applicant,
        animalAttributes: animalAttributes ?? this.animalAttributes,
        deletedAt: deletedAt ?? this.deletedAt);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalShort {
  AnimalShort({
    this.id,
    this.name,
    this.specName,
    this.specParentName,
    this.avatar,
    this.defaultImageId,
  });

  factory AnimalShort.fromJson(Map<String, dynamic> json) => _$AnimalShortFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'spec_name')
  final String? specName;
  @JsonKey(name: 'spec_parent_name')
  final String? specParentName;
  @JsonKey(name: 'avatar')
  final String? avatar;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  static const fromJsonFactory = _$AnimalShortFromJson;
  static const toJsonFactory = _$AnimalShortToJson;
  Map<String, dynamic> toJson() => _$AnimalShortToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalShort &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.specName, specName) ||
                const DeepCollectionEquality().equals(other.specName, specName)) &&
            (identical(other.specParentName, specParentName) ||
                const DeepCollectionEquality().equals(other.specParentName, specParentName)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(other.defaultImageId, defaultImageId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(specName) ^
      const DeepCollectionEquality().hash(specParentName) ^
      const DeepCollectionEquality().hash(avatar) ^
      const DeepCollectionEquality().hash(defaultImageId) ^
      runtimeType.hashCode;
}

extension $AnimalShortExtension on AnimalShort {
  AnimalShort copyWith(
      {int? id,
      String? name,
      String? specName,
      String? specParentName,
      String? avatar,
      int? defaultImageId}) {
    return AnimalShort(
        id: id ?? this.id,
        name: name ?? this.name,
        specName: specName ?? this.specName,
        specParentName: specParentName ?? this.specParentName,
        avatar: avatar ?? this.avatar,
        defaultImageId: defaultImageId ?? this.defaultImageId);
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalWrite {
  AnimalWrite({
    this.name,
    this.images,
    this.validImages,
    this.specId,
    this.status,
    this.dateJoined,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    this.placeOfCatch,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.shelter,
    this.curatorId,
    this.applicantId,
    this.animalAttributes,
  });

  factory AnimalWrite.fromJson(Map<String, dynamic> json) => _$AnimalWriteFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'images', defaultValue: <AnimalImageWrite>[])
  final List<AnimalImageWrite>? images;
  @JsonKey(name: 'valid_images', defaultValue: <int>[])
  final List<int>? validImages;
  @JsonKey(name: 'spec_id')
  final int? specId;
  @JsonKey(name: 'status', toJson: status131EnumToJson, fromJson: status131EnumFromJson)
  final enums.Status131Enum? status;
  @JsonKey(name: 'date_joined', toJson: _dateToJson)
  final DateTime? dateJoined;
  @JsonKey(name: 'birth_date', toJson: _dateToJson)
  final DateTime? birthDate;
  @JsonKey(name: 'death_date', toJson: _dateToJson)
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String? placeOfCatch;
  @JsonKey(name: 'place_of_release')
  final String? placeOfRelease;
  @JsonKey(name: 'date_of_chipping', toJson: _dateToJson)
  final DateTime? dateOfChipping;
  @JsonKey(name: 'chipping_code')
  final String? chippingCode;
  @JsonKey(name: 'height')
  final String? height;
  @JsonKey(name: 'weight')
  final String? weight;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'curator_id')
  final int? curatorId;
  @JsonKey(name: 'applicant_id')
  final int? applicantId;
  @JsonKey(name: 'animal_attributes', defaultValue: <AnimalAttributeValue>[])
  final List<AnimalAttributeValue>? animalAttributes;
  static const fromJsonFactory = _$AnimalWriteFromJson;
  static const toJsonFactory = _$AnimalWriteToJson;
  Map<String, dynamic> toJson() => _$AnimalWriteToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnimalWrite &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.validImages, validImages) ||
                const DeepCollectionEquality().equals(other.validImages, validImages)) &&
            (identical(other.specId, specId) ||
                const DeepCollectionEquality().equals(other.specId, specId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(other.dateJoined, dateJoined)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality().equals(other.birthDate, birthDate)) &&
            (identical(other.deathDate, deathDate) ||
                const DeepCollectionEquality().equals(other.deathDate, deathDate)) &&
            (identical(other.deathReason, deathReason) ||
                const DeepCollectionEquality().equals(other.deathReason, deathReason)) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(other.defaultImageId, defaultImageId)) &&
            (identical(other.placeOfCatch, placeOfCatch) ||
                const DeepCollectionEquality().equals(other.placeOfCatch, placeOfCatch)) &&
            (identical(other.placeOfRelease, placeOfRelease) ||
                const DeepCollectionEquality().equals(other.placeOfRelease, placeOfRelease)) &&
            (identical(other.dateOfChipping, dateOfChipping) ||
                const DeepCollectionEquality().equals(other.dateOfChipping, dateOfChipping)) &&
            (identical(other.chippingCode, chippingCode) ||
                const DeepCollectionEquality().equals(other.chippingCode, chippingCode)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.curatorId, curatorId) ||
                const DeepCollectionEquality().equals(other.curatorId, curatorId)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(other.applicantId, applicantId)) &&
            (identical(other.animalAttributes, animalAttributes) ||
                const DeepCollectionEquality().equals(other.animalAttributes, animalAttributes)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(validImages) ^
      const DeepCollectionEquality().hash(specId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(deathDate) ^
      const DeepCollectionEquality().hash(deathReason) ^
      const DeepCollectionEquality().hash(defaultImageId) ^
      const DeepCollectionEquality().hash(placeOfCatch) ^
      const DeepCollectionEquality().hash(placeOfRelease) ^
      const DeepCollectionEquality().hash(dateOfChipping) ^
      const DeepCollectionEquality().hash(chippingCode) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(weight) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(curatorId) ^
      const DeepCollectionEquality().hash(applicantId) ^
      const DeepCollectionEquality().hash(animalAttributes) ^
      runtimeType.hashCode;
}

extension $AnimalWriteExtension on AnimalWrite {
  AnimalWrite copyWith(
      {String? name,
      List<AnimalImageWrite>? images,
      List<int>? validImages,
      int? specId,
      enums.Status131Enum? status,
      DateTime? dateJoined,
      DateTime? birthDate,
      DateTime? deathDate,
      String? deathReason,
      int? defaultImageId,
      String? placeOfCatch,
      String? placeOfRelease,
      DateTime? dateOfChipping,
      String? chippingCode,
      String? height,
      String? weight,
      int? shelter,
      int? curatorId,
      int? applicantId,
      List<AnimalAttributeValue>? animalAttributes}) {
    return AnimalWrite(
        name: name ?? this.name,
        images: images ?? this.images,
        validImages: validImages ?? this.validImages,
        specId: specId ?? this.specId,
        status: status ?? this.status,
        dateJoined: dateJoined ?? this.dateJoined,
        birthDate: birthDate ?? this.birthDate,
        deathDate: deathDate ?? this.deathDate,
        deathReason: deathReason ?? this.deathReason,
        defaultImageId: defaultImageId ?? this.defaultImageId,
        placeOfCatch: placeOfCatch ?? this.placeOfCatch,
        placeOfRelease: placeOfRelease ?? this.placeOfRelease,
        dateOfChipping: dateOfChipping ?? this.dateOfChipping,
        chippingCode: chippingCode ?? this.chippingCode,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        shelter: shelter ?? this.shelter,
        curatorId: curatorId ?? this.curatorId,
        applicantId: applicantId ?? this.applicantId,
        animalAttributes: animalAttributes ?? this.animalAttributes);
  }
}

@JsonSerializable(explicitToJson: true)
class Applicant {
  Applicant({
    this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.contactDetails,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.animalId,
    this.applicantFiles,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) => _$ApplicantFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'contact_details')
  final String? contactDetails;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'animal_id')
  final int? animalId;
  @JsonKey(name: 'applicant_files', defaultValue: <ApplicantFile>[])
  final List<ApplicantFile>? applicantFiles;
  static const fromJsonFactory = _$ApplicantFromJson;
  static const toJsonFactory = _$ApplicantToJson;
  Map<String, dynamic> toJson() => _$ApplicantToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Applicant &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.contactDetails, contactDetails) ||
                const DeepCollectionEquality().equals(other.contactDetails, contactDetails)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(other.updatedAt, updatedAt)) &&
            (identical(other.animalId, animalId) ||
                const DeepCollectionEquality().equals(other.animalId, animalId)) &&
            (identical(other.applicantFiles, applicantFiles) ||
                const DeepCollectionEquality().equals(other.applicantFiles, applicantFiles)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(contactDetails) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(animalId) ^
      const DeepCollectionEquality().hash(applicantFiles) ^
      runtimeType.hashCode;
}

extension $ApplicantExtension on Applicant {
  Applicant copyWith(
      {int? id,
      String? url,
      int? shelter,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? contactDetails,
      String? createdBy,
      String? updatedBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? animalId,
      List<ApplicantFile>? applicantFiles}) {
    return Applicant(
        id: id ?? this.id,
        url: url ?? this.url,
        shelter: shelter ?? this.shelter,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        contactDetails: contactDetails ?? this.contactDetails,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        animalId: animalId ?? this.animalId,
        applicantFiles: applicantFiles ?? this.applicantFiles);
  }
}

@JsonSerializable(explicitToJson: true)
class ApplicantFile {
  ApplicantFile({
    this.id,
    this.file,
    this.name,
    this.filename,
    this.createdAt,
  });

  factory ApplicantFile.fromJson(Map<String, dynamic> json) => _$ApplicantFileFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'file')
  final String? file;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$ApplicantFileFromJson;
  static const toJsonFactory = _$ApplicantFileToJson;
  Map<String, dynamic> toJson() => _$ApplicantFileToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ApplicantFile &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(other.filename, filename)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(filename) ^
      const DeepCollectionEquality().hash(createdAt) ^
      runtimeType.hashCode;
}

extension $ApplicantFileExtension on ApplicantFile {
  ApplicantFile copyWith(
      {int? id, String? file, String? name, String? filename, DateTime? createdAt}) {
    return ApplicantFile(
        id: id ?? this.id,
        file: file ?? this.file,
        name: name ?? this.name,
        filename: filename ?? this.filename,
        createdAt: createdAt ?? this.createdAt);
  }
}

@JsonSerializable(explicitToJson: true)
class Approve {
  Approve({
    this.status,
  });

  factory Approve.fromJson(Map<String, dynamic> json) => _$ApproveFromJson(json);

  @JsonKey(name: 'status')
  final String? status;
  static const fromJsonFactory = _$ApproveFromJson;
  static const toJsonFactory = _$ApproveToJson;
  Map<String, dynamic> toJson() => _$ApproveToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Approve &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $ApproveExtension on Approve {
  Approve copyWith({String? status}) {
    return Approve(status: status ?? this.status);
  }
}

@JsonSerializable(explicitToJson: true)
class Curator {
  Curator({
    this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Curator.fromJson(Map<String, dynamic> json) => _$CuratorFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$CuratorFromJson;
  static const toJsonFactory = _$CuratorToJson;
  Map<String, dynamic> toJson() => _$CuratorToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Curator &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $CuratorExtension on Curator {
  Curator copyWith(
      {int? id,
      String? url,
      String? shelter,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? address,
      String? createdBy,
      String? updatedBy,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return Curator(
        id: id ?? this.id,
        url: url ?? this.url,
        shelter: shelter ?? this.shelter,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}

@JsonSerializable(explicitToJson: true)
class Decline {
  Decline({
    this.status,
  });

  factory Decline.fromJson(Map<String, dynamic> json) => _$DeclineFromJson(json);

  @JsonKey(name: 'status')
  final String? status;
  static const fromJsonFactory = _$DeclineFromJson;
  static const toJsonFactory = _$DeclineToJson;
  Map<String, dynamic> toJson() => _$DeclineToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Decline &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $DeclineExtension on Decline {
  Decline copyWith({String? status}) {
    return Decline(status: status ?? this.status);
  }
}

@JsonSerializable(explicitToJson: true)
class Drug {
  Drug({
    this.id,
    this.name,
    this.usageInstruction,
    this.formOfDrug,
    this.formOfDrugName,
  });

  factory Drug.fromJson(Map<String, dynamic> json) => _$DrugFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'usage_instruction')
  final String? usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final int? formOfDrug;
  @JsonKey(name: 'form_of_drug_name')
  final String? formOfDrugName;
  static const fromJsonFactory = _$DrugFromJson;
  static const toJsonFactory = _$DrugToJson;
  Map<String, dynamic> toJson() => _$DrugToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Drug &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.usageInstruction, usageInstruction) ||
                const DeepCollectionEquality().equals(other.usageInstruction, usageInstruction)) &&
            (identical(other.formOfDrug, formOfDrug) ||
                const DeepCollectionEquality().equals(other.formOfDrug, formOfDrug)) &&
            (identical(other.formOfDrugName, formOfDrugName) ||
                const DeepCollectionEquality().equals(other.formOfDrugName, formOfDrugName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(usageInstruction) ^
      const DeepCollectionEquality().hash(formOfDrug) ^
      const DeepCollectionEquality().hash(formOfDrugName) ^
      runtimeType.hashCode;
}

extension $DrugExtension on Drug {
  Drug copyWith(
      {int? id, String? name, String? usageInstruction, int? formOfDrug, String? formOfDrugName}) {
    return Drug(
        id: id ?? this.id,
        name: name ?? this.name,
        usageInstruction: usageInstruction ?? this.usageInstruction,
        formOfDrug: formOfDrug ?? this.formOfDrug,
        formOfDrugName: formOfDrugName ?? this.formOfDrugName);
  }
}

@JsonSerializable(explicitToJson: true)
class Email {
  Email({
    this.email,
  });

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$EmailFromJson;
  static const toJsonFactory = _$EmailToJson;
  Map<String, dynamic> toJson() => _$EmailToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Email &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $EmailExtension on Email {
  Email copyWith({String? email}) {
    return Email(email: email ?? this.email);
  }
}

@JsonSerializable(explicitToJson: true)
class Feedback {
  Feedback({
    this.shelterId,
    this.shelterName,
    this.date,
    this.action,
    this.email,
    this.message,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);

  @JsonKey(name: 'shelter_id')
  final int? shelterId;
  @JsonKey(name: 'shelter_name')
  final String? shelterName;
  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(name: 'action')
  final String? action;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$FeedbackFromJson;
  static const toJsonFactory = _$FeedbackToJson;
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Feedback &&
            (identical(other.shelterId, shelterId) ||
                const DeepCollectionEquality().equals(other.shelterId, shelterId)) &&
            (identical(other.shelterName, shelterName) ||
                const DeepCollectionEquality().equals(other.shelterName, shelterName)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(shelterId) ^
      const DeepCollectionEquality().hash(shelterName) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(action) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $FeedbackExtension on Feedback {
  Feedback copyWith(
      {int? shelterId,
      String? shelterName,
      DateTime? date,
      String? action,
      String? email,
      String? message}) {
    return Feedback(
        shelterId: shelterId ?? this.shelterId,
        shelterName: shelterName ?? this.shelterName,
        date: date ?? this.date,
        action: action ?? this.action,
        email: email ?? this.email,
        message: message ?? this.message);
  }
}

@JsonSerializable(explicitToJson: true)
class ImageThumbnails {
  ImageThumbnails({
    this.large,
    this.medium,
    this.small,
  });

  factory ImageThumbnails.fromJson(Map<String, dynamic> json) => _$ImageThumbnailsFromJson(json);

  @JsonKey(name: 'large')
  final String? large;
  @JsonKey(name: 'medium')
  final String? medium;
  @JsonKey(name: 'small')
  final String? small;
  static const fromJsonFactory = _$ImageThumbnailsFromJson;
  static const toJsonFactory = _$ImageThumbnailsToJson;
  Map<String, dynamic> toJson() => _$ImageThumbnailsToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ImageThumbnails &&
            (identical(other.large, large) ||
                const DeepCollectionEquality().equals(other.large, large)) &&
            (identical(other.medium, medium) ||
                const DeepCollectionEquality().equals(other.medium, medium)) &&
            (identical(other.small, small) ||
                const DeepCollectionEquality().equals(other.small, small)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(large) ^
      const DeepCollectionEquality().hash(medium) ^
      const DeepCollectionEquality().hash(small) ^
      runtimeType.hashCode;
}

extension $ImageThumbnailsExtension on ImageThumbnails {
  ImageThumbnails copyWith({String? large, String? medium, String? small}) {
    return ImageThumbnails(
        large: large ?? this.large, medium: medium ?? this.medium, small: small ?? this.small);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalHistorySnapshotList {
  PaginatedAnimalHistorySnapshotList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalHistorySnapshotList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAnimalHistorySnapshotListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalHistorySnapshot>[])
  final List<AnimalHistorySnapshot>? results;
  static const fromJsonFactory = _$PaginatedAnimalHistorySnapshotListFromJson;
  static const toJsonFactory = _$PaginatedAnimalHistorySnapshotListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAnimalHistorySnapshotListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedAnimalHistorySnapshotList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalHistorySnapshotListExtension on PaginatedAnimalHistorySnapshotList {
  PaginatedAnimalHistorySnapshotList copyWith(
      {int? count, String? next, String? previous, List<AnimalHistorySnapshot>? results}) {
    return PaginatedAnimalHistorySnapshotList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalNoteList {
  PaginatedAnimalNoteList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalNoteList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAnimalNoteListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalNote>[])
  final List<AnimalNote>? results;
  static const fromJsonFactory = _$PaginatedAnimalNoteListFromJson;
  static const toJsonFactory = _$PaginatedAnimalNoteListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAnimalNoteListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedAnimalNoteList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalNoteListExtension on PaginatedAnimalNoteList {
  PaginatedAnimalNoteList copyWith(
      {int? count, String? next, String? previous, List<AnimalNote>? results}) {
    return PaginatedAnimalNoteList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalReadList {
  PaginatedAnimalReadList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalReadList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAnimalReadListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalRead>[])
  final List<AnimalRead>? results;
  static const fromJsonFactory = _$PaginatedAnimalReadListFromJson;
  static const toJsonFactory = _$PaginatedAnimalReadListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAnimalReadListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedAnimalReadList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalReadListExtension on PaginatedAnimalReadList {
  PaginatedAnimalReadList copyWith(
      {int? count, String? next, String? previous, List<AnimalRead>? results}) {
    return PaginatedAnimalReadList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedApplicantList {
  PaginatedApplicantList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedApplicantList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedApplicantListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Applicant>[])
  final List<Applicant>? results;
  static const fromJsonFactory = _$PaginatedApplicantListFromJson;
  static const toJsonFactory = _$PaginatedApplicantListToJson;
  Map<String, dynamic> toJson() => _$PaginatedApplicantListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedApplicantList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedApplicantListExtension on PaginatedApplicantList {
  PaginatedApplicantList copyWith(
      {int? count, String? next, String? previous, List<Applicant>? results}) {
    return PaginatedApplicantList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedCuratorList {
  PaginatedCuratorList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedCuratorList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedCuratorListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Curator>[])
  final List<Curator>? results;
  static const fromJsonFactory = _$PaginatedCuratorListFromJson;
  static const toJsonFactory = _$PaginatedCuratorListToJson;
  Map<String, dynamic> toJson() => _$PaginatedCuratorListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedCuratorList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedCuratorListExtension on PaginatedCuratorList {
  PaginatedCuratorList copyWith(
      {int? count, String? next, String? previous, List<Curator>? results}) {
    return PaginatedCuratorList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedPrescriptionExecutionTodayList {
  PaginatedPrescriptionExecutionTodayList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedPrescriptionExecutionTodayList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPrescriptionExecutionTodayListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <PrescriptionExecutionToday>[])
  final List<PrescriptionExecutionToday>? results;
  static const fromJsonFactory = _$PaginatedPrescriptionExecutionTodayListFromJson;
  static const toJsonFactory = _$PaginatedPrescriptionExecutionTodayListToJson;
  Map<String, dynamic> toJson() => _$PaginatedPrescriptionExecutionTodayListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedPrescriptionExecutionTodayList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedPrescriptionExecutionTodayListExtension
    on PaginatedPrescriptionExecutionTodayList {
  PaginatedPrescriptionExecutionTodayList copyWith(
      {int? count, String? next, String? previous, List<PrescriptionExecutionToday>? results}) {
    return PaginatedPrescriptionExecutionTodayList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedPrescriptionList {
  PaginatedPrescriptionList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedPrescriptionList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPrescriptionListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Prescription>[])
  final List<Prescription>? results;
  static const fromJsonFactory = _$PaginatedPrescriptionListFromJson;
  static const toJsonFactory = _$PaginatedPrescriptionListToJson;
  Map<String, dynamic> toJson() => _$PaginatedPrescriptionListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedPrescriptionList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedPrescriptionListExtension on PaginatedPrescriptionList {
  PaginatedPrescriptionList copyWith(
      {int? count, String? next, String? previous, List<Prescription>? results}) {
    return PaginatedPrescriptionList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedShelterDrugList {
  PaginatedShelterDrugList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedShelterDrugList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedShelterDrugListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <ShelterDrug>[])
  final List<ShelterDrug>? results;
  static const fromJsonFactory = _$PaginatedShelterDrugListFromJson;
  static const toJsonFactory = _$PaginatedShelterDrugListToJson;
  Map<String, dynamic> toJson() => _$PaginatedShelterDrugListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedShelterDrugList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedShelterDrugListExtension on PaginatedShelterDrugList {
  PaginatedShelterDrugList copyWith(
      {int? count, String? next, String? previous, List<ShelterDrug>? results}) {
    return PaginatedShelterDrugList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedShelterShortSerializersList {
  PaginatedShelterShortSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedShelterShortSerializersList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedShelterShortSerializersListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <ShelterShortSerializers>[])
  final List<ShelterShortSerializers>? results;
  static const fromJsonFactory = _$PaginatedShelterShortSerializersListFromJson;
  static const toJsonFactory = _$PaginatedShelterShortSerializersListToJson;
  Map<String, dynamic> toJson() => _$PaginatedShelterShortSerializersListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedShelterShortSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedShelterShortSerializersListExtension on PaginatedShelterShortSerializersList {
  PaginatedShelterShortSerializersList copyWith(
      {int? count, String? next, String? previous, List<ShelterShortSerializers>? results}) {
    return PaginatedShelterShortSerializersList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedSpeciesList {
  PaginatedSpeciesList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedSpeciesList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedSpeciesListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Species>[])
  final List<Species>? results;
  static const fromJsonFactory = _$PaginatedSpeciesListFromJson;
  static const toJsonFactory = _$PaginatedSpeciesListToJson;
  Map<String, dynamic> toJson() => _$PaginatedSpeciesListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedSpeciesList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedSpeciesListExtension on PaginatedSpeciesList {
  PaginatedSpeciesList copyWith(
      {int? count, String? next, String? previous, List<Species>? results}) {
    return PaginatedSpeciesList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedUserSheltersAdminSerializersList {
  PaginatedUserSheltersAdminSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedUserSheltersAdminSerializersList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedUserSheltersAdminSerializersListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <UserSheltersAdminSerializers>[])
  final List<UserSheltersAdminSerializers>? results;
  static const fromJsonFactory = _$PaginatedUserSheltersAdminSerializersListFromJson;
  static const toJsonFactory = _$PaginatedUserSheltersAdminSerializersListToJson;
  Map<String, dynamic> toJson() => _$PaginatedUserSheltersAdminSerializersListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedUserSheltersAdminSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedUserSheltersAdminSerializersListExtension
    on PaginatedUserSheltersAdminSerializersList {
  PaginatedUserSheltersAdminSerializersList copyWith(
      {int? count, String? next, String? previous, List<UserSheltersAdminSerializers>? results}) {
    return PaginatedUserSheltersAdminSerializersList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedUserShortSerializersList {
  PaginatedUserShortSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedUserShortSerializersList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedUserShortSerializersListFromJson(json);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <UserShortSerializers>[])
  final List<UserShortSerializers>? results;
  static const fromJsonFactory = _$PaginatedUserShortSerializersListFromJson;
  static const toJsonFactory = _$PaginatedUserShortSerializersListToJson;
  Map<String, dynamic> toJson() => _$PaginatedUserShortSerializersListToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginatedUserShortSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedUserShortSerializersListExtension on PaginatedUserShortSerializersList {
  PaginatedUserShortSerializersList copyWith(
      {int? count, String? next, String? previous, List<UserShortSerializers>? results}) {
    return PaginatedUserShortSerializersList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAnimalNote {
  PatchedAnimalNote({
    this.id,
    this.url,
    this.animal,
    this.content,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isUserCanEditOrDelete,
  });

  factory PatchedAnimalNote.fromJson(Map<String, dynamic> json) =>
      _$PatchedAnimalNoteFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'files', defaultValue: <AnimalNoteFile>[])
  final List<AnimalNoteFile>? files;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'is_user_can_edit_or_delete')
  final bool? isUserCanEditOrDelete;
  static const fromJsonFactory = _$PatchedAnimalNoteFromJson;
  static const toJsonFactory = _$PatchedAnimalNoteToJson;
  Map<String, dynamic> toJson() => _$PatchedAnimalNoteToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedAnimalNote &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(other.updatedAt, updatedAt)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.isUserCanEditOrDelete, isUserCanEditOrDelete) ||
                const DeepCollectionEquality()
                    .equals(other.isUserCanEditOrDelete, isUserCanEditOrDelete)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(files) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(isUserCanEditOrDelete) ^
      runtimeType.hashCode;
}

extension $PatchedAnimalNoteExtension on PatchedAnimalNote {
  PatchedAnimalNote copyWith(
      {int? id,
      String? url,
      int? animal,
      String? content,
      List<AnimalNoteFile>? files,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? createdBy,
      String? updatedBy,
      bool? isUserCanEditOrDelete}) {
    return PatchedAnimalNote(
        id: id ?? this.id,
        url: url ?? this.url,
        animal: animal ?? this.animal,
        content: content ?? this.content,
        files: files ?? this.files,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        isUserCanEditOrDelete: isUserCanEditOrDelete ?? this.isUserCanEditOrDelete);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAnimalWrite {
  PatchedAnimalWrite({
    this.name,
    this.images,
    this.validImages,
    this.specId,
    this.status,
    this.dateJoined,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    this.placeOfCatch,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.shelter,
    this.curatorId,
    this.applicantId,
    this.animalAttributes,
  });

  factory PatchedAnimalWrite.fromJson(Map<String, dynamic> json) =>
      _$PatchedAnimalWriteFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'images', defaultValue: <AnimalImageWrite>[])
  final List<AnimalImageWrite>? images;
  @JsonKey(name: 'valid_images', defaultValue: <int>[])
  final List<int>? validImages;
  @JsonKey(name: 'spec_id')
  final int? specId;
  @JsonKey(name: 'status', toJson: status131EnumToJson, fromJson: status131EnumFromJson)
  final enums.Status131Enum? status;
  @JsonKey(name: 'date_joined', toJson: _dateToJson)
  final DateTime? dateJoined;
  @JsonKey(name: 'birth_date', toJson: _dateToJson)
  final DateTime? birthDate;
  @JsonKey(name: 'death_date', toJson: _dateToJson)
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String? placeOfCatch;
  @JsonKey(name: 'place_of_release')
  final String? placeOfRelease;
  @JsonKey(name: 'date_of_chipping', toJson: _dateToJson)
  final DateTime? dateOfChipping;
  @JsonKey(name: 'chipping_code')
  final String? chippingCode;
  @JsonKey(name: 'height')
  final String? height;
  @JsonKey(name: 'weight')
  final String? weight;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'curator_id')
  final int? curatorId;
  @JsonKey(name: 'applicant_id')
  final int? applicantId;
  @JsonKey(name: 'animal_attributes', defaultValue: <AnimalAttributeValue>[])
  final List<AnimalAttributeValue>? animalAttributes;
  static const fromJsonFactory = _$PatchedAnimalWriteFromJson;
  static const toJsonFactory = _$PatchedAnimalWriteToJson;
  Map<String, dynamic> toJson() => _$PatchedAnimalWriteToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedAnimalWrite &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.validImages, validImages) ||
                const DeepCollectionEquality().equals(other.validImages, validImages)) &&
            (identical(other.specId, specId) ||
                const DeepCollectionEquality().equals(other.specId, specId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(other.dateJoined, dateJoined)) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality().equals(other.birthDate, birthDate)) &&
            (identical(other.deathDate, deathDate) ||
                const DeepCollectionEquality().equals(other.deathDate, deathDate)) &&
            (identical(other.deathReason, deathReason) ||
                const DeepCollectionEquality().equals(other.deathReason, deathReason)) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(other.defaultImageId, defaultImageId)) &&
            (identical(other.placeOfCatch, placeOfCatch) ||
                const DeepCollectionEquality().equals(other.placeOfCatch, placeOfCatch)) &&
            (identical(other.placeOfRelease, placeOfRelease) ||
                const DeepCollectionEquality().equals(other.placeOfRelease, placeOfRelease)) &&
            (identical(other.dateOfChipping, dateOfChipping) ||
                const DeepCollectionEquality().equals(other.dateOfChipping, dateOfChipping)) &&
            (identical(other.chippingCode, chippingCode) ||
                const DeepCollectionEquality().equals(other.chippingCode, chippingCode)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.curatorId, curatorId) ||
                const DeepCollectionEquality().equals(other.curatorId, curatorId)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(other.applicantId, applicantId)) &&
            (identical(other.animalAttributes, animalAttributes) ||
                const DeepCollectionEquality().equals(other.animalAttributes, animalAttributes)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(validImages) ^
      const DeepCollectionEquality().hash(specId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(birthDate) ^
      const DeepCollectionEquality().hash(deathDate) ^
      const DeepCollectionEquality().hash(deathReason) ^
      const DeepCollectionEquality().hash(defaultImageId) ^
      const DeepCollectionEquality().hash(placeOfCatch) ^
      const DeepCollectionEquality().hash(placeOfRelease) ^
      const DeepCollectionEquality().hash(dateOfChipping) ^
      const DeepCollectionEquality().hash(chippingCode) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(weight) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(curatorId) ^
      const DeepCollectionEquality().hash(applicantId) ^
      const DeepCollectionEquality().hash(animalAttributes) ^
      runtimeType.hashCode;
}

extension $PatchedAnimalWriteExtension on PatchedAnimalWrite {
  PatchedAnimalWrite copyWith(
      {String? name,
      List<AnimalImageWrite>? images,
      List<int>? validImages,
      int? specId,
      enums.Status131Enum? status,
      DateTime? dateJoined,
      DateTime? birthDate,
      DateTime? deathDate,
      String? deathReason,
      int? defaultImageId,
      String? placeOfCatch,
      String? placeOfRelease,
      DateTime? dateOfChipping,
      String? chippingCode,
      String? height,
      String? weight,
      int? shelter,
      int? curatorId,
      int? applicantId,
      List<AnimalAttributeValue>? animalAttributes}) {
    return PatchedAnimalWrite(
        name: name ?? this.name,
        images: images ?? this.images,
        validImages: validImages ?? this.validImages,
        specId: specId ?? this.specId,
        status: status ?? this.status,
        dateJoined: dateJoined ?? this.dateJoined,
        birthDate: birthDate ?? this.birthDate,
        deathDate: deathDate ?? this.deathDate,
        deathReason: deathReason ?? this.deathReason,
        defaultImageId: defaultImageId ?? this.defaultImageId,
        placeOfCatch: placeOfCatch ?? this.placeOfCatch,
        placeOfRelease: placeOfRelease ?? this.placeOfRelease,
        dateOfChipping: dateOfChipping ?? this.dateOfChipping,
        chippingCode: chippingCode ?? this.chippingCode,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        shelter: shelter ?? this.shelter,
        curatorId: curatorId ?? this.curatorId,
        applicantId: applicantId ?? this.applicantId,
        animalAttributes: animalAttributes ?? this.animalAttributes);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedApplicant {
  PatchedApplicant({
    this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.contactDetails,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.animalId,
    this.applicantFiles,
  });

  factory PatchedApplicant.fromJson(Map<String, dynamic> json) => _$PatchedApplicantFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'contact_details')
  final String? contactDetails;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'animal_id')
  final int? animalId;
  @JsonKey(name: 'applicant_files', defaultValue: <ApplicantFile>[])
  final List<ApplicantFile>? applicantFiles;
  static const fromJsonFactory = _$PatchedApplicantFromJson;
  static const toJsonFactory = _$PatchedApplicantToJson;
  Map<String, dynamic> toJson() => _$PatchedApplicantToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedApplicant &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.contactDetails, contactDetails) ||
                const DeepCollectionEquality().equals(other.contactDetails, contactDetails)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(other.updatedAt, updatedAt)) &&
            (identical(other.animalId, animalId) ||
                const DeepCollectionEquality().equals(other.animalId, animalId)) &&
            (identical(other.applicantFiles, applicantFiles) ||
                const DeepCollectionEquality().equals(other.applicantFiles, applicantFiles)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(contactDetails) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(animalId) ^
      const DeepCollectionEquality().hash(applicantFiles) ^
      runtimeType.hashCode;
}

extension $PatchedApplicantExtension on PatchedApplicant {
  PatchedApplicant copyWith(
      {int? id,
      String? url,
      int? shelter,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? contactDetails,
      String? createdBy,
      String? updatedBy,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? animalId,
      List<ApplicantFile>? applicantFiles}) {
    return PatchedApplicant(
        id: id ?? this.id,
        url: url ?? this.url,
        shelter: shelter ?? this.shelter,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        contactDetails: contactDetails ?? this.contactDetails,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        animalId: animalId ?? this.animalId,
        applicantFiles: applicantFiles ?? this.applicantFiles);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedCurator {
  PatchedCurator({
    this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PatchedCurator.fromJson(Map<String, dynamic> json) => _$PatchedCuratorFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$PatchedCuratorFromJson;
  static const toJsonFactory = _$PatchedCuratorToJson;
  Map<String, dynamic> toJson() => _$PatchedCuratorToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedCurator &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $PatchedCuratorExtension on PatchedCurator {
  PatchedCurator copyWith(
      {int? id,
      String? url,
      String? shelter,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? address,
      String? createdBy,
      String? updatedBy,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return PatchedCurator(
        id: id ?? this.id,
        url: url ?? this.url,
        shelter: shelter ?? this.shelter,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedPrescription {
  PatchedPrescription({
    this.id,
    this.url,
    this.animal,
    this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.drugs,
    this.executions,
    this.files,
  });

  factory PatchedPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(name: 'myType')
  final dynamic myType;
  @JsonKey(name: 'duration', toJson: durationEnumToJson, fromJson: durationEnumFromJson)
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug>? drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution>? executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$PatchedPrescriptionFromJson;
  static const toJsonFactory = _$PatchedPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedPrescriptionToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedPrescription &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(other.duration, duration)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(other.description, description)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(other.executions, executions)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(myType) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(drugs) ^
      const DeepCollectionEquality().hash(executions) ^
      const DeepCollectionEquality().hash(files) ^
      runtimeType.hashCode;
}

extension $PatchedPrescriptionExtension on PatchedPrescription {
  PatchedPrescription copyWith(
      {int? id,
      String? url,
      int? animal,
      dynamic? myType,
      enums.DurationEnum? duration,
      String? description,
      String? createdBy,
      String? updatedBy,
      List<PrescriptionDrug>? drugs,
      List<PrescriptionExecution>? executions,
      List<PrescriptionFile>? files}) {
    return PatchedPrescription(
        id: id ?? this.id,
        url: url ?? this.url,
        animal: animal ?? this.animal,
        myType: myType ?? this.myType,
        duration: duration ?? this.duration,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        drugs: drugs ?? this.drugs,
        executions: executions ?? this.executions,
        files: files ?? this.files);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedUserChangePasswordSerializers {
  PatchedUserChangePasswordSerializers({
    this.id,
    this.password,
    this.rePassword,
    this.oldPassword,
  });

  factory PatchedUserChangePasswordSerializers.fromJson(Map<String, dynamic> json) =>
      _$PatchedUserChangePasswordSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'old_password')
  final String? oldPassword;
  static const fromJsonFactory = _$PatchedUserChangePasswordSerializersFromJson;
  static const toJsonFactory = _$PatchedUserChangePasswordSerializersToJson;
  Map<String, dynamic> toJson() => _$PatchedUserChangePasswordSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedUserChangePasswordSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(other.password, password)) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(other.rePassword, rePassword)) &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality().equals(other.oldPassword, oldPassword)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(rePassword) ^
      const DeepCollectionEquality().hash(oldPassword) ^
      runtimeType.hashCode;
}

extension $PatchedUserChangePasswordSerializersExtension on PatchedUserChangePasswordSerializers {
  PatchedUserChangePasswordSerializers copyWith(
      {int? id, String? password, String? rePassword, String? oldPassword}) {
    return PatchedUserChangePasswordSerializers(
        id: id ?? this.id,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword,
        oldPassword: oldPassword ?? this.oldPassword);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedUserSerializers {
  PatchedUserSerializers({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.fathersName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.dateJoined,
    this.isVerified,
  });

  factory PatchedUserSerializers.fromJson(Map<String, dynamic> json) =>
      _$PatchedUserSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'date_joined')
  final DateTime? dateJoined;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  static const fromJsonFactory = _$PatchedUserSerializersFromJson;
  static const toJsonFactory = _$PatchedUserSerializersToJson;
  Map<String, dynamic> toJson() => _$PatchedUserSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedUserSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(other.username, username)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(other.fathersName, fathersName)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(other.dateJoined, dateJoined)) &&
            (identical(other.isVerified, isVerified) ||
                const DeepCollectionEquality().equals(other.isVerified, isVerified)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(fathersName) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(isVerified) ^
      runtimeType.hashCode;
}

extension $PatchedUserSerializersExtension on PatchedUserSerializers {
  PatchedUserSerializers copyWith(
      {int? id,
      String? username,
      String? firstName,
      String? lastName,
      String? fathersName,
      String? fullName,
      String? email,
      String? phoneNumber,
      String? address,
      DateTime? dateJoined,
      bool? isVerified}) {
    return PatchedUserSerializers(
        id: id ?? this.id,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fathersName: fathersName ?? this.fathersName,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        dateJoined: dateJoined ?? this.dateJoined,
        isVerified: isVerified ?? this.isVerified);
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedUserSheltersAdminSerializers {
  PatchedUserSheltersAdminSerializers({
    this.id,
    this.user,
    this.userId,
    this.role,
    this.isVerifiedByAdmin,
  });

  factory PatchedUserSheltersAdminSerializers.fromJson(Map<String, dynamic> json) =>
      _$PatchedUserSheltersAdminSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'user')
  final dynamic user;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'role', toJson: roleEnumToJson, fromJson: roleEnumFromJson)
  final enums.RoleEnum? role;
  @JsonKey(name: 'is_verified_by_admin')
  final bool? isVerifiedByAdmin;
  static const fromJsonFactory = _$PatchedUserSheltersAdminSerializersFromJson;
  static const toJsonFactory = _$PatchedUserSheltersAdminSerializersToJson;
  Map<String, dynamic> toJson() => _$PatchedUserSheltersAdminSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PatchedUserSheltersAdminSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.isVerifiedByAdmin, isVerifiedByAdmin) ||
                const DeepCollectionEquality().equals(other.isVerifiedByAdmin, isVerifiedByAdmin)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(isVerifiedByAdmin) ^
      runtimeType.hashCode;
}

extension $PatchedUserSheltersAdminSerializersExtension on PatchedUserSheltersAdminSerializers {
  PatchedUserSheltersAdminSerializers copyWith(
      {int? id, dynamic? user, int? userId, enums.RoleEnum? role, bool? isVerifiedByAdmin}) {
    return PatchedUserSheltersAdminSerializers(
        id: id ?? this.id,
        user: user ?? this.user,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        isVerifiedByAdmin: isVerifiedByAdmin ?? this.isVerifiedByAdmin);
  }
}

@JsonSerializable(explicitToJson: true)
class Prescription {
  Prescription({
    this.id,
    this.url,
    this.animal,
    this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.drugs,
    this.executions,
    this.files,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => _$PrescriptionFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(name: 'myType')
  final dynamic myType;
  @JsonKey(name: 'duration', toJson: durationEnumToJson, fromJson: durationEnumFromJson)
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug>? drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution>? executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$PrescriptionFromJson;
  static const toJsonFactory = _$PrescriptionToJson;
  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Prescription &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) || const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(other.duration, duration)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(other.description, description)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(other.executions, executions)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(myType) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(drugs) ^
      const DeepCollectionEquality().hash(executions) ^
      const DeepCollectionEquality().hash(files) ^
      runtimeType.hashCode;
}

extension $PrescriptionExtension on Prescription {
  Prescription copyWith(
      {int? id,
      String? url,
      int? animal,
      dynamic? myType,
      enums.DurationEnum? duration,
      String? description,
      String? createdBy,
      String? updatedBy,
      List<PrescriptionDrug>? drugs,
      List<PrescriptionExecution>? executions,
      List<PrescriptionFile>? files}) {
    return Prescription(
        id: id ?? this.id,
        url: url ?? this.url,
        animal: animal ?? this.animal,
        myType: myType ?? this.myType,
        duration: duration ?? this.duration,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        drugs: drugs ?? this.drugs,
        executions: executions ?? this.executions,
        files: files ?? this.files);
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionDrug {
  PrescriptionDrug({
    this.drugId,
    this.drugName,
    this.usageInstruction,
    this.formOfDrug,
    this.drugDosage,
  });

  factory PrescriptionDrug.fromJson(Map<String, dynamic> json) => _$PrescriptionDrugFromJson(json);

  @JsonKey(name: 'drug_id')
  final int? drugId;
  @JsonKey(name: 'drug_name')
  final String? drugName;
  @JsonKey(name: 'usage_instruction')
  final String? usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final String? formOfDrug;
  @JsonKey(name: 'drug_dosage')
  final double? drugDosage;
  static const fromJsonFactory = _$PrescriptionDrugFromJson;
  static const toJsonFactory = _$PrescriptionDrugToJson;
  Map<String, dynamic> toJson() => _$PrescriptionDrugToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrescriptionDrug &&
            (identical(other.drugId, drugId) ||
                const DeepCollectionEquality().equals(other.drugId, drugId)) &&
            (identical(other.drugName, drugName) ||
                const DeepCollectionEquality().equals(other.drugName, drugName)) &&
            (identical(other.usageInstruction, usageInstruction) ||
                const DeepCollectionEquality().equals(other.usageInstruction, usageInstruction)) &&
            (identical(other.formOfDrug, formOfDrug) ||
                const DeepCollectionEquality().equals(other.formOfDrug, formOfDrug)) &&
            (identical(other.drugDosage, drugDosage) ||
                const DeepCollectionEquality().equals(other.drugDosage, drugDosage)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(drugId) ^
      const DeepCollectionEquality().hash(drugName) ^
      const DeepCollectionEquality().hash(usageInstruction) ^
      const DeepCollectionEquality().hash(formOfDrug) ^
      const DeepCollectionEquality().hash(drugDosage) ^
      runtimeType.hashCode;
}

extension $PrescriptionDrugExtension on PrescriptionDrug {
  PrescriptionDrug copyWith(
      {int? drugId,
      String? drugName,
      String? usageInstruction,
      String? formOfDrug,
      double? drugDosage}) {
    return PrescriptionDrug(
        drugId: drugId ?? this.drugId,
        drugName: drugName ?? this.drugName,
        usageInstruction: usageInstruction ?? this.usageInstruction,
        formOfDrug: formOfDrug ?? this.formOfDrug,
        drugDosage: drugDosage ?? this.drugDosage);
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionExecution {
  PrescriptionExecution({
    this.id,
    this.executeAt,
    this.status,
  });

  factory PrescriptionExecution.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionExecutionFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'execute_at')
  final DateTime? executeAt;
  @JsonKey(name: 'status')
  final dynamic status;
  static const fromJsonFactory = _$PrescriptionExecutionFromJson;
  static const toJsonFactory = _$PrescriptionExecutionToJson;
  Map<String, dynamic> toJson() => _$PrescriptionExecutionToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrescriptionExecution &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.executeAt, executeAt) ||
                const DeepCollectionEquality().equals(other.executeAt, executeAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(executeAt) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $PrescriptionExecutionExtension on PrescriptionExecution {
  PrescriptionExecution copyWith({int? id, DateTime? executeAt, dynamic? status}) {
    return PrescriptionExecution(
        id: id ?? this.id, executeAt: executeAt ?? this.executeAt, status: status ?? this.status);
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionExecutionToday {
  PrescriptionExecutionToday({
    this.id,
    this.prescription,
    this.executeAt,
  });

  factory PrescriptionExecutionToday.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionExecutionTodayFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'prescription')
  final PrescriptionShort? prescription;
  @JsonKey(name: 'execute_at')
  final DateTime? executeAt;
  static const fromJsonFactory = _$PrescriptionExecutionTodayFromJson;
  static const toJsonFactory = _$PrescriptionExecutionTodayToJson;
  Map<String, dynamic> toJson() => _$PrescriptionExecutionTodayToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrescriptionExecutionToday &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.prescription, prescription) ||
                const DeepCollectionEquality().equals(other.prescription, prescription)) &&
            (identical(other.executeAt, executeAt) ||
                const DeepCollectionEquality().equals(other.executeAt, executeAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(prescription) ^
      const DeepCollectionEquality().hash(executeAt) ^
      runtimeType.hashCode;
}

extension $PrescriptionExecutionTodayExtension on PrescriptionExecutionToday {
  PrescriptionExecutionToday copyWith(
      {int? id, PrescriptionShort? prescription, DateTime? executeAt}) {
    return PrescriptionExecutionToday(
        id: id ?? this.id,
        prescription: prescription ?? this.prescription,
        executeAt: executeAt ?? this.executeAt);
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionFile {
  PrescriptionFile({
    this.id,
    this.file,
    this.name,
    this.filename,
    this.createdAt,
  });

  factory PrescriptionFile.fromJson(Map<String, dynamic> json) => _$PrescriptionFileFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'file')
  final String? file;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$PrescriptionFileFromJson;
  static const toJsonFactory = _$PrescriptionFileToJson;
  Map<String, dynamic> toJson() => _$PrescriptionFileToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrescriptionFile &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(other.filename, filename)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(filename) ^
      const DeepCollectionEquality().hash(createdAt) ^
      runtimeType.hashCode;
}

extension $PrescriptionFileExtension on PrescriptionFile {
  PrescriptionFile copyWith(
      {int? id, String? file, String? name, String? filename, DateTime? createdAt}) {
    return PrescriptionFile(
        id: id ?? this.id,
        file: file ?? this.file,
        name: name ?? this.name,
        filename: filename ?? this.filename,
        createdAt: createdAt ?? this.createdAt);
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionShort {
  PrescriptionShort({
    this.id,
    this.myType,
    this.description,
    this.animal,
    this.drugs,
    this.createdBy,
    this.updatedBy,
  });

  factory PrescriptionShort.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionShortFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'my_type')
  final dynamic myType;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'animal')
  final AnimalShort? animal;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug>? drugs;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  static const fromJsonFactory = _$PrescriptionShortFromJson;
  static const toJsonFactory = _$PrescriptionShortToJson;
  Map<String, dynamic> toJson() => _$PrescriptionShortToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrescriptionShort &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(other.description, description)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(other.updatedBy, updatedBy)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(myType) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(drugs) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      runtimeType.hashCode;
}

extension $PrescriptionShortExtension on PrescriptionShort {
  PrescriptionShort copyWith(
      {int? id,
      dynamic? myType,
      String? description,
      AnimalShort? animal,
      List<PrescriptionDrug>? drugs,
      String? createdBy,
      String? updatedBy}) {
    return PrescriptionShort(
        id: id ?? this.id,
        myType: myType ?? this.myType,
        description: description ?? this.description,
        animal: animal ?? this.animal,
        drugs: drugs ?? this.drugs,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy);
  }
}

@JsonSerializable(explicitToJson: true)
class ShelterDrug {
  ShelterDrug({
    this.drug,
    this.drugResiduesCount,
  });

  factory ShelterDrug.fromJson(Map<String, dynamic> json) => _$ShelterDrugFromJson(json);

  @JsonKey(name: 'drug')
  final Drug? drug;
  @JsonKey(name: 'drug_residues_count')
  final int? drugResiduesCount;
  static const fromJsonFactory = _$ShelterDrugFromJson;
  static const toJsonFactory = _$ShelterDrugToJson;
  Map<String, dynamic> toJson() => _$ShelterDrugToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ShelterDrug &&
            (identical(other.drug, drug) ||
                const DeepCollectionEquality().equals(other.drug, drug)) &&
            (identical(other.drugResiduesCount, drugResiduesCount) ||
                const DeepCollectionEquality().equals(other.drugResiduesCount, drugResiduesCount)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(drug) ^
      const DeepCollectionEquality().hash(drugResiduesCount) ^
      runtimeType.hashCode;
}

extension $ShelterDrugExtension on ShelterDrug {
  ShelterDrug copyWith({Drug? drug, int? drugResiduesCount}) {
    return ShelterDrug(
        drug: drug ?? this.drug, drugResiduesCount: drugResiduesCount ?? this.drugResiduesCount);
  }
}

@JsonSerializable(explicitToJson: true)
class ShelterSerializers {
  ShelterSerializers({
    this.name,
    this.country,
    this.city,
    this.state,
    this.region,
    this.street,
    this.house,
    this.apartment,
  });

  factory ShelterSerializers.fromJson(Map<String, dynamic> json) =>
      _$ShelterSerializersFromJson(json);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'region')
  final String? region;
  @JsonKey(name: 'street')
  final String? street;
  @JsonKey(name: 'house')
  final String? house;
  @JsonKey(name: 'apartment')
  final String? apartment;
  static const fromJsonFactory = _$ShelterSerializersFromJson;
  static const toJsonFactory = _$ShelterSerializersToJson;
  Map<String, dynamic> toJson() => _$ShelterSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ShelterSerializers &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality().equals(other.country, country)) &&
            (identical(other.city, city) ||
                const DeepCollectionEquality().equals(other.city, city)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.region, region) ||
                const DeepCollectionEquality().equals(other.region, region)) &&
            (identical(other.street, street) ||
                const DeepCollectionEquality().equals(other.street, street)) &&
            (identical(other.house, house) ||
                const DeepCollectionEquality().equals(other.house, house)) &&
            (identical(other.apartment, apartment) ||
                const DeepCollectionEquality().equals(other.apartment, apartment)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(region) ^
      const DeepCollectionEquality().hash(street) ^
      const DeepCollectionEquality().hash(house) ^
      const DeepCollectionEquality().hash(apartment) ^
      runtimeType.hashCode;
}

extension $ShelterSerializersExtension on ShelterSerializers {
  ShelterSerializers copyWith(
      {String? name,
      String? country,
      String? city,
      String? state,
      String? region,
      String? street,
      String? house,
      String? apartment}) {
    return ShelterSerializers(
        name: name ?? this.name,
        country: country ?? this.country,
        city: city ?? this.city,
        state: state ?? this.state,
        region: region ?? this.region,
        street: street ?? this.street,
        house: house ?? this.house,
        apartment: apartment ?? this.apartment);
  }
}

@JsonSerializable(explicitToJson: true)
class ShelterShortSerializers {
  ShelterShortSerializers({
    this.id,
    this.name,
  });

  factory ShelterShortSerializers.fromJson(Map<String, dynamic> json) =>
      _$ShelterShortSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$ShelterShortSerializersFromJson;
  static const toJsonFactory = _$ShelterShortSerializersToJson;
  Map<String, dynamic> toJson() => _$ShelterShortSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ShelterShortSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $ShelterShortSerializersExtension on ShelterShortSerializers {
  ShelterShortSerializers copyWith({int? id, String? name}) {
    return ShelterShortSerializers(id: id ?? this.id, name: name ?? this.name);
  }
}

@JsonSerializable(explicitToJson: true)
class Species {
  Species({
    this.id,
    this.name,
    this.level,
    this.parentId,
    this.parentName,
    this.categoryName,
  });

  factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'level')
  final dynamic level;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'parent_name')
  final String? parentName;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  static const fromJsonFactory = _$SpeciesFromJson;
  static const toJsonFactory = _$SpeciesToJson;
  Map<String, dynamic> toJson() => _$SpeciesToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Species &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)) &&
            (identical(other.parentId, parentId) ||
                const DeepCollectionEquality().equals(other.parentId, parentId)) &&
            (identical(other.parentName, parentName) ||
                const DeepCollectionEquality().equals(other.parentName, parentName)) &&
            (identical(other.categoryName, categoryName) ||
                const DeepCollectionEquality().equals(other.categoryName, categoryName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(level) ^
      const DeepCollectionEquality().hash(parentId) ^
      const DeepCollectionEquality().hash(parentName) ^
      const DeepCollectionEquality().hash(categoryName) ^
      runtimeType.hashCode;
}

extension $SpeciesExtension on Species {
  Species copyWith(
      {int? id,
      String? name,
      dynamic? level,
      int? parentId,
      String? parentName,
      String? categoryName}) {
    return Species(
        id: id ?? this.id,
        name: name ?? this.name,
        level: level ?? this.level,
        parentId: parentId ?? this.parentId,
        parentName: parentName ?? this.parentName,
        categoryName: categoryName ?? this.categoryName);
  }
}

@JsonSerializable(explicitToJson: true)
class Status {
  Status({
    this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  @JsonKey(name: 'status')
  final String? status;
  static const fromJsonFactory = _$StatusFromJson;
  static const toJsonFactory = _$StatusToJson;
  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Status &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $StatusExtension on Status {
  Status copyWith({String? status}) {
    return Status(status: status ?? this.status);
  }
}

@JsonSerializable(explicitToJson: true)
class TokenObtainPair {
  TokenObtainPair({
    this.username,
    this.password,
    this.access,
    this.refresh,
  });

  factory TokenObtainPair.fromJson(Map<String, dynamic> json) => _$TokenObtainPairFromJson(json);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'access')
  final String? access;
  @JsonKey(name: 'refresh')
  final String? refresh;
  static const fromJsonFactory = _$TokenObtainPairFromJson;
  static const toJsonFactory = _$TokenObtainPairToJson;
  Map<String, dynamic> toJson() => _$TokenObtainPairToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenObtainPair &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(other.password, password)) &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      runtimeType.hashCode;
}

extension $TokenObtainPairExtension on TokenObtainPair {
  TokenObtainPair copyWith({String? username, String? password, String? access, String? refresh}) {
    return TokenObtainPair(
        username: username ?? this.username,
        password: password ?? this.password,
        access: access ?? this.access,
        refresh: refresh ?? this.refresh);
  }
}

@JsonSerializable(explicitToJson: true)
class TokenRefresh {
  TokenRefresh({
    this.access,
    this.refresh,
  });

  factory TokenRefresh.fromJson(Map<String, dynamic> json) => _$TokenRefreshFromJson(json);

  @JsonKey(name: 'access')
  final String? access;
  @JsonKey(name: 'refresh')
  final String? refresh;
  static const fromJsonFactory = _$TokenRefreshFromJson;
  static const toJsonFactory = _$TokenRefreshToJson;
  Map<String, dynamic> toJson() => _$TokenRefreshToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenRefresh &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      runtimeType.hashCode;
}

extension $TokenRefreshExtension on TokenRefresh {
  TokenRefresh copyWith({String? access, String? refresh}) {
    return TokenRefresh(access: access ?? this.access, refresh: refresh ?? this.refresh);
  }
}

@JsonSerializable(explicitToJson: true)
class UserChangePasswordSerializers {
  UserChangePasswordSerializers({
    this.id,
    this.password,
    this.rePassword,
    this.oldPassword,
  });

  factory UserChangePasswordSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserChangePasswordSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'old_password')
  final String? oldPassword;
  static const fromJsonFactory = _$UserChangePasswordSerializersFromJson;
  static const toJsonFactory = _$UserChangePasswordSerializersToJson;
  Map<String, dynamic> toJson() => _$UserChangePasswordSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserChangePasswordSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(other.password, password)) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(other.rePassword, rePassword)) &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality().equals(other.oldPassword, oldPassword)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(rePassword) ^
      const DeepCollectionEquality().hash(oldPassword) ^
      runtimeType.hashCode;
}

extension $UserChangePasswordSerializersExtension on UserChangePasswordSerializers {
  UserChangePasswordSerializers copyWith(
      {int? id, String? password, String? rePassword, String? oldPassword}) {
    return UserChangePasswordSerializers(
        id: id ?? this.id,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword,
        oldPassword: oldPassword ?? this.oldPassword);
  }
}

@JsonSerializable(explicitToJson: true)
class UserCurrentShelterSerializers {
  UserCurrentShelterSerializers({
    this.currentShelter,
    this.currentShelterUserRole,
    this.isUserCanEdit,
    this.isUserCanDelete,
  });

  factory UserCurrentShelterSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserCurrentShelterSerializersFromJson(json);

  @JsonKey(name: 'current_shelter')
  final int? currentShelter;
  @JsonKey(name: 'current_shelter_user_role')
  final String? currentShelterUserRole;
  @JsonKey(name: 'is_user_can_edit')
  final bool? isUserCanEdit;
  @JsonKey(name: 'is_user_can_delete')
  final bool? isUserCanDelete;
  static const fromJsonFactory = _$UserCurrentShelterSerializersFromJson;
  static const toJsonFactory = _$UserCurrentShelterSerializersToJson;
  Map<String, dynamic> toJson() => _$UserCurrentShelterSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserCurrentShelterSerializers &&
            (identical(other.currentShelter, currentShelter) ||
                const DeepCollectionEquality().equals(other.currentShelter, currentShelter)) &&
            (identical(other.currentShelterUserRole, currentShelterUserRole) ||
                const DeepCollectionEquality()
                    .equals(other.currentShelterUserRole, currentShelterUserRole)) &&
            (identical(other.isUserCanEdit, isUserCanEdit) ||
                const DeepCollectionEquality().equals(other.isUserCanEdit, isUserCanEdit)) &&
            (identical(other.isUserCanDelete, isUserCanDelete) ||
                const DeepCollectionEquality().equals(other.isUserCanDelete, isUserCanDelete)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(currentShelter) ^
      const DeepCollectionEquality().hash(currentShelterUserRole) ^
      const DeepCollectionEquality().hash(isUserCanEdit) ^
      const DeepCollectionEquality().hash(isUserCanDelete) ^
      runtimeType.hashCode;
}

extension $UserCurrentShelterSerializersExtension on UserCurrentShelterSerializers {
  UserCurrentShelterSerializers copyWith(
      {int? currentShelter,
      String? currentShelterUserRole,
      bool? isUserCanEdit,
      bool? isUserCanDelete}) {
    return UserCurrentShelterSerializers(
        currentShelter: currentShelter ?? this.currentShelter,
        currentShelterUserRole: currentShelterUserRole ?? this.currentShelterUserRole,
        isUserCanEdit: isUserCanEdit ?? this.isUserCanEdit,
        isUserCanDelete: isUserCanDelete ?? this.isUserCanDelete);
  }
}

@JsonSerializable(explicitToJson: true)
class UserResetPasswordComplete {
  UserResetPasswordComplete({
    this.uidb64,
    this.token,
    this.newPassword,
  });

  factory UserResetPasswordComplete.fromJson(Map<String, dynamic> json) =>
      _$UserResetPasswordCompleteFromJson(json);

  @JsonKey(name: 'uidb64')
  final String? uidb64;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'new_password')
  final String? newPassword;
  static const fromJsonFactory = _$UserResetPasswordCompleteFromJson;
  static const toJsonFactory = _$UserResetPasswordCompleteToJson;
  Map<String, dynamic> toJson() => _$UserResetPasswordCompleteToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserResetPasswordComplete &&
            (identical(other.uidb64, uidb64) ||
                const DeepCollectionEquality().equals(other.uidb64, uidb64)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality().equals(other.newPassword, newPassword)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uidb64) ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $UserResetPasswordCompleteExtension on UserResetPasswordComplete {
  UserResetPasswordComplete copyWith({String? uidb64, String? token, String? newPassword}) {
    return UserResetPasswordComplete(
        uidb64: uidb64 ?? this.uidb64,
        token: token ?? this.token,
        newPassword: newPassword ?? this.newPassword);
  }
}

@JsonSerializable(explicitToJson: true)
class UserSerializers {
  UserSerializers({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.fathersName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.dateJoined,
    this.isVerified,
  });

  factory UserSerializers.fromJson(Map<String, dynamic> json) => _$UserSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'date_joined')
  final DateTime? dateJoined;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  static const fromJsonFactory = _$UserSerializersFromJson;
  static const toJsonFactory = _$UserSerializersToJson;
  Map<String, dynamic> toJson() => _$UserSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(other.username, username)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(other.fathersName, fathersName)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(other.dateJoined, dateJoined)) &&
            (identical(other.isVerified, isVerified) ||
                const DeepCollectionEquality().equals(other.isVerified, isVerified)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(fathersName) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(isVerified) ^
      runtimeType.hashCode;
}

extension $UserSerializersExtension on UserSerializers {
  UserSerializers copyWith(
      {int? id,
      String? username,
      String? firstName,
      String? lastName,
      String? fathersName,
      String? fullName,
      String? email,
      String? phoneNumber,
      String? address,
      DateTime? dateJoined,
      bool? isVerified}) {
    return UserSerializers(
        id: id ?? this.id,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fathersName: fathersName ?? this.fathersName,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        dateJoined: dateJoined ?? this.dateJoined,
        isVerified: isVerified ?? this.isVerified);
  }
}

@JsonSerializable(explicitToJson: true)
class UserShelterAdminSerializers {
  UserShelterAdminSerializers({
    this.id,
    this.firstName,
    this.lastName,
    this.fathersName,
    this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.rePassword,
    this.shelter,
  });

  factory UserShelterAdminSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserShelterAdminSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'shelter')
  final dynamic shelter;
  static const fromJsonFactory = _$UserShelterAdminSerializersFromJson;
  static const toJsonFactory = _$UserShelterAdminSerializersToJson;
  Map<String, dynamic> toJson() => _$UserShelterAdminSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserShelterAdminSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(other.fathersName, fathersName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(other.password, password)) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(other.rePassword, rePassword)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(fathersName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(rePassword) ^
      const DeepCollectionEquality().hash(shelter) ^
      runtimeType.hashCode;
}

extension $UserShelterAdminSerializersExtension on UserShelterAdminSerializers {
  UserShelterAdminSerializers copyWith(
      {int? id,
      String? firstName,
      String? lastName,
      String? fathersName,
      String? email,
      String? phoneNumber,
      String? address,
      String? password,
      String? rePassword,
      dynamic? shelter}) {
    return UserShelterAdminSerializers(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fathersName: fathersName ?? this.fathersName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword,
        shelter: shelter ?? this.shelter);
  }
}

@JsonSerializable(explicitToJson: true)
class UserShelterWorkerSerializers {
  UserShelterWorkerSerializers({
    this.firstName,
    this.lastName,
    this.fathersName,
    this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.rePassword,
    this.shelter,
    this.role,
  });

  factory UserShelterWorkerSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserShelterWorkerSerializersFromJson(json);

  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'role')
  final dynamic role;
  static const fromJsonFactory = _$UserShelterWorkerSerializersFromJson;
  static const toJsonFactory = _$UserShelterWorkerSerializersToJson;
  Map<String, dynamic> toJson() => _$UserShelterWorkerSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserShelterWorkerSerializers &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(other.lastName, lastName)) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(other.fathersName, fathersName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(other.password, password)) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(other.rePassword, rePassword)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(fathersName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(rePassword) ^
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(role) ^
      runtimeType.hashCode;
}

extension $UserShelterWorkerSerializersExtension on UserShelterWorkerSerializers {
  UserShelterWorkerSerializers copyWith(
      {String? firstName,
      String? lastName,
      String? fathersName,
      String? email,
      String? phoneNumber,
      String? address,
      String? password,
      String? rePassword,
      int? shelter,
      dynamic? role}) {
    return UserShelterWorkerSerializers(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fathersName: fathersName ?? this.fathersName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        password: password ?? this.password,
        rePassword: rePassword ?? this.rePassword,
        shelter: shelter ?? this.shelter,
        role: role ?? this.role);
  }
}

@JsonSerializable(explicitToJson: true)
class UserSheltersAdminSerializers {
  UserSheltersAdminSerializers({
    this.id,
    this.user,
    this.userId,
    this.role,
    this.isVerifiedByAdmin,
  });

  factory UserSheltersAdminSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserSheltersAdminSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'user')
  final dynamic user;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'role', toJson: roleEnumToJson, fromJson: roleEnumFromJson)
  final enums.RoleEnum? role;
  @JsonKey(name: 'is_verified_by_admin')
  final bool? isVerifiedByAdmin;
  static const fromJsonFactory = _$UserSheltersAdminSerializersFromJson;
  static const toJsonFactory = _$UserSheltersAdminSerializersToJson;
  Map<String, dynamic> toJson() => _$UserSheltersAdminSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSheltersAdminSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.isVerifiedByAdmin, isVerifiedByAdmin) ||
                const DeepCollectionEquality().equals(other.isVerifiedByAdmin, isVerifiedByAdmin)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(isVerifiedByAdmin) ^
      runtimeType.hashCode;
}

extension $UserSheltersAdminSerializersExtension on UserSheltersAdminSerializers {
  UserSheltersAdminSerializers copyWith(
      {int? id, dynamic? user, int? userId, enums.RoleEnum? role, bool? isVerifiedByAdmin}) {
    return UserSheltersAdminSerializers(
        id: id ?? this.id,
        user: user ?? this.user,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        isVerifiedByAdmin: isVerifiedByAdmin ?? this.isVerifiedByAdmin);
  }
}

@JsonSerializable(explicitToJson: true)
class UserSheltersWorkerSerializers {
  UserSheltersWorkerSerializers({
    this.shelter,
    this.role,
  });

  factory UserSheltersWorkerSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserSheltersWorkerSerializersFromJson(json);

  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'role', toJson: roleEnumToJson, fromJson: roleEnumFromJson)
  final enums.RoleEnum? role;
  static const fromJsonFactory = _$UserSheltersWorkerSerializersFromJson;
  static const toJsonFactory = _$UserSheltersWorkerSerializersToJson;
  Map<String, dynamic> toJson() => _$UserSheltersWorkerSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSheltersWorkerSerializers &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(role) ^
      runtimeType.hashCode;
}

extension $UserSheltersWorkerSerializersExtension on UserSheltersWorkerSerializers {
  UserSheltersWorkerSerializers copyWith({int? shelter, enums.RoleEnum? role}) {
    return UserSheltersWorkerSerializers(shelter: shelter ?? this.shelter, role: role ?? this.role);
  }
}

@JsonSerializable(explicitToJson: true)
class UserShortSerializers {
  UserShortSerializers({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
  });

  factory UserShortSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserShortSerializersFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  static const fromJsonFactory = _$UserShortSerializersFromJson;
  static const toJsonFactory = _$UserShortSerializersToJson;
  Map<String, dynamic> toJson() => _$UserShortSerializersToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserShortSerializers &&
            (identical(other.id, id) || const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(address) ^
      runtimeType.hashCode;
}

extension $UserShortSerializersExtension on UserShortSerializers {
  UserShortSerializers copyWith(
      {int? id, String? fullName, String? email, String? phoneNumber, String? address}) {
    return UserShortSerializers(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address);
  }
}

@JsonSerializable(explicitToJson: true)
class ValuesForSelection {
  ValuesForSelection({
    this.choicesName,
  });

  factory ValuesForSelection.fromJson(Map<String, dynamic> json) =>
      _$ValuesForSelectionFromJson(json);

  @JsonKey(name: 'choices_name', defaultValue: <ValuesForSelectionItem>[])
  final List<ValuesForSelectionItem>? choicesName;
  static const fromJsonFactory = _$ValuesForSelectionFromJson;
  static const toJsonFactory = _$ValuesForSelectionToJson;
  Map<String, dynamic> toJson() => _$ValuesForSelectionToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ValuesForSelection &&
            (identical(other.choicesName, choicesName) ||
                const DeepCollectionEquality().equals(other.choicesName, choicesName)));
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(choicesName) ^ runtimeType.hashCode;
}

extension $ValuesForSelectionExtension on ValuesForSelection {
  ValuesForSelection copyWith({List<ValuesForSelectionItem>? choicesName}) {
    return ValuesForSelection(choicesName: choicesName ?? this.choicesName);
  }
}

@JsonSerializable(explicitToJson: true)
class ValuesForSelectionItem {
  ValuesForSelectionItem({
    this.displayName,
    this.value,
  });

  factory ValuesForSelectionItem.fromJson(Map<String, dynamic> json) =>
      _$ValuesForSelectionItemFromJson(json);

  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'value')
  final String? value;
  static const fromJsonFactory = _$ValuesForSelectionItemFromJson;
  static const toJsonFactory = _$ValuesForSelectionItemToJson;
  Map<String, dynamic> toJson() => _$ValuesForSelectionItemToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ValuesForSelectionItem &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality().equals(other.displayName, displayName)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(value) ^
      runtimeType.hashCode;
}

extension $ValuesForSelectionItemExtension on ValuesForSelectionItem {
  ValuesForSelectionItem copyWith({String? displayName, String? value}) {
    return ValuesForSelectionItem(
        displayName: displayName ?? this.displayName, value: value ?? this.value);
  }
}

String? apiSchemaGetFormatToJson(enums.ApiSchemaGetFormat? apiSchemaGetFormat) {
  return enums.$ApiSchemaGetFormatMap[apiSchemaGetFormat];
}

enums.ApiSchemaGetFormat apiSchemaGetFormatFromJson(String? apiSchemaGetFormat) {
  if (apiSchemaGetFormat == null) {
    return enums.ApiSchemaGetFormat.swaggerGeneratedUnknown;
  }

  return enums.$ApiSchemaGetFormatMap.entries
      .firstWhere((element) => element.value.toLowerCase() == apiSchemaGetFormat.toLowerCase(),
          orElse: () => const MapEntry(enums.ApiSchemaGetFormat.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> apiSchemaGetFormatListToJson(List<enums.ApiSchemaGetFormat>? apiSchemaGetFormat) {
  if (apiSchemaGetFormat == null) {
    return [];
  }

  return apiSchemaGetFormat.map((e) => enums.$ApiSchemaGetFormatMap[e]!).toList();
}

List<enums.ApiSchemaGetFormat> apiSchemaGetFormatListFromJson(List? apiSchemaGetFormat) {
  if (apiSchemaGetFormat == null) {
    return [];
  }

  return apiSchemaGetFormat.map((e) => apiSchemaGetFormatFromJson(e.toString())).toList();
}

String? apiSchemaGetLangToJson(enums.ApiSchemaGetLang? apiSchemaGetLang) {
  return enums.$ApiSchemaGetLangMap[apiSchemaGetLang];
}

enums.ApiSchemaGetLang apiSchemaGetLangFromJson(String? apiSchemaGetLang) {
  if (apiSchemaGetLang == null) {
    return enums.ApiSchemaGetLang.swaggerGeneratedUnknown;
  }

  return enums.$ApiSchemaGetLangMap.entries
      .firstWhere((element) => element.value.toLowerCase() == apiSchemaGetLang.toLowerCase(),
          orElse: () => const MapEntry(enums.ApiSchemaGetLang.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> apiSchemaGetLangListToJson(List<enums.ApiSchemaGetLang>? apiSchemaGetLang) {
  if (apiSchemaGetLang == null) {
    return [];
  }

  return apiSchemaGetLang.map((e) => enums.$ApiSchemaGetLangMap[e]!).toList();
}

List<enums.ApiSchemaGetLang> apiSchemaGetLangListFromJson(List? apiSchemaGetLang) {
  if (apiSchemaGetLang == null) {
    return [];
  }

  return apiSchemaGetLang.map((e) => apiSchemaGetLangFromJson(e.toString())).toList();
}

String? apiV1AnimalsIdHistoryGetCreatedAtRangeToJson(
    enums.ApiV1AnimalsIdHistoryGetCreatedAtRange? apiV1AnimalsIdHistoryGetCreatedAtRange) {
  return enums.$ApiV1AnimalsIdHistoryGetCreatedAtRangeMap[apiV1AnimalsIdHistoryGetCreatedAtRange];
}

enums.ApiV1AnimalsIdHistoryGetCreatedAtRange apiV1AnimalsIdHistoryGetCreatedAtRangeFromJson(
    String? apiV1AnimalsIdHistoryGetCreatedAtRange) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return enums.ApiV1AnimalsIdHistoryGetCreatedAtRange.swaggerGeneratedUnknown;
  }

  return enums.$ApiV1AnimalsIdHistoryGetCreatedAtRangeMap.entries
      .firstWhere(
          (element) =>
              element.value.toLowerCase() == apiV1AnimalsIdHistoryGetCreatedAtRange.toLowerCase(),
          orElse: () => const MapEntry(
              enums.ApiV1AnimalsIdHistoryGetCreatedAtRange.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> apiV1AnimalsIdHistoryGetCreatedAtRangeListToJson(
    List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>? apiV1AnimalsIdHistoryGetCreatedAtRange) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return [];
  }

  return apiV1AnimalsIdHistoryGetCreatedAtRange
      .map((e) => enums.$ApiV1AnimalsIdHistoryGetCreatedAtRangeMap[e]!)
      .toList();
}

List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>
    apiV1AnimalsIdHistoryGetCreatedAtRangeListFromJson(
        List? apiV1AnimalsIdHistoryGetCreatedAtRange) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return [];
  }

  return apiV1AnimalsIdHistoryGetCreatedAtRange
      .map((e) => apiV1AnimalsIdHistoryGetCreatedAtRangeFromJson(e.toString()))
      .toList();
}

String? apiV1AnimalsSpeciesGetLevelToJson(
    enums.ApiV1AnimalsSpeciesGetLevel? apiV1AnimalsSpeciesGetLevel) {
  return enums.$ApiV1AnimalsSpeciesGetLevelMap[apiV1AnimalsSpeciesGetLevel];
}

enums.ApiV1AnimalsSpeciesGetLevel apiV1AnimalsSpeciesGetLevelFromJson(
    String? apiV1AnimalsSpeciesGetLevel) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return enums.ApiV1AnimalsSpeciesGetLevel.swaggerGeneratedUnknown;
  }

  return enums.$ApiV1AnimalsSpeciesGetLevelMap.entries
      .firstWhere(
          (element) => element.value.toLowerCase() == apiV1AnimalsSpeciesGetLevel.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.ApiV1AnimalsSpeciesGetLevel.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> apiV1AnimalsSpeciesGetLevelListToJson(
    List<enums.ApiV1AnimalsSpeciesGetLevel>? apiV1AnimalsSpeciesGetLevel) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return [];
  }

  return apiV1AnimalsSpeciesGetLevel.map((e) => enums.$ApiV1AnimalsSpeciesGetLevelMap[e]!).toList();
}

List<enums.ApiV1AnimalsSpeciesGetLevel> apiV1AnimalsSpeciesGetLevelListFromJson(
    List? apiV1AnimalsSpeciesGetLevel) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return [];
  }

  return apiV1AnimalsSpeciesGetLevel
      .map((e) => apiV1AnimalsSpeciesGetLevelFromJson(e.toString()))
      .toList();
}

String? durationEnumToJson(enums.DurationEnum? durationEnum) {
  return enums.$DurationEnumMap[durationEnum];
}

enums.DurationEnum durationEnumFromJson(String? durationEnum) {
  if (durationEnum == null) {
    return enums.DurationEnum.swaggerGeneratedUnknown;
  }

  return enums.$DurationEnumMap.entries
      .firstWhere((element) => element.value.toLowerCase() == durationEnum.toLowerCase(),
          orElse: () => const MapEntry(enums.DurationEnum.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> durationEnumListToJson(List<enums.DurationEnum>? durationEnum) {
  if (durationEnum == null) {
    return [];
  }

  return durationEnum.map((e) => enums.$DurationEnumMap[e]!).toList();
}

List<enums.DurationEnum> durationEnumListFromJson(List? durationEnum) {
  if (durationEnum == null) {
    return [];
  }

  return durationEnum.map((e) => durationEnumFromJson(e.toString())).toList();
}

String? levelEnumToJson(enums.LevelEnum? levelEnum) {
  return enums.$LevelEnumMap[levelEnum];
}

enums.LevelEnum levelEnumFromJson(String? levelEnum) {
  if (levelEnum == null) {
    return enums.LevelEnum.swaggerGeneratedUnknown;
  }

  return enums.$LevelEnumMap.entries
      .firstWhere((element) => element.value.toLowerCase() == levelEnum.toLowerCase(),
          orElse: () => const MapEntry(enums.LevelEnum.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> levelEnumListToJson(List<enums.LevelEnum>? levelEnum) {
  if (levelEnum == null) {
    return [];
  }

  return levelEnum.map((e) => enums.$LevelEnumMap[e]!).toList();
}

List<enums.LevelEnum> levelEnumListFromJson(List? levelEnum) {
  if (levelEnum == null) {
    return [];
  }

  return levelEnum.map((e) => levelEnumFromJson(e.toString())).toList();
}

String? myTypeEnumToJson(enums.MyTypeEnum? myTypeEnum) {
  return enums.$MyTypeEnumMap[myTypeEnum];
}

enums.MyTypeEnum myTypeEnumFromJson(String? myTypeEnum) {
  if (myTypeEnum == null) {
    return enums.MyTypeEnum.swaggerGeneratedUnknown;
  }

  return enums.$MyTypeEnumMap.entries
      .firstWhere((element) => element.value.toLowerCase() == myTypeEnum.toLowerCase(),
          orElse: () => const MapEntry(enums.MyTypeEnum.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> myTypeEnumListToJson(List<enums.MyTypeEnum>? myTypeEnum) {
  if (myTypeEnum == null) {
    return [];
  }

  return myTypeEnum.map((e) => enums.$MyTypeEnumMap[e]!).toList();
}

List<enums.MyTypeEnum> myTypeEnumListFromJson(List? myTypeEnum) {
  if (myTypeEnum == null) {
    return [];
  }

  return myTypeEnum.map((e) => myTypeEnumFromJson(e.toString())).toList();
}

String? prescriptionExecutionStatusEnumToJson(
    enums.PrescriptionExecutionStatusEnum? prescriptionExecutionStatusEnum) {
  return enums.$PrescriptionExecutionStatusEnumMap[prescriptionExecutionStatusEnum];
}

enums.PrescriptionExecutionStatusEnum prescriptionExecutionStatusEnumFromJson(
    String? prescriptionExecutionStatusEnum) {
  if (prescriptionExecutionStatusEnum == null) {
    return enums.PrescriptionExecutionStatusEnum.swaggerGeneratedUnknown;
  }

  return enums.$PrescriptionExecutionStatusEnumMap.entries
      .firstWhere(
          (element) => element.value.toLowerCase() == prescriptionExecutionStatusEnum.toLowerCase(),
          orElse: () =>
              const MapEntry(enums.PrescriptionExecutionStatusEnum.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> prescriptionExecutionStatusEnumListToJson(
    List<enums.PrescriptionExecutionStatusEnum>? prescriptionExecutionStatusEnum) {
  if (prescriptionExecutionStatusEnum == null) {
    return [];
  }

  return prescriptionExecutionStatusEnum
      .map((e) => enums.$PrescriptionExecutionStatusEnumMap[e]!)
      .toList();
}

List<enums.PrescriptionExecutionStatusEnum> prescriptionExecutionStatusEnumListFromJson(
    List? prescriptionExecutionStatusEnum) {
  if (prescriptionExecutionStatusEnum == null) {
    return [];
  }

  return prescriptionExecutionStatusEnum
      .map((e) => prescriptionExecutionStatusEnumFromJson(e.toString()))
      .toList();
}

String? roleEnumToJson(enums.RoleEnum? roleEnum) {
  return enums.$RoleEnumMap[roleEnum];
}

enums.RoleEnum roleEnumFromJson(String? roleEnum) {
  if (roleEnum == null) {
    return enums.RoleEnum.swaggerGeneratedUnknown;
  }

  return enums.$RoleEnumMap.entries
      .firstWhere((element) => element.value.toLowerCase() == roleEnum.toLowerCase(),
          orElse: () => const MapEntry(enums.RoleEnum.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> roleEnumListToJson(List<enums.RoleEnum>? roleEnum) {
  if (roleEnum == null) {
    return [];
  }

  return roleEnum.map((e) => enums.$RoleEnumMap[e]!).toList();
}

List<enums.RoleEnum> roleEnumListFromJson(List? roleEnum) {
  if (roleEnum == null) {
    return [];
  }

  return roleEnum.map((e) => roleEnumFromJson(e.toString())).toList();
}

String? status131EnumToJson(enums.Status131Enum? status131Enum) {
  return enums.$Status131EnumMap[status131Enum];
}

enums.Status131Enum status131EnumFromJson(String? status131Enum) {
  if (status131Enum == null) {
    return enums.Status131Enum.swaggerGeneratedUnknown;
  }

  return enums.$Status131EnumMap.entries
      .firstWhere((element) => element.value.toLowerCase() == status131Enum.toLowerCase(),
          orElse: () => const MapEntry(enums.Status131Enum.swaggerGeneratedUnknown, ''))
      .key;
}

List<String> status131EnumListToJson(List<enums.Status131Enum>? status131Enum) {
  if (status131Enum == null) {
    return [];
  }

  return status131Enum.map((e) => enums.$Status131EnumMap[e]!).toList();
}

List<enums.Status131Enum> status131EnumListFromJson(List? status131Enum) {
  if (status131Enum == null) {
    return [];
  }

  return status131Enum.map((e) => status131EnumFromJson(e.toString())).toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(OpenapiJsonDecoderMappings);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
