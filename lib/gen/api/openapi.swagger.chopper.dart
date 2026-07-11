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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''OpenApi3 schema for this API. Format can be selected via content negotiation.

- YAML: application/vnd.oai.openapi
- JSON: application/vnd.oai.openapi+json''',
      summary: '',
      operationId: 'schema_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Schema"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<TokenObtainPair>> _apiTokenPost({
    String? xCurrentShelter,
    required TokenObtainPair? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Takes a set of user credentials and returns an access and refresh JSON web
token pair to prove the authentication of those credentials.''',
      summary: '',
      operationId: 'token_create',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Token"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TokenObtainPair, TokenObtainPair>($request);
  }

  @override
  Future<Response<TokenRefresh>> _apiTokenRefreshPost({
    String? xCurrentShelter,
    required TokenRefresh? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Takes a refresh type JSON web token and returns an access type JSON web
token if the refresh token is valid.''',
      summary: '',
      operationId: 'token_refresh_create',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Token"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<TokenRefresh, TokenRefresh>($request);
  }

  @override
  Future<Response<PaginatedAdopterList>> _apiV1AdoptersGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_adopters_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adopters"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/adopters/');
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedAdopterList, PaginatedAdopterList>($request);
  }

  @override
  Future<Response<Adopter>> _apiV1AdoptersPost({
    String? xCurrentShelter,
    required Adopter? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_adopters_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adopters"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/adopters/');
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
      tag: swaggerMetaData,
    );
    return client.send<Adopter, Adopter>($request);
  }

  @override
  Future<Response<Adopter>> _apiV1AdoptersIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_adopters_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adopters"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/adopters/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<Adopter, Adopter>($request);
  }

  @override
  Future<Response<Adopter>> _apiV1AdoptersIdPut({
    required int? id,
    String? xCurrentShelter,
    required Adopter? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_adopters_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adopters"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/adopters/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<Adopter, Adopter>($request);
  }

  @override
  Future<Response<Adopter>> _apiV1AdoptersIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedAdopter? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_adopters_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adopters"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/adopters/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<Adopter, Adopter>($request);
  }

  @override
  Future<Response<PaginatedAnimalSitterList>> _apiV1AnimalSittersGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for AnimalSitter.',
      summary: '',
      operationId: 'v1_animal_sitters_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["AnimalSitter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animal_sitters/');
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedAnimalSitterList, PaginatedAnimalSitterList>(
      $request,
    );
  }

  @override
  Future<Response<AnimalSitter>> _apiV1AnimalSittersPost({
    String? xCurrentShelter,
    required AnimalSitter? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for AnimalSitter.',
      summary: '',
      operationId: 'v1_animal_sitters_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["AnimalSitter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animal_sitters/');
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalSitter, AnimalSitter>($request);
  }

  @override
  Future<Response<AnimalSitter>> _apiV1AnimalSittersIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for AnimalSitter.',
      summary: '',
      operationId: 'v1_animal_sitters_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["AnimalSitter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animal_sitters/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<AnimalSitter, AnimalSitter>($request);
  }

  @override
  Future<Response<AnimalSitter>> _apiV1AnimalSittersIdPut({
    required int? id,
    String? xCurrentShelter,
    required AnimalSitter? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for AnimalSitter.',
      summary: '',
      operationId: 'v1_animal_sitters_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["AnimalSitter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animal_sitters/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalSitter, AnimalSitter>($request);
  }

  @override
  Future<Response<AnimalSitter>> _apiV1AnimalSittersIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedAnimalSitter? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for AnimalSitter.',
      summary: '',
      operationId: 'v1_animal_sitters_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["AnimalSitter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animal_sitters/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalSitter, AnimalSitter>($request);
  }

  @override
  Future<Response<PaginatedAnimalReadList>> _apiV1AnimalsGet({
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Animal.',
      summary: '',
      operationId: 'v1_animals_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedAnimalReadList, PaginatedAnimalReadList>(
      $request,
    );
  }

  @override
  Future<Response<AnimalRead>> _apiV1AnimalsPost({
    String? xCurrentShelter,
    required AnimalWrite? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Animal.',
      summary: '',
      operationId: 'v1_animals_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<PaginatedAdoptionList>> _apiV1AnimalsAnimalPkAdoptionsGet({
    required int? animalPk,
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_animals_adoptions_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adoptions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/adoptions/');
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedAdoptionList, PaginatedAdoptionList>($request);
  }

  @override
  Future<Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsPost({
    required int? animalPk,
    String? xCurrentShelter,
    required Adoption? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_animals_adoptions_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adoptions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/adoptions/');
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
      tag: swaggerMetaData,
    );
    return client.send<Adoption, Adoption>($request);
  }

  @override
  Future<Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsIdGet({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_animals_adoptions_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adoptions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/adoptions/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<Adoption, Adoption>($request);
  }

  @override
  Future<Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsIdPut({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    required Adoption? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_animals_adoptions_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adoptions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/adoptions/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<Adoption, Adoption>($request);
  }

  @override
  Future<Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsIdPatch({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    required PatchedAdoption? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Adopter.',
      summary: '',
      operationId: 'v1_animals_adoptions_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Adoptions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/adoptions/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<Adoption, Adoption>($request);
  }

  @override
  Future<Response<PaginatedOverstayList>> _apiV1AnimalsAnimalPkOverstaysGet({
    required int? animalPk,
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Overstay.',
      summary: '',
      operationId: 'v1_animals_overstays_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Overstay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/overstays/');
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedOverstayList, PaginatedOverstayList>($request);
  }

  @override
  Future<Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysPost({
    required int? animalPk,
    String? xCurrentShelter,
    required Overstay? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Overstay.',
      summary: '',
      operationId: 'v1_animals_overstays_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Overstay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/overstays/');
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
      tag: swaggerMetaData,
    );
    return client.send<Overstay, Overstay>($request);
  }

  @override
  Future<Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysIdGet({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Overstay.',
      summary: '',
      operationId: 'v1_animals_overstays_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Overstay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/overstays/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<Overstay, Overstay>($request);
  }

  @override
  Future<Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysIdPut({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    required Overstay? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Overstay.',
      summary: '',
      operationId: 'v1_animals_overstays_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Overstay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/overstays/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<Overstay, Overstay>($request);
  }

  @override
  Future<Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysIdPatch({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    required PatchedOverstay? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Overstay.',
      summary: '',
      operationId: 'v1_animals_overstays_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Overstay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/overstays/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<Overstay, Overstay>($request);
  }

  @override
  Future<Response<PaginatedReleaseSerializersList>>
  _apiV1AnimalsAnimalPkReleasesGet({
    required int? animalPk,
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create, Read and Update view for Release.',
      summary: '',
      operationId: 'v1_animals_releases_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Releases"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/releases/');
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
      tag: swaggerMetaData,
    );
    return client
        .send<PaginatedReleaseSerializersList, PaginatedReleaseSerializersList>(
          $request,
        );
  }

  @override
  Future<Response<ReleaseSerializers>> _apiV1AnimalsAnimalPkReleasesPost({
    required int? animalPk,
    String? xCurrentShelter,
    required ReleaseSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create, Read and Update view for Release.',
      summary: '',
      operationId: 'v1_animals_releases_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Releases"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/releases/');
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
      tag: swaggerMetaData,
    );
    return client.send<ReleaseSerializers, ReleaseSerializers>($request);
  }

  @override
  Future<Response<ReleaseSerializers>> _apiV1AnimalsAnimalPkReleasesIdGet({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create, Read and Update view for Release.',
      summary: '',
      operationId: 'v1_animals_releases_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Releases"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/releases/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<ReleaseSerializers, ReleaseSerializers>($request);
  }

  @override
  Future<Response<ReleaseSerializers>> _apiV1AnimalsAnimalPkReleasesIdPut({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    required ReleaseSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create, Read and Update view for Release.',
      summary: '',
      operationId: 'v1_animals_releases_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Releases"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/releases/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<ReleaseSerializers, ReleaseSerializers>($request);
  }

  @override
  Future<Response<ReleaseSerializers>> _apiV1AnimalsAnimalPkReleasesIdPatch({
    required int? animalPk,
    required int? id,
    String? xCurrentShelter,
    required PatchedReleaseSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create, Read and Update view for Release.',
      summary: '',
      operationId: 'v1_animals_releases_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Releases"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${animalPk}/releases/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<ReleaseSerializers, ReleaseSerializers>($request);
  }

  @override
  Future<Response<AnimalRead>> _apiV1AnimalsIdGet({
    required String? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Animal.',
      summary: '',
      operationId: 'v1_animals_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> _apiV1AnimalsIdPut({
    required String? id,
    String? xCurrentShelter,
    required AnimalWrite? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Animal.',
      summary: '',
      operationId: 'v1_animals_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<AnimalRead>> _apiV1AnimalsIdPatch({
    required String? id,
    String? xCurrentShelter,
    required PatchedAnimalWrite? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Animal.',
      summary: '',
      operationId: 'v1_animals_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AnimalsIdDelete({
    required String? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Animal.',
      summary: '',
      operationId: 'v1_animals_destroy',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _apiV1AnimalsIdPdfTypePdfGet({
    required DateTime? from,
    required int? id,
    required String? pdfType,
    required DateTime? to,
    String? tz,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Generate PDF File by Animal, AnimalHistorySnapshot and Prescriptions.',
      summary: '',
      operationId: 'v1_animals_pdf_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/${id}/${pdfType}/pdf/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'from': from,
      'to': to,
      'tz': tz,
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ApplicantFile>>> _apiV1AnimalsIdFilesGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all files between animal and applicant.',
      summary: '',
      operationId: 'v1_animals_files_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List of Animal History Snapshot.',
      summary: '',
      operationId: 'v1_animals_history_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedAnimalHistorySnapshotList,
      PaginatedAnimalHistorySnapshotList
    >($request);
  }

  @override
  Future<Response<Status>> _apiV1AnimalsIdPrimaryImageImagePkPut({
    required String? id,
    required String? imagePk,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Change animal primary photo.',
      summary: '',
      operationId: 'v1_animals_primary_image_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<Status>> _apiV1AnimalsIdRestorePut({
    required String? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Restore soft deleted animal.',
      summary: '',
      operationId: 'v1_animals_restore_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<List<AnimalAttribute>>> _apiV1AnimalsAttributesGet({
    bool? isRequired,
    String? ordering,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Readonly view (list, detail) for AnimalAttribute.',
      summary: '',
      operationId: 'v1_animals_attributes_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<List<AnimalAttribute>, AnimalAttribute>($request);
  }

  @override
  Future<Response<AnimalAttribute>> _apiV1AnimalsAttributesIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Readonly view (list, detail) for AnimalAttribute.',
      summary: '',
      operationId: 'v1_animals_attributes_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalAttribute, AnimalAttribute>($request);
  }

  @override
  Future<Response<PaginatedAnimalNoteList>> _apiV1AnimalsNotesGet({
    int? animal,
    int? limit,
    int? offset,
    String? ordering,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List and Create view for AnimalNote.',
      summary: '',
      operationId: 'v1_animals_notes_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedAnimalNoteList, PaginatedAnimalNoteList>(
      $request,
    );
  }

  @override
  Future<Response<AnimalNote>> _apiV1AnimalsNotesPost({
    String? xCurrentShelter,
    required AnimalNote? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List and Create view for AnimalNote.',
      summary: '',
      operationId: 'v1_animals_notes_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> _apiV1AnimalsNotesIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve, Update, Delete view for AnimalNote.',
      summary: '',
      operationId: 'v1_animals_notes_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> _apiV1AnimalsNotesIdPut({
    required int? id,
    String? xCurrentShelter,
    required AnimalNote? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve, Update, Delete view for AnimalNote.',
      summary: '',
      operationId: 'v1_animals_notes_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<AnimalNote>> _apiV1AnimalsNotesIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedAnimalNote? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve, Update, Delete view for AnimalNote.',
      summary: '',
      operationId: 'v1_animals_notes_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalNote, AnimalNote>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AnimalsNotesIdDelete({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve, Update, Delete view for AnimalNote.',
      summary: '',
      operationId: 'v1_animals_notes_destroy',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
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
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Readonly view (list, detail) for Species.',
      summary: '',
      operationId: 'v1_animals_species_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedSpeciesList, PaginatedSpeciesList>($request);
  }

  @override
  Future<Response<Species>> _apiV1AnimalsSpeciesPost({
    String? xCurrentShelter,
    required Species? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Readonly view (list, detail) for Species.',
      summary: '',
      operationId: 'v1_animals_species_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Species, Species>($request);
  }

  @override
  Future<Response<Species>> _apiV1AnimalsSpeciesIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Readonly view (list, detail) for Species.',
      summary: '',
      operationId: 'v1_animals_species_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Species, Species>($request);
  }

  @override
  Future<Response<AnimalStatsResponse>> _apiV1AnimalsStatsGet({
    String? breeds,
    String? dateJoinedFrom,
    String? dateJoinedTo,
    String? format,
    String? species,
    String? statusTransitions,
    String? statusTransitionsFrom,
    String? statusTransitionsTo,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''An endpoint to collect statistical information about animals.
The endpoint provides the number of animals with respect to different factors.
Currently breeds, species, date_joined_from, date_joined_to, status_transitions_from,
status_transitions_to and status_transitions are supported.
Individual IDs of breeds or species should be separated by comas.
If numbers across all breeds are necessary, then pass `all`.''',
      summary: '',
      operationId: 'v1_animals_stats_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/animals/stats/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'breeds': breeds,
      'date_joined_from': dateJoinedFrom,
      'date_joined_to': dateJoinedTo,
      'format': format,
      'species': species,
      'status_transitions': statusTransitions,
      'status_transitions_from': statusTransitionsFrom,
      'status_transitions_to': statusTransitionsTo,
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
      tag: swaggerMetaData,
    );
    return client.send<AnimalStatsResponse, AnimalStatsResponse>($request);
  }

  @override
  Future<Response<PaginatedApplicantList>> _apiV1ApplicantsGet({
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Applicant.',
      summary: '',
      operationId: 'v1_applicants_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Applicants"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedApplicantList, PaginatedApplicantList>(
      $request,
    );
  }

  @override
  Future<Response<Applicant>> _apiV1ApplicantsPost({
    String? xCurrentShelter,
    required Applicant? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Applicant.',
      summary: '',
      operationId: 'v1_applicants_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Applicants"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> _apiV1ApplicantsIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Applicant.',
      summary: '',
      operationId: 'v1_applicants_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Applicants"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> _apiV1ApplicantsIdPut({
    required int? id,
    String? xCurrentShelter,
    required Applicant? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Applicant.',
      summary: '',
      operationId: 'v1_applicants_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Applicants"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<Applicant>> _apiV1ApplicantsIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedApplicant? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Applicant.',
      summary: '',
      operationId: 'v1_applicants_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Applicants"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Applicant, Applicant>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1ApplicantsIdDelete({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Applicant.',
      summary: '',
      operationId: 'v1_applicants_destroy',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Applicants"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>>
  _apiV1AvailableSheltersGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List of available shelters for authenticated user.',
      summary: '',
      operationId: 'v1_available_shelters_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Shelters"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedShelterShortSerializersList,
      PaginatedShelterShortSerializersList
    >($request);
  }

  @override
  Future<Response<PaginatedCuratorList>> _apiV1CuratorsGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Curator.',
      summary: '',
      operationId: 'v1_curators_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Curators"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedCuratorList, PaginatedCuratorList>($request);
  }

  @override
  Future<Response<Curator>> _apiV1CuratorsPost({
    String? xCurrentShelter,
    required Curator? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Curator.',
      summary: '',
      operationId: 'v1_curators_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Curators"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> _apiV1CuratorsIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Curator.',
      summary: '',
      operationId: 'v1_curators_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Curators"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> _apiV1CuratorsIdPut({
    required int? id,
    String? xCurrentShelter,
    required Curator? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Curator.',
      summary: '',
      operationId: 'v1_curators_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Curators"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<Curator>> _apiV1CuratorsIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedCurator? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Curator.',
      summary: '',
      operationId: 'v1_curators_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Curators"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Curator, Curator>($request);
  }

  @override
  Future<Response<AnimalRead>> _apiV1ExtAnimalsUuidGet({
    required String? uuid,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Public view of an animal, without authorization.
Supports retrieving only now, to prevent scraping.''',
      summary: '',
      operationId: 'v1_ext_animals_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Animals"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/ext/animals/${uuid}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<AnimalRead, AnimalRead>($request);
  }

  @override
  Future<Response<Feedback>> _apiV1FeedbackPost({
    String? xCurrentShelter,
    required Feedback? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Feedback create view.',
      summary: '',
      operationId: 'v1_feedback_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Feedback"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Feedback, Feedback>($request);
  }

  @override
  Future<Response<PaginatedPrescriptionList>> _apiV1PrescriptionsGet({
    int? animal,
    DateTime? executeAtGte,
    DateTime? executeAtLt,
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Prescription.',
      summary: '',
      operationId: 'v1_prescriptions_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedPrescriptionList, PaginatedPrescriptionList>(
      $request,
    );
  }

  @override
  Future<Response<Prescription>> _apiV1PrescriptionsPost({
    String? xCurrentShelter,
    required Prescription? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Prescription.',
      summary: '',
      operationId: 'v1_prescriptions_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> _apiV1PrescriptionsIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Prescription.',
      summary: '',
      operationId: 'v1_prescriptions_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> _apiV1PrescriptionsIdPut({
    required int? id,
    String? xCurrentShelter,
    required Prescription? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Prescription.',
      summary: '',
      operationId: 'v1_prescriptions_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<Prescription>> _apiV1PrescriptionsIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedPrescription? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Prescription.',
      summary: '',
      operationId: 'v1_prescriptions_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Prescription, Prescription>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1PrescriptionsIdDelete({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud view for Prescription.',
      summary: '',
      operationId: 'v1_prescriptions_destroy',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedPrescriptionExecutionTodayList>>
  _apiV1PrescriptionsExecutionsGet({
    required String? from,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    required String? to,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List view for PrescriptionExecution \'today\'.',
      summary: '',
      operationId: 'v1_prescriptions_executions_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Prescriptions"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedPrescriptionExecutionTodayList,
      PaginatedPrescriptionExecutionTodayList
    >($request);
  }

  @override
  Future<Response<PaginatedShelterDrugList>> _apiV1ShelterDrugsGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List of shelter drugs.',
      summary: '',
      operationId: 'v1_shelter_drugs_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Shelters"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<PaginatedShelterDrugList, PaginatedShelterDrugList>(
      $request,
    );
  }

  @override
  Future<Response<PaginatedUserSheltersAdminSerializersList>>
  _apiV1ShelterWorkersGet({
    bool? isVerifiedByAdmin,
    bool? isVerifiedByAdminIsnull,
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud of user shelters workers.',
      summary: '',
      operationId: 'v1_shelter_workers_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedUserSheltersAdminSerializersList,
      PaginatedUserSheltersAdminSerializersList
    >($request);
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> _apiV1ShelterWorkersPost({
    String? xCurrentShelter,
    required UserSheltersAdminSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud of user shelters workers.',
      summary: '',
      operationId: 'v1_shelter_workers_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> _apiV1ShelterWorkersIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud of user shelters workers.',
      summary: '',
      operationId: 'v1_shelter_workers_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> _apiV1ShelterWorkersIdPut({
    required int? id,
    String? xCurrentShelter,
    required UserSheltersAdminSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud of user shelters workers.',
      summary: '',
      operationId: 'v1_shelter_workers_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserSheltersAdminSerializers>> _apiV1ShelterWorkersIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedUserSheltersAdminSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud of user shelters workers.',
      summary: '',
      operationId: 'v1_shelter_workers_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserSheltersAdminSerializers, UserSheltersAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _apiV1ShelterWorkersIdDelete({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Full crud of user shelters workers.',
      summary: '',
      operationId: 'v1_shelter_workers_destroy',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Approve>> _apiV1ShelterWorkersIdApprovePut({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Approve user to shelter.',
      summary: '',
      operationId: 'v1_shelter_workers_approve_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Approve, Approve>($request);
  }

  @override
  Future<Response<Decline>> _apiV1ShelterWorkersIdDeclinePut({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Decline user to shelter.',
      summary: '',
      operationId: 'v1_shelter_workers_decline_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<Decline, Decline>($request);
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>> _apiV1SheltersGet({
    int? limit,
    int? offset,
    String? search,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List of shelters.',
      summary: '',
      operationId: 'v1_shelters_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Shelters"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedShelterShortSerializersList,
      PaginatedShelterShortSerializersList
    >($request);
  }

  @override
  Future<Response<ShelterSerializers>> _apiV1SheltersIdGet({
    required int? id,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve/Update shelter',
      summary: '',
      operationId: 'v1_shelters_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/shelters/${id}/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<ShelterSerializers, ShelterSerializers>($request);
  }

  @override
  Future<Response<ShelterSerializers>> _apiV1SheltersIdPut({
    required int? id,
    String? xCurrentShelter,
    required ShelterSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve/Update shelter',
      summary: '',
      operationId: 'v1_shelters_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/shelters/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<ShelterSerializers, ShelterSerializers>($request);
  }

  @override
  Future<Response<ShelterSerializers>> _apiV1SheltersIdPatch({
    required int? id,
    String? xCurrentShelter,
    required PatchedShelterSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Retrieve/Update shelter',
      summary: '',
      operationId: 'v1_shelters_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Administrator shelter management"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/shelters/${id}/');
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
      tag: swaggerMetaData,
    );
    return client.send<ShelterSerializers, ShelterSerializers>($request);
  }

  @override
  Future<Response<UserSheltersWorkerSerializers>> _apiV1SheltersAddPost({
    String? xCurrentShelter,
    required UserSheltersWorkerSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Add user to shelter.',
      summary: '',
      operationId: 'v1_shelters_add_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Shelters"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserSheltersWorkerSerializers, UserSheltersWorkerSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserShelterAdminSerializers>> _apiV1UsersAdminRegisterPost({
    String? xCurrentShelter,
    required UserShelterAdminSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Register admin with shelter after captcha validation.',
      summary: '',
      operationId: 'v1_users_admin_register_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users registration"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserShelterAdminSerializers, UserShelterAdminSerializers>(
          $request,
        );
  }

  @override
  Future<Response<PaginatedUserShortSerializersList>>
  _apiV1UsersAvailableWorkersGet({
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List of available workers for the shelter.',
      summary: '',
      operationId: 'v1_users_available_workers_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedUserShortSerializersList,
      PaginatedUserShortSerializersList
    >($request);
  }

  @override
  Future<Response<UserSerializers>> _apiV1UsersMeGet({
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'User profile.',
      summary: '',
      operationId: 'v1_users_me_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/users/me/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserSerializers>> _apiV1UsersMePut({
    String? xCurrentShelter,
    required UserSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'User profile.',
      summary: '',
      operationId: 'v1_users_me_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserSerializers>> _apiV1UsersMePatch({
    String? xCurrentShelter,
    required PatchedUserSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'User profile.',
      summary: '',
      operationId: 'v1_users_me_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<UserSerializers, UserSerializers>($request);
  }

  @override
  Future<Response<UserChangePasswordSerializers>>
  _apiV1UsersMeChangePasswordPut({
    String? xCurrentShelter,
    required UserChangePasswordSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Change password.',
      summary: '',
      operationId: 'v1_users_me_change_password_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserChangePasswordSerializers, UserChangePasswordSerializers>(
          $request,
        );
  }

  @override
  Future<Response<UserChangePasswordSerializers>>
  _apiV1UsersMeChangePasswordPatch({
    String? xCurrentShelter,
    required PatchedUserChangePasswordSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Change password.',
      summary: '',
      operationId: 'v1_users_me_change_password_partial_update',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserChangePasswordSerializers, UserChangePasswordSerializers>(
          $request,
        );
  }

  @override
  Future<Response<PaginatedShelterShortSerializersList>>
  _apiV1UsersMeSheltersGet({
    int? limit,
    int? offset,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'List of user shelters.',
      summary: '',
      operationId: 'v1_users_me_shelters_list',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
  }) {
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
      tag: swaggerMetaData,
    );
    return client.send<
      PaginatedShelterShortSerializersList,
      PaginatedShelterShortSerializersList
    >($request);
  }

  @override
  Future<Response<UserCurrentShelterSerializers>>
  _apiV1UsersMeSheltersCurrentGet({
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'User current shelter detail view.',
      summary: '',
      operationId: 'v1_users_me_shelters_current_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/api/v1/users/me/shelters/current/');
    final Map<String, String> $headers = {
      if (xCurrentShelter != null) 'x-current-shelter': xCurrentShelter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client
        .send<UserCurrentShelterSerializers, UserCurrentShelterSerializers>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _apiV1UsersResetPasswordPost({
    String? xCurrentShelter,
    required Email? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''A post method for performing password request.
Returns 400 in case user is not found''',
      summary: '',
      operationId: 'v1_users_reset_password_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersResetPasswordCompletePost({
    String? xCurrentShelter,
    required UserResetPasswordComplete? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''A post method extracts new password, token, uidb64
and calls PasswordResetService service''',
      summary: '',
      operationId: 'v1_users_reset_password_complete_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersResetPasswordConfirmUidb64TokenGet({
    required String? token,
    required String? uidb64,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'A view to verify credentials for the following password reset.',
      summary: '',
      operationId: 'v1_users_reset_password_confirm_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersVerifyEmailUidb64Sidb64TokenGet({
    required String? sidb64,
    required String? token,
    required String? uidb64,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Verify email.',
      summary: '',
      operationId: 'v1_users_verify_email_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users registration"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersVerifyWorkerUidb64Sidb64TokenGet({
    required String? sidb64,
    required String? token,
    required String? uidb64,
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Verify worker to shelter by admin view.',
      summary: '',
      operationId: 'v1_users_verify_worker_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users registration"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserShelterWorkerSerializers>> _apiV1UsersWorkerRegisterPost({
    String? xCurrentShelter,
    required UserShelterWorkerSerializers? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Register worker after captcha validation.',
      summary: '',
      operationId: 'v1_users_worker_register_create',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Users registration"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client
        .send<UserShelterWorkerSerializers, UserShelterWorkerSerializers>(
          $request,
        );
  }

  @override
  Future<Response<ValuesForSelection>> _apiV1ValuesForSelectionGet({
    String? xCurrentShelter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'View for choices values.',
      summary: '',
      operationId: 'v1_values_for_selection_retrieve',
      consumes: [],
      produces: [],
      security: ["cookieAuth", "jwtAuth"],
      tags: ["Values for selection"],
      deprecated: false,
    ),
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
      tag: swaggerMetaData,
    );
    return client.send<ValuesForSelection, ValuesForSelection>($request);
  }
}
