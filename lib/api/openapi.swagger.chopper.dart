// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$Openapi extends Openapi {
  _$Openapi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Openapi;

  @override
  Future<Response<Object>> _apiSchemaGet({String? format, String? lang, String? xCurrentShelter}) {
    final $url = '/api/schema/';
    final $params = <String, dynamic>{'format': format, 'lang': lang};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<TokenObtainPair>> apiTokenPost(
      {String? xCurrentShelter, required TokenObtainPair? body}) {
    final $url = '/api/token/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<TokenObtainPair, TokenObtainPair>($request);
  }

  @override
  Future<Response<TokenRefresh>> apiTokenRefreshPost(
      {String? xCurrentShelter, required TokenRefresh? body}) {
    final $url = '/api/token/refresh/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<TokenRefresh, TokenRefresh>($request);
  }

  @override
  Future<Response<PaginatedAnimalReadList>> apiV1AnimalsGet(
      {int? limit, int? offset, String? ordering, String? search, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/';
    final $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'search': search
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedAnimalReadList, PaginatedAnimalReadList>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsPost(
      {String? xCurrentShelter, required AnimalWrite? body}) {
    final $url = '/api/v1/animals/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsIdGet({required String? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsIdPut(
      {required String? id, String? xCurrentShelter, required AnimalWrite? body}) {
    final $url = '/api/v1/animals/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsIdPatch(
      {required String? id, String? xCurrentShelter, required PatchedAnimalWrite? body}) {
    final $url = '/api/v1/animals/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<dynamic>> apiV1AnimalsIdDelete({required String? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> apiV1AnimalsIdPdfTypePdfGet(
      {required int? id, required String? pdfType, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/${pdfType}/pdf/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ApplicantFile>>> apiV1AnimalsIdFilesGet(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/files/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<List<ApplicantFile>, ApplicantFile>($request);
  }

  @override
  Future<Response<PaginatedAnimalHistorySnapshotList>> _apiV1AnimalsIdHistoryGet(
      {String? createdAtAfter,
      String? createdAtBefore,
      String? createdAtRange,
      required int? id,
      int? limit,
      int? offset,
      String? ordering,
      String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/history/';
    final $params = <String, dynamic>{
      'created_at_after': createdAtAfter,
      'created_at_before': createdAtBefore,
      'created_at_range': createdAtRange,
      'limit': limit,
      'offset': offset,
      'ordering': ordering
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client
        .send<PaginatedAnimalHistorySnapshotList, PaginatedAnimalHistorySnapshotList>($request);
  }

  @override
  Future<Response<Status>> apiV1AnimalsIdPrimaryImageImagePkPut(
      {required String? id, required String? imagePk, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/primary_image/${imagePk}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('PUT', $url, client.baseUrl, headers: $headers);
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<Status>> apiV1AnimalsIdRestorePut(
      {required String? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/${id}/restore/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('PUT', $url, client.baseUrl, headers: $headers);
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<List<AnimalAttribute>>> apiV1AnimalsAttributesGet(
      {bool? isRequired, String? ordering, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/attributes/';
    final $params = <String, dynamic>{'is_required': isRequired, 'ordering': ordering};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<List<AnimalAttribute>, AnimalAttribute>($request);
  }

  @override
  Future<Response<AnimalAttribute>> apiV1AnimalsAttributesIdGet(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/attributes/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<AnimalAttribute, AnimalAttribute>($request);
  }

  @override
  Future<Response<PaginatedAnimalNoteList>> apiV1AnimalsNotesGet(
      {int? animal, int? limit, int? offset, String? ordering, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/notes/';
    final $params = <String, dynamic>{
      'animal': animal,
      'limit': limit,
      'offset': offset,
      'ordering': ordering
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedAnimalNoteList, PaginatedAnimalNoteList>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesPost(
      {String? xCurrentShelter, required AnimalNote? body}) {
    final $url = '/api/v1/animals/notes/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesIdGet({required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/notes/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesIdPut(
      {required int? id, String? xCurrentShelter, required AnimalNote? body}) {
    final $url = '/api/v1/animals/notes/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesIdPatch(
      {required int? id, String? xCurrentShelter, required PatchedAnimalNote? body}) {
    final $url = '/api/v1/animals/notes/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<dynamic>> apiV1AnimalsNotesIdDelete({required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/notes/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedSpeciesList>> _apiV1AnimalsSpeciesGet(
      {String? level,
      int? limit,
      int? offset,
      String? ordering,
      int? parentId,
      String? search,
      String? xCurrentShelter}) {
    final $url = '/api/v1/animals/species/';
    final $params = <String, dynamic>{
      'level': level,
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'parent_id': parentId,
      'search': search
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedSpeciesList, PaginatedSpeciesList>($request);
  }

  @override
  Future<Response<Species>> apiV1AnimalsSpeciesPost(
      {String? xCurrentShelter, required Species? body}) {
    final $url = '/api/v1/animals/species/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Species, Species>($request);
  }

  @override
  Future<Response<Species>> apiV1AnimalsSpeciesIdGet({required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/animals/species/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<Species, Species>($request);
  }

  @override
  Future<Response<PaginatedApplicantList>> apiV1ApplicantsGet(
      {int? limit, int? offset, String? ordering, String? search, String? xCurrentShelter}) {
    final $url = '/api/v1/applicants/';
    final $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'search': search
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedApplicantList, PaginatedApplicantList>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsPost(
      {String? xCurrentShelter, required Applicant? body}) {
    final $url = '/api/v1/applicants/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsIdGet({required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/applicants/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsIdPut(
      {required int? id, String? xCurrentShelter, required Applicant? body}) {
    final $url = '/api/v1/applicants/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsIdPatch(
      {required int? id, String? xCurrentShelter, required PatchedApplicant? body}) {
    final $url = '/api/v1/applicants/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<dynamic>> apiV1ApplicantsIdDelete({required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/applicants/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>> apiV1AvailableSheltersGet(
      {int? limit, int? offset, String? search, String? xCurrentShelter}) {
    final $url = '/api/v1/available-shelters/';
    final $params = <String, dynamic>{'limit': limit, 'offset': offset, 'search': search};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client
        .send<PaginatedShelterShortSerializersList, PaginatedShelterShortSerializersList>($request);
  }

  @override
  Future<Response<PaginatedCuratorList>> apiV1CuratorsGet(
      {int? limit, int? offset, String? search, String? xCurrentShelter}) {
    final $url = '/api/v1/curators/';
    final $params = <String, dynamic>{'limit': limit, 'offset': offset, 'search': search};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedCuratorList, PaginatedCuratorList>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsPost({String? xCurrentShelter, required Curator? body}) {
    final $url = '/api/v1/curators/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsIdGet({required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/curators/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsIdPut(
      {required int? id, String? xCurrentShelter, required Curator? body}) {
    final $url = '/api/v1/curators/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsIdPatch(
      {required int? id, String? xCurrentShelter, required PatchedCurator? body}) {
    final $url = '/api/v1/curators/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Feedback>> apiV1FeedbackPost({String? xCurrentShelter, required Feedback? body}) {
    final $url = '/api/v1/feedback/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Feedback, Feedback>($request);
  }

  @override
  Future<Response<PaginatedPrescriptionList>> apiV1PrescriptionsGet(
      {int? animal,
      String? executeAtGte,
      String? executeAtLt,
      int? limit,
      int? offset,
      String? xCurrentShelter}) {
    final $url = '/api/v1/prescriptions/';
    final $params = <String, dynamic>{
      'animal': animal,
      'execute_at__gte': executeAtGte,
      'execute_at__lt': executeAtLt,
      'limit': limit,
      'offset': offset
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedPrescriptionList, PaginatedPrescriptionList>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsPost(
      {String? xCurrentShelter, required Prescription? body}) {
    final $url = '/api/v1/prescriptions/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsIdGet(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/prescriptions/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsIdPut(
      {required int? id, String? xCurrentShelter, required Prescription? body}) {
    final $url = '/api/v1/prescriptions/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsIdPatch(
      {required int? id, String? xCurrentShelter, required PatchedPrescription? body}) {
    final $url = '/api/v1/prescriptions/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<dynamic>> apiV1PrescriptionsIdDelete(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/prescriptions/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedPrescriptionExecutionTodayList>> apiV1PrescriptionsExecutionsGet(
      {required String? from,
      int? limit,
      int? offset,
      String? ordering,
      String? search,
      required String? to,
      String? xCurrentShelter}) {
    final $url = '/api/v1/prescriptions/executions/';
    final $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'search': search,
      'from': from,
      'to': to,
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedPrescriptionExecutionTodayList,
        PaginatedPrescriptionExecutionTodayList>($request);
  }

  @override
  Future<Response<PaginatedShelterDrugList>> apiV1ShelterDrugsGet(
      {int? limit, int? offset, String? search, String? xCurrentShelter}) {
    final $url = '/api/v1/shelter/drugs/';
    final $params = <String, dynamic>{'limit': limit, 'offset': offset, 'search': search};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedShelterDrugList, PaginatedShelterDrugList>($request);
  }

  @override
  Future<Response<PaginatedUserSheltersAdminSerializersList>> apiV1ShelterWorkersGet(
      {bool? isVerifiedByAdmin,
      bool? isVerifiedByAdminIsnull,
      int? limit,
      int? offset,
      String? xCurrentShelter}) {
    final $url = '/api/v1/shelter/workers/';
    final $params = <String, dynamic>{
      'is_verified_by_admin': isVerifiedByAdmin,
      'is_verified_by_admin__isnull': isVerifiedByAdminIsnull,
      'limit': limit,
      'offset': offset
    };
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client.send<PaginatedUserSheltersAdminSerializersList,
        PaginatedUserSheltersAdminSerializersList>($request);
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersPost(
      {String? xCurrentShelter, required UserSheltersAdminSerializers? body}) {
    final $url = '/api/v1/shelter/workers/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>($request);
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdGet(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/shelter/workers/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>($request);
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdPut(
      {required int? id, String? xCurrentShelter, required UserSheltersAdminSerializers? body}) {
    final $url = '/api/v1/shelter/workers/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>($request);
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdPatch(
      {required int? id,
      String? xCurrentShelter,
      required PatchedUserSheltersAdminSerializers? body}) {
    final $url = '/api/v1/shelter/workers/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>($request);
  }

  @override
  Future<Response<dynamic>> apiV1ShelterWorkersIdDelete(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/shelter/workers/${id}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Approve>> apiV1ShelterWorkersIdApprovePut(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/shelter/workers/${id}/approve/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('PUT', $url, client.baseUrl, headers: $headers);
    return client.send<Approve, Approve>($request);
  }

  @override
  Future<Response<Decline>> apiV1ShelterWorkersIdDeclinePut(
      {required int? id, String? xCurrentShelter}) {
    final $url = '/api/v1/shelter/workers/${id}/decline/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('PUT', $url, client.baseUrl, headers: $headers);
    return client.send<Decline, Decline>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>> apiV1SheltersGet(
      {int? limit, int? offset, String? search, String? xCurrentShelter}) {
    final $url = '/api/v1/shelters/';
    final $params = <String, dynamic>{'limit': limit, 'offset': offset, 'search': search};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client
        .send<PaginatedShelterShortSerializersList, PaginatedShelterShortSerializersList>($request);
  }

  @override
  Future<Response<UserSheltersWorkerSerializers>> apiV1SheltersAddPost(
      {String? xCurrentShelter, required UserSheltersWorkerSerializers? body}) {
    final $url = '/api/v1/shelters/add/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserSheltersWorkerSerializers, UserSheltersWorkerSerializers>($request);
  }

  @override
  Future<Response<UserShelterAdminSerializers>> apiV1UsersAdminRegisterPost(
      {String? xCurrentShelter, required UserShelterAdminSerializers? body}) {
    final $url = '/api/v1/users/admin-register/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserShelterAdminSerializers, UserShelterAdminSerializers>($request);
  }

  @override
  Future<Response<PaginatedUserShortSerializersList>> apiV1UsersAvailableWorkersGet(
      {int? limit, int? offset, String? xCurrentShelter}) {
    final $url = '/api/v1/users/available-workers/';
    final $params = <String, dynamic>{'limit': limit, 'offset': offset};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client
        .send<PaginatedUserShortSerializersList, PaginatedUserShortSerializersList>($request);
  }

  @override
  Future<Response<UserSerializers>> apiV1UsersMeGet({String? xCurrentShelter}) {
    final $url = '/api/v1/users/me/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserSerializers>> apiV1UsersMePut(
      {String? xCurrentShelter, required UserSerializers? body}) {
    final $url = '/api/v1/users/me/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserSerializers>> apiV1UsersMePatch(
      {String? xCurrentShelter, required PatchedUserSerializers? body}) {
    final $url = '/api/v1/users/me/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserChangePasswordSerializers>> apiV1UsersMeChangePasswordPut(
      {String? xCurrentShelter, required UserChangePasswordSerializers? body}) {
    final $url = '/api/v1/users/me/change_password/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserChangePasswordSerializers, UserChangePasswordSerializers>($request);
  }

  @override
  Future<Response<UserChangePasswordSerializers>> apiV1UsersMeChangePasswordPatch(
      {String? xCurrentShelter, required PatchedUserChangePasswordSerializers? body}) {
    final $url = '/api/v1/users/me/change_password/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserChangePasswordSerializers, UserChangePasswordSerializers>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>> apiV1UsersMeSheltersGet(
      {int? limit, int? offset, String? xCurrentShelter}) {
    final $url = '/api/v1/users/me/shelters/';
    final $params = <String, dynamic>{'limit': limit, 'offset': offset};
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, parameters: $params, headers: $headers);
    return client
        .send<PaginatedShelterShortSerializersList, PaginatedShelterShortSerializersList>($request);
  }

  @override
  Future<Response<UserCurrentShelterSerializers>> apiV1UsersMeSheltersCurrentGet(
      {String? xCurrentShelter}) {
    final $url = '/api/v1/users/me/shelters/current/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<UserCurrentShelterSerializers, UserCurrentShelterSerializers>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersResetPasswordPost(
      {String? xCurrentShelter, required Email? body}) {
    final $url = '/api/v1/users/reset-password/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersResetPasswordCompletePost(
      {String? xCurrentShelter, required UserResetPasswordComplete? body}) {
    final $url = '/api/v1/users/reset-password/complete/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersResetPasswordConfirmUidb64TokenGet(
      {required String? token, required String? uidb64, String? xCurrentShelter}) {
    final $url = '/api/v1/users/reset-password/confirm/${uidb64}/${token}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersVerifyEmailUidb64Sidb64TokenGet(
      {required String? sidb64,
      required String? token,
      required String? uidb64,
      String? xCurrentShelter}) {
    final $url = '/api/v1/users/verify-email/${uidb64}/${sidb64}/${token}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersVerifyWorkerUidb64Sidb64TokenGet(
      {required String? sidb64,
      required String? token,
      required String? uidb64,
      String? xCurrentShelter}) {
    final $url = '/api/v1/users/verify-worker/${uidb64}/${sidb64}/${token}/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserShelterWorkerSerializers>> apiV1UsersWorkerRegisterPost(
      {String? xCurrentShelter, required UserShelterWorkerSerializers? body}) {
    final $url = '/api/v1/users/worker-register/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UserShelterWorkerSerializers, UserShelterWorkerSerializers>($request);
  }

  @override
  Future<Response<ValuesForSelection>> apiV1ValuesForSelectionGet({String? xCurrentShelter}) {
    final $url = '/api/v1/values-for-selection/';
    final $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<ValuesForSelection, ValuesForSelection>($request);
  }
}
