// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'openapi.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Openapi extends Openapi {
  _$Openapi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Openapi;

  @override
  Future<Response<Object>> _apiSchemaGet({
    String? format,
    String? lang,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/schema/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'format': format,
      'lang': lang,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<TokenObtainPair>> apiTokenPost({
    String? xCurrentShelter,
    required TokenObtainPair? body,
  }) {
    final Uri $url = Uri.parse('/api/token/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TokenObtainPair, TokenObtainPair>($request);
  }

  @override
  Future<Response<TokenRefresh>> apiTokenRefreshPost({
    String? xCurrentShelter,
    required TokenRefresh? body,
  }) {
    final Uri $url = Uri.parse('/api/token/refresh/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TokenRefresh, TokenRefresh>($request);
  }

  @override
  Future<Response<PaginatedAnimalReadList>> apiV1AnimalsGet({
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedAnimalReadList, PaginatedAnimalReadList>(
      $request,
    );
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsPost({
    String? xCurrentShelter,
    required AnimalWrite? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsIdGet({
    required String? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsIdPut({
    required String? id,
    String? xCurrentShelter,
    required AnimalWrite? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> apiV1AnimalsIdPatch({
    required String? id,
    String? xCurrentShelter,
    required PatchedAnimalWrite? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<dynamic>> apiV1AnimalsIdDelete({
    required String? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> apiV1AnimalsIdPdfTypePdfGet({
    required int? id,
    required String? pdfType,
    required DateTime from,
    required DateTime to,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/${pdfType}/pdf/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'from': from,
      'to': to,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ApplicantFile>>> apiV1AnimalsIdFilesGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/files/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<ApplicantFile>, ApplicantFile>($request);
  }

  @override
  Future<Response<PaginatedAnimalHistorySnapshotList>>
  _apiV1AnimalsIdHistoryGet({
    String? createdAtAfter,
    String? createdAtBefore,
    String? createdAtRange,
    required int? id,
    int? limit,
    int? offset,
    String? ordering,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/history/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'created_at_after': createdAtAfter,
      'created_at_before': createdAtBefore,
      'created_at_range': createdAtRange,
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedAnimalHistorySnapshotList,
      PaginatedAnimalHistorySnapshotList
    >($request);
  }

  @override
  Future<Response<Status>> apiV1AnimalsIdPrimaryImageImagePkPut({
    required String? id,
    required String? imagePk,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse(
      '/api/v1/animals/${id}/primary_image/${imagePk}/',
    );
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<Status>> apiV1AnimalsIdRestorePut({
    required String? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/restore/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<List<AnimalAttribute>>> apiV1AnimalsAttributesGet({
    bool? isRequired,
    String? ordering,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/attributes/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'is_required': isRequired,
      'ordering': ordering,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<AnimalAttribute>, AnimalAttribute>($request);
  }

  @override
  Future<Response<AnimalAttribute>> apiV1AnimalsAttributesIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/attributes/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AnimalAttribute, AnimalAttribute>($request);
  }

  @override
  Future<Response<PaginatedAnimalNoteList>> apiV1AnimalsNotesGet({
    int? animal,
    int? limit,
    int? offset,
    String? ordering,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/notes/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'animal': animal,
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedAnimalNoteList, PaginatedAnimalNoteList>(
      $request,
    );
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesPost({
    String? xCurrentShelter,
    required AnimalNote? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/notes/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/notes/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesIdPut({
    required int? id,
    String? xCurrentShelter,
    required AnimalNote? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/notes/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> apiV1AnimalsNotesIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedAnimalNote? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/notes/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<dynamic>> apiV1AnimalsNotesIdDelete({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/notes/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedSpeciesList>> _apiV1AnimalsSpeciesGet({
    String? level,
    int? limit,
    int? offset,
    String? ordering,
    int? parentId,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/species/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'level': level,
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'parent_id': parentId,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedSpeciesList, PaginatedSpeciesList>($request);
  }

  @override
  Future<Response<Species>> apiV1AnimalsSpeciesPost({
    String? xCurrentShelter,
    required Species? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/species/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Species, Species>($request);
  }

  @override
  Future<Response<Species>> apiV1AnimalsSpeciesIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/species/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Species, Species>($request);
  }

  @override
  Future<Response<PaginatedApplicantList>> apiV1ApplicantsGet({
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/applicants/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedApplicantList, PaginatedApplicantList>(
      $request,
    );
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsPost({
    String? xCurrentShelter,
    required Applicant? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/applicants/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/applicants/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsIdPut({
    required int? id,
    String? xCurrentShelter,
    required Applicant? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/applicants/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> apiV1ApplicantsIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedApplicant? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/applicants/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<dynamic>> apiV1ApplicantsIdDelete({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/applicants/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>>
  apiV1AvailableSheltersGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/available-shelters/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedShelterShortSerializersList,
      PaginatedShelterShortSerializersList
    >($request);
  }

  @override
  Future<Response<PaginatedCuratorList>> apiV1CuratorsGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/curators/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedCuratorList, PaginatedCuratorList>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsPost({
    String? xCurrentShelter,
    required Curator? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/curators/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/curators/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsIdPut({
    required int? id,
    String? xCurrentShelter,
    required Curator? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/curators/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> apiV1CuratorsIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedCurator? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/curators/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Feedback>> apiV1FeedbackPost({
    String? xCurrentShelter,
    required Feedback? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/feedback/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Feedback, Feedback>($request);
  }

  @override
  Future<Response<PaginatedPrescriptionList>> apiV1PrescriptionsGet({
    int? animal,
    String? executeAtGte,
    String? executeAtLt,
    int? limit,
    int? offset,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'animal': animal,
      'execute_at__gte': executeAtGte,
      'execute_at__lt': executeAtLt,
      'limit': limit,
      'offset': offset,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedPrescriptionList, PaginatedPrescriptionList>(
      $request,
    );
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsPost({
    String? xCurrentShelter,
    required Prescription? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsIdPut({
    required int? id,
    String? xCurrentShelter,
    required Prescription? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> apiV1PrescriptionsIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedPrescription? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<dynamic>> apiV1PrescriptionsIdDelete({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedPrescriptionExecutionTodayList>>
  apiV1PrescriptionsExecutionsGet({
    required String? from,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    required String? to,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/prescriptions/executions/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'ordering': ordering,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedPrescriptionExecutionTodayList,
      PaginatedPrescriptionExecutionTodayList
    >($request);
  }

  @override
  Future<Response<PaginatedShelterDrugList>> apiV1ShelterDrugsGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/drugs/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PaginatedShelterDrugList, PaginatedShelterDrugList>(
      $request,
    );
  }

  @override
  Future<Response<PaginatedUserSheltersAdminSerializersList>>
  apiV1ShelterWorkersGet({
    bool? isVerifiedByAdmin,
    bool? isVerifiedByAdminIsnull,
    int? limit,
    int? offset,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'is_verified_by_admin': isVerifiedByAdmin,
      'is_verified_by_admin__isnull': isVerifiedByAdminIsnull,
      'limit': limit,
      'offset': offset,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedUserSheltersAdminSerializersList,
      PaginatedUserSheltersAdminSerializersList
    >($request);
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersPost({
    String? xCurrentShelter,
    required UserSheltersAdminSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdGet({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdPut({
    required int? id,
    String? xCurrentShelter,
    required UserSheltersAdminSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> apiV1ShelterWorkersIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedUserSheltersAdminSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> apiV1ShelterWorkersIdDelete({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Approve>> apiV1ShelterWorkersIdApprovePut({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/${id}/approve/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Approve, Approve>($request);
  }

  @override
  Future<Response<Decline>> apiV1ShelterWorkersIdDeclinePut({
    required int? id,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelter/workers/${id}/decline/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Decline, Decline>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>> apiV1SheltersGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelters/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'search': search,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedShelterShortSerializersList,
      PaginatedShelterShortSerializersList
    >($request);
  }

  @override
  Future<Response<UserSheltersWorkerSerializers>> apiV1SheltersAddPost({
    String? xCurrentShelter,
    required UserSheltersWorkerSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/shelters/add/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserSheltersWorkerSerializers, UserSheltersWorkerSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserShelterAdminSerializers>> apiV1UsersAdminRegisterPost({
    String? xCurrentShelter,
    required UserShelterAdminSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/admin-register/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserShelterAdminSerializers, UserShelterAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<PaginatedUserShortSerializersList>>
  apiV1UsersAvailableWorkersGet({
    int? limit,
    int? offset,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/available-workers/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedUserShortSerializersList,
      PaginatedUserShortSerializersList
    >($request);
  }

  @override
  Future<Response<UserSerializers>> apiV1UsersMeGet({String? xCurrentShelter}) {
    final Uri $url = Uri.parse('/api/v1/users/me/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserSerializers>> apiV1UsersMePut({
    String? xCurrentShelter,
    required UserSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/me/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserSerializers>> apiV1UsersMePatch({
    String? xCurrentShelter,
    required PatchedUserSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/me/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserChangePasswordSerializers>>
  apiV1UsersMeChangePasswordPut({
    String? xCurrentShelter,
    required UserChangePasswordSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/me/change_password/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserChangePasswordSerializers, UserChangePasswordSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserChangePasswordSerializers>>
  apiV1UsersMeChangePasswordPatch({
    String? xCurrentShelter,
    required PatchedUserChangePasswordSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/me/change_password/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserChangePasswordSerializers, UserChangePasswordSerializers>(
          $request,
        );
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>>
  apiV1UsersMeSheltersGet({int? limit, int? offset, String? xCurrentShelter}) {
    final Uri $url = Uri.parse('/api/v1/users/me/shelters/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'offset': offset,
    };
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<
      PaginatedShelterShortSerializersList,
      PaginatedShelterShortSerializersList
    >($request);
  }

  @override
  Future<Response<UserCurrentShelterSerializers>>
  apiV1UsersMeSheltersCurrentGet({String? xCurrentShelter}) {
    final Uri $url = Uri.parse('/api/v1/users/me/shelters/current/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<UserCurrentShelterSerializers, UserCurrentShelterSerializers>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> apiV1UsersResetPasswordPost({
    String? xCurrentShelter,
    required Email? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/reset-password/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersResetPasswordCompletePost({
    String? xCurrentShelter,
    required UserResetPasswordComplete? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/reset-password/complete/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersResetPasswordConfirmUidb64TokenGet({
    required String? token,
    required String? uidb64,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse(
      '/api/v1/users/reset-password/confirm/${uidb64}/${token}/',
    );
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersVerifyEmailUidb64Sidb64TokenGet({
    required String? sidb64,
    required String? token,
    required String? uidb64,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse(
      '/api/v1/users/verify-email/${uidb64}/${sidb64}/${token}/',
    );
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> apiV1UsersVerifyWorkerUidb64Sidb64TokenGet({
    required String? sidb64,
    required String? token,
    required String? uidb64,
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse(
      '/api/v1/users/verify-worker/${uidb64}/${sidb64}/${token}/',
    );
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserShelterWorkerSerializers>> apiV1UsersWorkerRegisterPost({
    String? xCurrentShelter,
    required UserShelterWorkerSerializers? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/worker-register/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<UserShelterWorkerSerializers, UserShelterWorkerSerializers>(
          $request,
        );
  }

  @override
  Future<Response<ValuesForSelection>> apiV1ValuesForSelectionGet({
    String? xCurrentShelter,
  }) {
    final Uri $url = Uri.parse('/api/v1/values-for-selection/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ValuesForSelection, ValuesForSelection>($request);
  }
}
