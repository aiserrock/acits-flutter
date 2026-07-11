// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element_parameter

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'openapi.enums.swagger.dart' as enums;
import 'openapi.metadata.swagger.dart';
export 'openapi.enums.swagger.dart';

part 'openapi.swagger.chopper.dart';
part 'openapi.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Openapi extends ChopperService {
  static Openapi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Openapi(client);
    }

    final newClient = ChopperClient(
      services: [_$Openapi()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$Openapi(newClient);
  }

  ///
  ///@param format
  ///@param lang
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Object>> apiSchemaGet({
    enums.ApiSchemaGetFormat? format,
    enums.ApiSchemaGetLang? lang,
    int? xCurrentShelter,
  }) {
    return _apiSchemaGet(
      format: format?.value?.toString(),
      lang: lang?.value?.toString(),
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param format
  ///@param lang
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/schema/')
  Future<chopper.Response<Object>> _apiSchemaGet({
    @Query('format') String? format,
    @Query('lang') String? lang,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<TokenObtainPair>> apiTokenPost({
    int? xCurrentShelter,
    required TokenObtainPair? body,
  }) {
    generatedMapping.putIfAbsent(
      TokenObtainPair,
      () => TokenObtainPair.fromJsonFactory,
    );

    return _apiTokenPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/token/', optionalBody: true)
  Future<chopper.Response<TokenObtainPair>> _apiTokenPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required TokenObtainPair? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<TokenRefresh>> apiTokenRefreshPost({
    int? xCurrentShelter,
    required TokenRefresh? body,
  }) {
    generatedMapping.putIfAbsent(
      TokenRefresh,
      () => TokenRefresh.fromJsonFactory,
    );

    return _apiTokenRefreshPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/token/refresh/', optionalBody: true)
  Future<chopper.Response<TokenRefresh>> _apiTokenRefreshPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required TokenRefresh? body,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAdopterList>> apiV1AdoptersGet({
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedAdopterList,
      () => PaginatedAdopterList.fromJsonFactory,
    );

    return _apiV1AdoptersGet(
      limit: limit,
      offset: offset,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/adopters/')
  Future<chopper.Response<PaginatedAdopterList>> _apiV1AdoptersGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adopter>> apiV1AdoptersPost({
    int? xCurrentShelter,
    required Adopter? body,
  }) {
    generatedMapping.putIfAbsent(Adopter, () => Adopter.fromJsonFactory);

    return _apiV1AdoptersPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/adopters/', optionalBody: true)
  Future<chopper.Response<Adopter>> _apiV1AdoptersPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Adopter? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Adopter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adopter>> apiV1AdoptersIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Adopter, () => Adopter.fromJsonFactory);

    return _apiV1AdoptersIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Adopter.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/adopters/{id}/')
  Future<chopper.Response<Adopter>> _apiV1AdoptersIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Adopter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adopter>> apiV1AdoptersIdPut({
    required int? id,
    int? xCurrentShelter,
    required Adopter? body,
  }) {
    generatedMapping.putIfAbsent(Adopter, () => Adopter.fromJsonFactory);

    return _apiV1AdoptersIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Adopter.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/adopters/{id}/', optionalBody: true)
  Future<chopper.Response<Adopter>> _apiV1AdoptersIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Adopter? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Adopter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adopter>> apiV1AdoptersIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedAdopter? body,
  }) {
    generatedMapping.putIfAbsent(Adopter, () => Adopter.fromJsonFactory);

    return _apiV1AdoptersIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Adopter.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/adopters/{id}/', optionalBody: true)
  Future<chopper.Response<Adopter>> _apiV1AdoptersIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedAdopter? body,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAnimalSitterList>> apiV1AnimalSittersGet({
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedAnimalSitterList,
      () => PaginatedAnimalSitterList.fromJsonFactory,
    );

    return _apiV1AnimalSittersGet(
      limit: limit,
      offset: offset,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animal_sitters/')
  Future<chopper.Response<PaginatedAnimalSitterList>> _apiV1AnimalSittersGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalSitter>> apiV1AnimalSittersPost({
    int? xCurrentShelter,
    required AnimalSitter? body,
  }) {
    generatedMapping.putIfAbsent(
      AnimalSitter,
      () => AnimalSitter.fromJsonFactory,
    );

    return _apiV1AnimalSittersPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animal_sitters/', optionalBody: true)
  Future<chopper.Response<AnimalSitter>> _apiV1AnimalSittersPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required AnimalSitter? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this AnimalSitter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalSitter>> apiV1AnimalSittersIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      AnimalSitter,
      () => AnimalSitter.fromJsonFactory,
    );

    return _apiV1AnimalSittersIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this AnimalSitter.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animal_sitters/{id}/')
  Future<chopper.Response<AnimalSitter>> _apiV1AnimalSittersIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this AnimalSitter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalSitter>> apiV1AnimalSittersIdPut({
    required int? id,
    int? xCurrentShelter,
    required AnimalSitter? body,
  }) {
    generatedMapping.putIfAbsent(
      AnimalSitter,
      () => AnimalSitter.fromJsonFactory,
    );

    return _apiV1AnimalSittersIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this AnimalSitter.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animal_sitters/{id}/', optionalBody: true)
  Future<chopper.Response<AnimalSitter>> _apiV1AnimalSittersIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required AnimalSitter? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this AnimalSitter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalSitter>> apiV1AnimalSittersIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedAnimalSitter? body,
  }) {
    generatedMapping.putIfAbsent(
      AnimalSitter,
      () => AnimalSitter.fromJsonFactory,
    );

    return _apiV1AnimalSittersIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this AnimalSitter.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/animal_sitters/{id}/', optionalBody: true)
  Future<chopper.Response<AnimalSitter>> _apiV1AnimalSittersIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedAnimalSitter? body,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAnimalReadList>> apiV1AnimalsGet({
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedAnimalReadList,
      () => PaginatedAnimalReadList.fromJsonFactory,
    );

    return _apiV1AnimalsGet(
      limit: limit,
      offset: offset,
      ordering: ordering,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/')
  Future<chopper.Response<PaginatedAnimalReadList>> _apiV1AnimalsGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalRead>> apiV1AnimalsPost({
    int? xCurrentShelter,
    required AnimalWrite? body,
  }) {
    generatedMapping.putIfAbsent(AnimalRead, () => AnimalRead.fromJsonFactory);

    return _apiV1AnimalsPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animals/', optionalBody: true)
  Future<chopper.Response<AnimalRead>> _apiV1AnimalsPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required AnimalWrite? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAdoptionList>>
  apiV1AnimalsAnimalPkAdoptionsGet({
    required int? animalPk,
    int? limit,
    int? offset,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedAdoptionList,
      () => PaginatedAdoptionList.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkAdoptionsGet(
      animalPk: animalPk,
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal_pk
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{animal_pk}/adoptions/')
  Future<chopper.Response<PaginatedAdoptionList>>
  _apiV1AnimalsAnimalPkAdoptionsGet({
    @Path('animal_pk') required int? animalPk,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adoption>> apiV1AnimalsAnimalPkAdoptionsPost({
    required int? animalPk,
    int? xCurrentShelter,
    required Adoption? body,
  }) {
    generatedMapping.putIfAbsent(Adoption, () => Adoption.fromJsonFactory);

    return _apiV1AnimalsAnimalPkAdoptionsPost(
      animalPk: animalPk,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animals/{animal_pk}/adoptions/', optionalBody: true)
  Future<chopper.Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsPost({
    @Path('animal_pk') required int? animalPk,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Adoption? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Adoption.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adoption>> apiV1AnimalsAnimalPkAdoptionsIdGet({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Adoption, () => Adoption.fromJsonFactory);

    return _apiV1AnimalsAnimalPkAdoptionsIdGet(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Adoption.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{animal_pk}/adoptions/{id}/')
  Future<chopper.Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsIdGet({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Adoption.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adoption>> apiV1AnimalsAnimalPkAdoptionsIdPut({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
    required Adoption? body,
  }) {
    generatedMapping.putIfAbsent(Adoption, () => Adoption.fromJsonFactory);

    return _apiV1AnimalsAnimalPkAdoptionsIdPut(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Adoption.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animals/{animal_pk}/adoptions/{id}/', optionalBody: true)
  Future<chopper.Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsIdPut({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Adoption? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Adoption.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Adoption>> apiV1AnimalsAnimalPkAdoptionsIdPatch({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
    required PatchedAdoption? body,
  }) {
    generatedMapping.putIfAbsent(Adoption, () => Adoption.fromJsonFactory);

    return _apiV1AnimalsAnimalPkAdoptionsIdPatch(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Adoption.
  ///@param x-current-shelter Set current shelter id
  @PATCH(
    path: '/api/v1/animals/{animal_pk}/adoptions/{id}/',
    optionalBody: true,
  )
  Future<chopper.Response<Adoption>> _apiV1AnimalsAnimalPkAdoptionsIdPatch({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedAdoption? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedOverstayList>>
  apiV1AnimalsAnimalPkOverstaysGet({
    required int? animalPk,
    int? limit,
    int? offset,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedOverstayList,
      () => PaginatedOverstayList.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkOverstaysGet(
      animalPk: animalPk,
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal_pk
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{animal_pk}/overstays/')
  Future<chopper.Response<PaginatedOverstayList>>
  _apiV1AnimalsAnimalPkOverstaysGet({
    @Path('animal_pk') required int? animalPk,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Overstay>> apiV1AnimalsAnimalPkOverstaysPost({
    required int? animalPk,
    int? xCurrentShelter,
    required Overstay? body,
  }) {
    generatedMapping.putIfAbsent(Overstay, () => Overstay.fromJsonFactory);

    return _apiV1AnimalsAnimalPkOverstaysPost(
      animalPk: animalPk,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animals/{animal_pk}/overstays/', optionalBody: true)
  Future<chopper.Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysPost({
    @Path('animal_pk') required int? animalPk,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Overstay? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Overstay.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Overstay>> apiV1AnimalsAnimalPkOverstaysIdGet({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Overstay, () => Overstay.fromJsonFactory);

    return _apiV1AnimalsAnimalPkOverstaysIdGet(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Overstay.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{animal_pk}/overstays/{id}/')
  Future<chopper.Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysIdGet({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Overstay.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Overstay>> apiV1AnimalsAnimalPkOverstaysIdPut({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
    required Overstay? body,
  }) {
    generatedMapping.putIfAbsent(Overstay, () => Overstay.fromJsonFactory);

    return _apiV1AnimalsAnimalPkOverstaysIdPut(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Overstay.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animals/{animal_pk}/overstays/{id}/', optionalBody: true)
  Future<chopper.Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysIdPut({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Overstay? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Overstay.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Overstay>> apiV1AnimalsAnimalPkOverstaysIdPatch({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
    required PatchedOverstay? body,
  }) {
    generatedMapping.putIfAbsent(Overstay, () => Overstay.fromJsonFactory);

    return _apiV1AnimalsAnimalPkOverstaysIdPatch(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Overstay.
  ///@param x-current-shelter Set current shelter id
  @PATCH(
    path: '/api/v1/animals/{animal_pk}/overstays/{id}/',
    optionalBody: true,
  )
  Future<chopper.Response<Overstay>> _apiV1AnimalsAnimalPkOverstaysIdPatch({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedOverstay? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedReleaseSerializersList>>
  apiV1AnimalsAnimalPkReleasesGet({
    required int? animalPk,
    int? limit,
    int? offset,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedReleaseSerializersList,
      () => PaginatedReleaseSerializersList.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkReleasesGet(
      animalPk: animalPk,
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal_pk
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{animal_pk}/releases/')
  Future<chopper.Response<PaginatedReleaseSerializersList>>
  _apiV1AnimalsAnimalPkReleasesGet({
    @Path('animal_pk') required int? animalPk,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ReleaseSerializers>>
  apiV1AnimalsAnimalPkReleasesPost({
    required int? animalPk,
    int? xCurrentShelter,
    required ReleaseSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      ReleaseSerializers,
      () => ReleaseSerializers.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkReleasesPost(
      animalPk: animalPk,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animals/{animal_pk}/releases/', optionalBody: true)
  Future<chopper.Response<ReleaseSerializers>>
  _apiV1AnimalsAnimalPkReleasesPost({
    @Path('animal_pk') required int? animalPk,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required ReleaseSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Release.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ReleaseSerializers>>
  apiV1AnimalsAnimalPkReleasesIdGet({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      ReleaseSerializers,
      () => ReleaseSerializers.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkReleasesIdGet(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Release.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{animal_pk}/releases/{id}/')
  Future<chopper.Response<ReleaseSerializers>>
  _apiV1AnimalsAnimalPkReleasesIdGet({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Release.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ReleaseSerializers>>
  apiV1AnimalsAnimalPkReleasesIdPut({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
    required ReleaseSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      ReleaseSerializers,
      () => ReleaseSerializers.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkReleasesIdPut(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Release.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animals/{animal_pk}/releases/{id}/', optionalBody: true)
  Future<chopper.Response<ReleaseSerializers>>
  _apiV1AnimalsAnimalPkReleasesIdPut({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required ReleaseSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Release.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ReleaseSerializers>>
  apiV1AnimalsAnimalPkReleasesIdPatch({
    required int? animalPk,
    required int? id,
    int? xCurrentShelter,
    required PatchedReleaseSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      ReleaseSerializers,
      () => ReleaseSerializers.fromJsonFactory,
    );

    return _apiV1AnimalsAnimalPkReleasesIdPatch(
      animalPk: animalPk,
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param animal_pk
  ///@param id A unique integer value identifying this Release.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/animals/{animal_pk}/releases/{id}/', optionalBody: true)
  Future<chopper.Response<ReleaseSerializers>>
  _apiV1AnimalsAnimalPkReleasesIdPatch({
    @Path('animal_pk') required int? animalPk,
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedReleaseSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalRead>> apiV1AnimalsIdGet({
    required String? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(AnimalRead, () => AnimalRead.fromJsonFactory);

    return _apiV1AnimalsIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{id}/')
  Future<chopper.Response<AnimalRead>> _apiV1AnimalsIdGet({
    @Path('id') required String? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalRead>> apiV1AnimalsIdPut({
    required String? id,
    int? xCurrentShelter,
    required AnimalWrite? body,
  }) {
    generatedMapping.putIfAbsent(AnimalRead, () => AnimalRead.fromJsonFactory);

    return _apiV1AnimalsIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animals/{id}/', optionalBody: true)
  Future<chopper.Response<AnimalRead>> _apiV1AnimalsIdPut({
    @Path('id') required String? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required AnimalWrite? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalRead>> apiV1AnimalsIdPatch({
    required String? id,
    int? xCurrentShelter,
    required PatchedAnimalWrite? body,
  }) {
    generatedMapping.putIfAbsent(AnimalRead, () => AnimalRead.fromJsonFactory);

    return _apiV1AnimalsIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/animals/{id}/', optionalBody: true)
  Future<chopper.Response<AnimalRead>> _apiV1AnimalsIdPatch({
    @Path('id') required String? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedAnimalWrite? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1AnimalsIdDelete({
    required String? id,
    int? xCurrentShelter,
  }) {
    return _apiV1AnimalsIdDelete(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @DELETE(path: '/api/v1/animals/{id}/')
  Future<chopper.Response> _apiV1AnimalsIdDelete({
    @Path('id') required String? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param from From datetime, should be UTC
  ///@param id
  ///@param pdf_type One of ('history', 'history-editing', 'history-prescriptions')
  ///@param to To datetime, should be UTC
  ///@param tz Time Zone. It is only used inside pdf rendering
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<String>> apiV1AnimalsIdPdfTypePdfGet({
    required DateTime? from,
    required int? id,
    required String? pdfType,
    required DateTime? to,
    String? tz,
    int? xCurrentShelter,
  }) {
    return _apiV1AnimalsIdPdfTypePdfGet(
      from: from,
      id: id,
      pdfType: pdfType,
      to: to,
      tz: tz,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param from From datetime, should be UTC
  ///@param id
  ///@param pdf_type One of ('history', 'history-editing', 'history-prescriptions')
  ///@param to To datetime, should be UTC
  ///@param tz Time Zone. It is only used inside pdf rendering
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{id}/{pdf_type}/pdf/')
  Future<chopper.Response<String>> _apiV1AnimalsIdPdfTypePdfGet({
    @Query('from') required DateTime? from,
    @Path('id') required int? id,
    @Path('pdf_type') required String? pdfType,
    @Query('to') required DateTime? to,
    @Query('tz') String? tz,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Applicant File.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<List<ApplicantFile>>> apiV1AnimalsIdFilesGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      ApplicantFile,
      () => ApplicantFile.fromJsonFactory,
    );

    return _apiV1AnimalsIdFilesGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Applicant File.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{id}/files/')
  Future<chopper.Response<List<ApplicantFile>>> _apiV1AnimalsIdFilesGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param created_at_after Date range from - to
  ///@param created_at_before Date range from - to
  ///@param created_at_range Date range  * `today` - Today * `yesterday` - Yesterday * `week` - Past 7 days * `month` - This month * `year` - This year
  ///@param id
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAnimalHistorySnapshotList>>
  apiV1AnimalsIdHistoryGet({
    String? createdAtAfter,
    String? createdAtBefore,
    enums.ApiV1AnimalsIdHistoryGetCreatedAtRange? createdAtRange,
    required int? id,
    int? limit,
    int? offset,
    String? ordering,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedAnimalHistorySnapshotList,
      () => PaginatedAnimalHistorySnapshotList.fromJsonFactory,
    );

    return _apiV1AnimalsIdHistoryGet(
      createdAtAfter: createdAtAfter,
      createdAtBefore: createdAtBefore,
      createdAtRange: createdAtRange?.value?.toString(),
      id: id,
      limit: limit,
      offset: offset,
      ordering: ordering,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param created_at_after Date range from - to
  ///@param created_at_before Date range from - to
  ///@param created_at_range Date range  * `today` - Today * `yesterday` - Yesterday * `week` - Past 7 days * `month` - This month * `year` - This year
  ///@param id
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/{id}/history/')
  Future<chopper.Response<PaginatedAnimalHistorySnapshotList>>
  _apiV1AnimalsIdHistoryGet({
    @Query('created_at_after') String? createdAtAfter,
    @Query('created_at_before') String? createdAtBefore,
    @Query('created_at_range') String? createdAtRange,
    @Path('id') required int? id,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param image_pk
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Status>> apiV1AnimalsIdPrimaryImageImagePkPut({
    required String? id,
    required String? imagePk,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Status, () => Status.fromJsonFactory);

    return _apiV1AnimalsIdPrimaryImageImagePkPut(
      id: id,
      imagePk: imagePk,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param image_pk
  ///@param x-current-shelter Set current shelter id
  @PUT(
    path: '/api/v1/animals/{id}/primary_image/{image_pk}/',
    optionalBody: true,
  )
  Future<chopper.Response<Status>> _apiV1AnimalsIdPrimaryImageImagePkPut({
    @Path('id') required String? id,
    @Path('image_pk') required String? imagePk,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Status>> apiV1AnimalsIdRestorePut({
    required String? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Status, () => Status.fromJsonFactory);

    return _apiV1AnimalsIdRestorePut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animals/{id}/restore/', optionalBody: true)
  Future<chopper.Response<Status>> _apiV1AnimalsIdRestorePut({
    @Path('id') required String? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param is_required
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<List<AnimalAttribute>>> apiV1AnimalsAttributesGet({
    bool? isRequired,
    String? ordering,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      AnimalAttribute,
      () => AnimalAttribute.fromJsonFactory,
    );

    return _apiV1AnimalsAttributesGet(
      isRequired: isRequired,
      ordering: ordering,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param is_required
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/attributes/')
  Future<chopper.Response<List<AnimalAttribute>>> _apiV1AnimalsAttributesGet({
    @Query('is_required') bool? isRequired,
    @Query('ordering') String? ordering,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Animal Attribute.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalAttribute>> apiV1AnimalsAttributesIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      AnimalAttribute,
      () => AnimalAttribute.fromJsonFactory,
    );

    return _apiV1AnimalsAttributesIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Animal Attribute.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/attributes/{id}/')
  Future<chopper.Response<AnimalAttribute>> _apiV1AnimalsAttributesIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param animal
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedAnimalNoteList>> apiV1AnimalsNotesGet({
    int? animal,
    int? limit,
    int? offset,
    String? ordering,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedAnimalNoteList,
      () => PaginatedAnimalNoteList.fromJsonFactory,
    );

    return _apiV1AnimalsNotesGet(
      animal: animal,
      limit: limit,
      offset: offset,
      ordering: ordering,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/notes/')
  Future<chopper.Response<PaginatedAnimalNoteList>> _apiV1AnimalsNotesGet({
    @Query('animal') int? animal,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesPost({
    int? xCurrentShelter,
    required AnimalNote? body,
  }) {
    generatedMapping.putIfAbsent(AnimalNote, () => AnimalNote.fromJsonFactory);

    return _apiV1AnimalsNotesPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animals/notes/', optionalBody: true)
  Future<chopper.Response<AnimalNote>> _apiV1AnimalsNotesPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required AnimalNote? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(AnimalNote, () => AnimalNote.fromJsonFactory);

    return _apiV1AnimalsNotesIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/notes/{id}/')
  Future<chopper.Response<AnimalNote>> _apiV1AnimalsNotesIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesIdPut({
    required int? id,
    int? xCurrentShelter,
    required AnimalNote? body,
  }) {
    generatedMapping.putIfAbsent(AnimalNote, () => AnimalNote.fromJsonFactory);

    return _apiV1AnimalsNotesIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/animals/notes/{id}/', optionalBody: true)
  Future<chopper.Response<AnimalNote>> _apiV1AnimalsNotesIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required AnimalNote? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalNote>> apiV1AnimalsNotesIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedAnimalNote? body,
  }) {
    generatedMapping.putIfAbsent(AnimalNote, () => AnimalNote.fromJsonFactory);

    return _apiV1AnimalsNotesIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/animals/notes/{id}/', optionalBody: true)
  Future<chopper.Response<AnimalNote>> _apiV1AnimalsNotesIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedAnimalNote? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1AnimalsNotesIdDelete({
    required int? id,
    int? xCurrentShelter,
  }) {
    return _apiV1AnimalsNotesIdDelete(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @DELETE(path: '/api/v1/animals/notes/{id}/')
  Future<chopper.Response> _apiV1AnimalsNotesIdDelete({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param level Level of species  * `1` - One * `2` - Two * `3` - Three
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param parent_id
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedSpeciesList>> apiV1AnimalsSpeciesGet({
    enums.ApiV1AnimalsSpeciesGetLevel? level,
    int? limit,
    int? offset,
    String? ordering,
    int? parentId,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedSpeciesList,
      () => PaginatedSpeciesList.fromJsonFactory,
    );

    return _apiV1AnimalsSpeciesGet(
      level: level?.value?.toString(),
      limit: limit,
      offset: offset,
      ordering: ordering,
      parentId: parentId,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param level Level of species  * `1` - One * `2` - Two * `3` - Three
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param parent_id
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/species/')
  Future<chopper.Response<PaginatedSpeciesList>> _apiV1AnimalsSpeciesGet({
    @Query('level') String? level,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('parent_id') int? parentId,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Species>> apiV1AnimalsSpeciesPost({
    int? xCurrentShelter,
    required Species? body,
  }) {
    generatedMapping.putIfAbsent(Species, () => Species.fromJsonFactory);

    return _apiV1AnimalsSpeciesPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/animals/species/', optionalBody: true)
  Future<chopper.Response<Species>> _apiV1AnimalsSpeciesPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Species? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Species.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Species>> apiV1AnimalsSpeciesIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Species, () => Species.fromJsonFactory);

    return _apiV1AnimalsSpeciesIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Species.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/species/{id}/')
  Future<chopper.Response<Species>> _apiV1AnimalsSpeciesIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param breeds
  ///@param date_joined_from
  ///@param date_joined_to
  ///@param format
  ///@param species
  ///@param status_transitions
  ///@param status_transitions_from
  ///@param status_transitions_to
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalStatsResponse>> apiV1AnimalsStatsGet({
    String? breeds,
    String? dateJoinedFrom,
    String? dateJoinedTo,
    enums.ApiV1AnimalsStatsGetFormat? format,
    String? species,
    String? statusTransitions,
    String? statusTransitionsFrom,
    String? statusTransitionsTo,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      AnimalStatsResponse,
      () => AnimalStatsResponse.fromJsonFactory,
    );

    return _apiV1AnimalsStatsGet(
      breeds: breeds,
      dateJoinedFrom: dateJoinedFrom,
      dateJoinedTo: dateJoinedTo,
      format: format?.value?.toString(),
      species: species,
      statusTransitions: statusTransitions,
      statusTransitionsFrom: statusTransitionsFrom,
      statusTransitionsTo: statusTransitionsTo,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param breeds
  ///@param date_joined_from
  ///@param date_joined_to
  ///@param format
  ///@param species
  ///@param status_transitions
  ///@param status_transitions_from
  ///@param status_transitions_to
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/animals/stats/')
  Future<chopper.Response<AnimalStatsResponse>> _apiV1AnimalsStatsGet({
    @Query('breeds') String? breeds,
    @Query('date_joined_from') String? dateJoinedFrom,
    @Query('date_joined_to') String? dateJoinedTo,
    @Query('format') String? format,
    @Query('species') String? species,
    @Query('status_transitions') String? statusTransitions,
    @Query('status_transitions_from') String? statusTransitionsFrom,
    @Query('status_transitions_to') String? statusTransitionsTo,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedApplicantList>> apiV1ApplicantsGet({
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedApplicantList,
      () => PaginatedApplicantList.fromJsonFactory,
    );

    return _apiV1ApplicantsGet(
      limit: limit,
      offset: offset,
      ordering: ordering,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/applicants/')
  Future<chopper.Response<PaginatedApplicantList>> _apiV1ApplicantsGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Applicant>> apiV1ApplicantsPost({
    int? xCurrentShelter,
    required Applicant? body,
  }) {
    generatedMapping.putIfAbsent(Applicant, () => Applicant.fromJsonFactory);

    return _apiV1ApplicantsPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/applicants/', optionalBody: true)
  Future<chopper.Response<Applicant>> _apiV1ApplicantsPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Applicant? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Applicant>> apiV1ApplicantsIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Applicant, () => Applicant.fromJsonFactory);

    return _apiV1ApplicantsIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/applicants/{id}/')
  Future<chopper.Response<Applicant>> _apiV1ApplicantsIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Applicant>> apiV1ApplicantsIdPut({
    required int? id,
    int? xCurrentShelter,
    required Applicant? body,
  }) {
    generatedMapping.putIfAbsent(Applicant, () => Applicant.fromJsonFactory);

    return _apiV1ApplicantsIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/applicants/{id}/', optionalBody: true)
  Future<chopper.Response<Applicant>> _apiV1ApplicantsIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Applicant? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Applicant>> apiV1ApplicantsIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedApplicant? body,
  }) {
    generatedMapping.putIfAbsent(Applicant, () => Applicant.fromJsonFactory);

    return _apiV1ApplicantsIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/applicants/{id}/', optionalBody: true)
  Future<chopper.Response<Applicant>> _apiV1ApplicantsIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedApplicant? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1ApplicantsIdDelete({
    required int? id,
    int? xCurrentShelter,
  }) {
    return _apiV1ApplicantsIdDelete(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Applicant.
  ///@param x-current-shelter Set current shelter id
  @DELETE(path: '/api/v1/applicants/{id}/')
  Future<chopper.Response> _apiV1ApplicantsIdDelete({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedShelterShortSerializersList>>
  apiV1AvailableSheltersGet({
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedShelterShortSerializersList,
      () => PaginatedShelterShortSerializersList.fromJsonFactory,
    );

    return _apiV1AvailableSheltersGet(
      limit: limit,
      offset: offset,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/available-shelters/')
  Future<chopper.Response<PaginatedShelterShortSerializersList>>
  _apiV1AvailableSheltersGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedCuratorList>> apiV1CuratorsGet({
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedCuratorList,
      () => PaginatedCuratorList.fromJsonFactory,
    );

    return _apiV1CuratorsGet(
      limit: limit,
      offset: offset,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/curators/')
  Future<chopper.Response<PaginatedCuratorList>> _apiV1CuratorsGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Curator>> apiV1CuratorsPost({
    int? xCurrentShelter,
    required Curator? body,
  }) {
    generatedMapping.putIfAbsent(Curator, () => Curator.fromJsonFactory);

    return _apiV1CuratorsPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/curators/', optionalBody: true)
  Future<chopper.Response<Curator>> _apiV1CuratorsPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Curator? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Curator>> apiV1CuratorsIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Curator, () => Curator.fromJsonFactory);

    return _apiV1CuratorsIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/curators/{id}/')
  Future<chopper.Response<Curator>> _apiV1CuratorsIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Curator>> apiV1CuratorsIdPut({
    required int? id,
    int? xCurrentShelter,
    required Curator? body,
  }) {
    generatedMapping.putIfAbsent(Curator, () => Curator.fromJsonFactory);

    return _apiV1CuratorsIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/curators/{id}/', optionalBody: true)
  Future<chopper.Response<Curator>> _apiV1CuratorsIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Curator? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Curator>> apiV1CuratorsIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedCurator? body,
  }) {
    generatedMapping.putIfAbsent(Curator, () => Curator.fromJsonFactory);

    return _apiV1CuratorsIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Curator.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/curators/{id}/', optionalBody: true)
  Future<chopper.Response<Curator>> _apiV1CuratorsIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedCurator? body,
    @chopper.Tag()
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
  });

  ///
  ///@param uuid
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<AnimalRead>> apiV1ExtAnimalsUuidGet({
    required String? uuid,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(AnimalRead, () => AnimalRead.fromJsonFactory);

    return _apiV1ExtAnimalsUuidGet(
      uuid: uuid,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param uuid
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/ext/animals/{uuid}/')
  Future<chopper.Response<AnimalRead>> _apiV1ExtAnimalsUuidGet({
    @Path('uuid') required String? uuid,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Feedback>> apiV1FeedbackPost({
    int? xCurrentShelter,
    required Feedback? body,
  }) {
    generatedMapping.putIfAbsent(Feedback, () => Feedback.fromJsonFactory);

    return _apiV1FeedbackPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/feedback/', optionalBody: true)
  Future<chopper.Response<Feedback>> _apiV1FeedbackPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Feedback? body,
    @chopper.Tag()
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
  });

  ///
  ///@param animal
  ///@param execute_at__gte
  ///@param execute_at__lt
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedPrescriptionList>> apiV1PrescriptionsGet({
    int? animal,
    DateTime? executeAtGte,
    DateTime? executeAtLt,
    int? limit,
    int? offset,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedPrescriptionList,
      () => PaginatedPrescriptionList.fromJsonFactory,
    );

    return _apiV1PrescriptionsGet(
      animal: animal,
      executeAtGte: executeAtGte,
      executeAtLt: executeAtLt,
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param animal
  ///@param execute_at__gte
  ///@param execute_at__lt
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/prescriptions/')
  Future<chopper.Response<PaginatedPrescriptionList>> _apiV1PrescriptionsGet({
    @Query('animal') int? animal,
    @Query('execute_at__gte') DateTime? executeAtGte,
    @Query('execute_at__lt') DateTime? executeAtLt,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Prescription>> apiV1PrescriptionsPost({
    int? xCurrentShelter,
    required Prescription? body,
  }) {
    generatedMapping.putIfAbsent(
      Prescription,
      () => Prescription.fromJsonFactory,
    );

    return _apiV1PrescriptionsPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/prescriptions/', optionalBody: true)
  Future<chopper.Response<Prescription>> _apiV1PrescriptionsPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Prescription? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Prescription>> apiV1PrescriptionsIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      Prescription,
      () => Prescription.fromJsonFactory,
    );

    return _apiV1PrescriptionsIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/prescriptions/{id}/')
  Future<chopper.Response<Prescription>> _apiV1PrescriptionsIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Prescription>> apiV1PrescriptionsIdPut({
    required int? id,
    int? xCurrentShelter,
    required Prescription? body,
  }) {
    generatedMapping.putIfAbsent(
      Prescription,
      () => Prescription.fromJsonFactory,
    );

    return _apiV1PrescriptionsIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/prescriptions/{id}/', optionalBody: true)
  Future<chopper.Response<Prescription>> _apiV1PrescriptionsIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Prescription? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Prescription>> apiV1PrescriptionsIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedPrescription? body,
  }) {
    generatedMapping.putIfAbsent(
      Prescription,
      () => Prescription.fromJsonFactory,
    );

    return _apiV1PrescriptionsIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/prescriptions/{id}/', optionalBody: true)
  Future<chopper.Response<Prescription>> _apiV1PrescriptionsIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedPrescription? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1PrescriptionsIdDelete({
    required int? id,
    int? xCurrentShelter,
  }) {
    return _apiV1PrescriptionsIdDelete(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this Prescription.
  ///@param x-current-shelter Set current shelter id
  @DELETE(path: '/api/v1/prescriptions/{id}/')
  Future<chopper.Response> _apiV1PrescriptionsIdDelete({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param from From datetime
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param to To datetime
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedPrescriptionExecutionTodayList>>
  apiV1PrescriptionsExecutionsGet({
    required String? from,
    int? limit,
    int? offset,
    String? ordering,
    String? search,
    required String? to,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedPrescriptionExecutionTodayList,
      () => PaginatedPrescriptionExecutionTodayList.fromJsonFactory,
    );

    return _apiV1PrescriptionsExecutionsGet(
      from: from,
      limit: limit,
      offset: offset,
      ordering: ordering,
      search: search,
      to: to,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param from From datetime
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param ordering Which field to use when ordering the results.
  ///@param search A search term.
  ///@param to To datetime
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/prescriptions/executions/')
  Future<chopper.Response<PaginatedPrescriptionExecutionTodayList>>
  _apiV1PrescriptionsExecutionsGet({
    @Path('from') required String? from,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('ordering') String? ordering,
    @Query('search') String? search,
    @Path('to') required String? to,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedShelterDrugList>> apiV1ShelterDrugsGet({
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedShelterDrugList,
      () => PaginatedShelterDrugList.fromJsonFactory,
    );

    return _apiV1ShelterDrugsGet(
      limit: limit,
      offset: offset,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/shelter/drugs/')
  Future<chopper.Response<PaginatedShelterDrugList>> _apiV1ShelterDrugsGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param is_verified_by_admin Is verified by admin (true/false)
  ///@param is_verified_by_admin__isnull Is verified by admin isnull (true/false)
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedUserSheltersAdminSerializersList>>
  apiV1ShelterWorkersGet({
    bool? isVerifiedByAdmin,
    bool? isVerifiedByAdminIsnull,
    int? limit,
    int? offset,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedUserSheltersAdminSerializersList,
      () => PaginatedUserSheltersAdminSerializersList.fromJsonFactory,
    );

    return _apiV1ShelterWorkersGet(
      isVerifiedByAdmin: isVerifiedByAdmin,
      isVerifiedByAdminIsnull: isVerifiedByAdminIsnull,
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param is_verified_by_admin Is verified by admin (true/false)
  ///@param is_verified_by_admin__isnull Is verified by admin isnull (true/false)
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/shelter/workers/')
  Future<chopper.Response<PaginatedUserSheltersAdminSerializersList>>
  _apiV1ShelterWorkersGet({
    @Query('is_verified_by_admin') bool? isVerifiedByAdmin,
    @Query('is_verified_by_admin__isnull') bool? isVerifiedByAdminIsnull,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSheltersAdminSerializers>>
  apiV1ShelterWorkersPost({
    int? xCurrentShelter,
    required UserSheltersAdminSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSheltersAdminSerializers,
      () => UserSheltersAdminSerializers.fromJsonFactory,
    );

    return _apiV1ShelterWorkersPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/shelter/workers/', optionalBody: true)
  Future<chopper.Response<UserSheltersAdminSerializers>>
  _apiV1ShelterWorkersPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserSheltersAdminSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSheltersAdminSerializers>>
  apiV1ShelterWorkersIdGet({required int? id, int? xCurrentShelter}) {
    generatedMapping.putIfAbsent(
      UserSheltersAdminSerializers,
      () => UserSheltersAdminSerializers.fromJsonFactory,
    );

    return _apiV1ShelterWorkersIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/shelter/workers/{id}/')
  Future<chopper.Response<UserSheltersAdminSerializers>>
  _apiV1ShelterWorkersIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSheltersAdminSerializers>>
  apiV1ShelterWorkersIdPut({
    required int? id,
    int? xCurrentShelter,
    required UserSheltersAdminSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSheltersAdminSerializers,
      () => UserSheltersAdminSerializers.fromJsonFactory,
    );

    return _apiV1ShelterWorkersIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/shelter/workers/{id}/', optionalBody: true)
  Future<chopper.Response<UserSheltersAdminSerializers>>
  _apiV1ShelterWorkersIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserSheltersAdminSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSheltersAdminSerializers>>
  apiV1ShelterWorkersIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedUserSheltersAdminSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSheltersAdminSerializers,
      () => UserSheltersAdminSerializers.fromJsonFactory,
    );

    return _apiV1ShelterWorkersIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/shelter/workers/{id}/', optionalBody: true)
  Future<chopper.Response<UserSheltersAdminSerializers>>
  _apiV1ShelterWorkersIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedUserSheltersAdminSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1ShelterWorkersIdDelete({
    required int? id,
    int? xCurrentShelter,
  }) {
    return _apiV1ShelterWorkersIdDelete(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @DELETE(path: '/api/v1/shelter/workers/{id}/')
  Future<chopper.Response> _apiV1ShelterWorkersIdDelete({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Approve>> apiV1ShelterWorkersIdApprovePut({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Approve, () => Approve.fromJsonFactory);

    return _apiV1ShelterWorkersIdApprovePut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/shelter/workers/{id}/approve/', optionalBody: true)
  Future<chopper.Response<Approve>> _apiV1ShelterWorkersIdApprovePut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<Decline>> apiV1ShelterWorkersIdDeclinePut({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(Decline, () => Decline.fromJsonFactory);

    return _apiV1ShelterWorkersIdDeclinePut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id A unique integer value identifying this user shelter.
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/shelter/workers/{id}/decline/', optionalBody: true)
  Future<chopper.Response<Decline>> _apiV1ShelterWorkersIdDeclinePut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedShelterShortSerializersList>>
  apiV1SheltersGet({
    int? limit,
    int? offset,
    String? search,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedShelterShortSerializersList,
      () => PaginatedShelterShortSerializersList.fromJsonFactory,
    );

    return _apiV1SheltersGet(
      limit: limit,
      offset: offset,
      search: search,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param search A search term.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/shelters/')
  Future<chopper.Response<PaginatedShelterShortSerializersList>>
  _apiV1SheltersGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ShelterSerializers>> apiV1SheltersIdGet({
    required int? id,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      ShelterSerializers,
      () => ShelterSerializers.fromJsonFactory,
    );

    return _apiV1SheltersIdGet(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/shelters/{id}/')
  Future<chopper.Response<ShelterSerializers>> _apiV1SheltersIdGet({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ShelterSerializers>> apiV1SheltersIdPut({
    required int? id,
    int? xCurrentShelter,
    required ShelterSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      ShelterSerializers,
      () => ShelterSerializers.fromJsonFactory,
    );

    return _apiV1SheltersIdPut(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/shelters/{id}/', optionalBody: true)
  Future<chopper.Response<ShelterSerializers>> _apiV1SheltersIdPut({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required ShelterSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ShelterSerializers>> apiV1SheltersIdPatch({
    required int? id,
    int? xCurrentShelter,
    required PatchedShelterSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      ShelterSerializers,
      () => ShelterSerializers.fromJsonFactory,
    );

    return _apiV1SheltersIdPatch(
      id: id,
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param id
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/shelters/{id}/', optionalBody: true)
  Future<chopper.Response<ShelterSerializers>> _apiV1SheltersIdPatch({
    @Path('id') required int? id,
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedShelterSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSheltersWorkerSerializers>> apiV1SheltersAddPost({
    int? xCurrentShelter,
    required UserSheltersWorkerSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSheltersWorkerSerializers,
      () => UserSheltersWorkerSerializers.fromJsonFactory,
    );

    return _apiV1SheltersAddPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/shelters/add/', optionalBody: true)
  Future<chopper.Response<UserSheltersWorkerSerializers>>
  _apiV1SheltersAddPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserSheltersWorkerSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserShelterAdminSerializers>>
  apiV1UsersAdminRegisterPost({
    int? xCurrentShelter,
    required UserShelterAdminSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserShelterAdminSerializers,
      () => UserShelterAdminSerializers.fromJsonFactory,
    );

    return _apiV1UsersAdminRegisterPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/users/admin-register/', optionalBody: true)
  Future<chopper.Response<UserShelterAdminSerializers>>
  _apiV1UsersAdminRegisterPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserShelterAdminSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedUserShortSerializersList>>
  apiV1UsersAvailableWorkersGet({
    int? limit,
    int? offset,
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      PaginatedUserShortSerializersList,
      () => PaginatedUserShortSerializersList.fromJsonFactory,
    );

    return _apiV1UsersAvailableWorkersGet(
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/available-workers/')
  Future<chopper.Response<PaginatedUserShortSerializersList>>
  _apiV1UsersAvailableWorkersGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSerializers>> apiV1UsersMeGet({
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      UserSerializers,
      () => UserSerializers.fromJsonFactory,
    );

    return _apiV1UsersMeGet(xCurrentShelter: xCurrentShelter?.toString());
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/me/')
  Future<chopper.Response<UserSerializers>> _apiV1UsersMeGet({
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSerializers>> apiV1UsersMePut({
    int? xCurrentShelter,
    required UserSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSerializers,
      () => UserSerializers.fromJsonFactory,
    );

    return _apiV1UsersMePut(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/users/me/', optionalBody: true)
  Future<chopper.Response<UserSerializers>> _apiV1UsersMePut({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserSerializers>> apiV1UsersMePatch({
    int? xCurrentShelter,
    required PatchedUserSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSerializers,
      () => UserSerializers.fromJsonFactory,
    );

    return _apiV1UsersMePatch(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/users/me/', optionalBody: true)
  Future<chopper.Response<UserSerializers>> _apiV1UsersMePatch({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedUserSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserChangePasswordSerializers>>
  apiV1UsersMeChangePasswordPut({
    int? xCurrentShelter,
    required UserChangePasswordSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserChangePasswordSerializers,
      () => UserChangePasswordSerializers.fromJsonFactory,
    );

    return _apiV1UsersMeChangePasswordPut(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @PUT(path: '/api/v1/users/me/change_password/', optionalBody: true)
  Future<chopper.Response<UserChangePasswordSerializers>>
  _apiV1UsersMeChangePasswordPut({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserChangePasswordSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserChangePasswordSerializers>>
  apiV1UsersMeChangePasswordPatch({
    int? xCurrentShelter,
    required PatchedUserChangePasswordSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserChangePasswordSerializers,
      () => UserChangePasswordSerializers.fromJsonFactory,
    );

    return _apiV1UsersMeChangePasswordPatch(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @PATCH(path: '/api/v1/users/me/change_password/', optionalBody: true)
  Future<chopper.Response<UserChangePasswordSerializers>>
  _apiV1UsersMeChangePasswordPatch({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required PatchedUserChangePasswordSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<PaginatedShelterShortSerializersList>>
  apiV1UsersMeSheltersGet({int? limit, int? offset, int? xCurrentShelter}) {
    generatedMapping.putIfAbsent(
      PaginatedShelterShortSerializersList,
      () => PaginatedShelterShortSerializersList.fromJsonFactory,
    );

    return _apiV1UsersMeSheltersGet(
      limit: limit,
      offset: offset,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param limit Number of results to return per page.
  ///@param offset The initial index from which to return the results.
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/me/shelters/')
  Future<chopper.Response<PaginatedShelterShortSerializersList>>
  _apiV1UsersMeSheltersGet({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserCurrentShelterSerializers>>
  apiV1UsersMeSheltersCurrentGet({int? xCurrentShelter}) {
    generatedMapping.putIfAbsent(
      UserCurrentShelterSerializers,
      () => UserCurrentShelterSerializers.fromJsonFactory,
    );

    return _apiV1UsersMeSheltersCurrentGet(
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/me/shelters/current/')
  Future<chopper.Response<UserCurrentShelterSerializers>>
  _apiV1UsersMeSheltersCurrentGet({
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1UsersResetPasswordPost({
    int? xCurrentShelter,
    required Email? body,
  }) {
    return _apiV1UsersResetPasswordPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/users/reset-password/', optionalBody: true)
  Future<chopper.Response> _apiV1UsersResetPasswordPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required Email? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1UsersResetPasswordCompletePost({
    int? xCurrentShelter,
    required UserResetPasswordComplete? body,
  }) {
    return _apiV1UsersResetPasswordCompletePost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/users/reset-password/complete/', optionalBody: true)
  Future<chopper.Response> _apiV1UsersResetPasswordCompletePost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserResetPasswordComplete? body,
    @chopper.Tag()
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
  });

  ///
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1UsersResetPasswordConfirmUidb64TokenGet({
    required String? token,
    required String? uidb64,
    int? xCurrentShelter,
  }) {
    return _apiV1UsersResetPasswordConfirmUidb64TokenGet(
      token: token,
      uidb64: uidb64,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/reset-password/confirm/{uidb64}/{token}/')
  Future<chopper.Response> _apiV1UsersResetPasswordConfirmUidb64TokenGet({
    @Path('token') required String? token,
    @Path('uidb64') required String? uidb64,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param sidb64
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1UsersVerifyEmailUidb64Sidb64TokenGet({
    required String? sidb64,
    required String? token,
    required String? uidb64,
    int? xCurrentShelter,
  }) {
    return _apiV1UsersVerifyEmailUidb64Sidb64TokenGet(
      sidb64: sidb64,
      token: token,
      uidb64: uidb64,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param sidb64
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/verify-email/{uidb64}/{sidb64}/{token}/')
  Future<chopper.Response> _apiV1UsersVerifyEmailUidb64Sidb64TokenGet({
    @Path('sidb64') required String? sidb64,
    @Path('token') required String? token,
    @Path('uidb64') required String? uidb64,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param sidb64
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response> apiV1UsersVerifyWorkerUidb64Sidb64TokenGet({
    required String? sidb64,
    required String? token,
    required String? uidb64,
    int? xCurrentShelter,
  }) {
    return _apiV1UsersVerifyWorkerUidb64Sidb64TokenGet(
      sidb64: sidb64,
      token: token,
      uidb64: uidb64,
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param sidb64
  ///@param token
  ///@param uidb64
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/users/verify-worker/{uidb64}/{sidb64}/{token}/')
  Future<chopper.Response> _apiV1UsersVerifyWorkerUidb64Sidb64TokenGet({
    @Path('sidb64') required String? sidb64,
    @Path('token') required String? token,
    @Path('uidb64') required String? uidb64,
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<UserShelterWorkerSerializers>>
  apiV1UsersWorkerRegisterPost({
    int? xCurrentShelter,
    required UserShelterWorkerSerializers? body,
  }) {
    generatedMapping.putIfAbsent(
      UserShelterWorkerSerializers,
      () => UserShelterWorkerSerializers.fromJsonFactory,
    );

    return _apiV1UsersWorkerRegisterPost(
      xCurrentShelter: xCurrentShelter?.toString(),
      body: body,
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @POST(path: '/api/v1/users/worker-register/', optionalBody: true)
  Future<chopper.Response<UserShelterWorkerSerializers>>
  _apiV1UsersWorkerRegisterPost({
    @Header('x-current-shelter') String? xCurrentShelter,
    @Body() required UserShelterWorkerSerializers? body,
    @chopper.Tag()
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
  });

  ///
  ///@param x-current-shelter Set current shelter id
  Future<chopper.Response<ValuesForSelection>> apiV1ValuesForSelectionGet({
    int? xCurrentShelter,
  }) {
    generatedMapping.putIfAbsent(
      ValuesForSelection,
      () => ValuesForSelection.fromJsonFactory,
    );

    return _apiV1ValuesForSelectionGet(
      xCurrentShelter: xCurrentShelter?.toString(),
    );
  }

  ///
  ///@param x-current-shelter Set current shelter id
  @GET(path: '/api/v1/values-for-selection/')
  Future<chopper.Response<ValuesForSelection>> _apiV1ValuesForSelectionGet({
    @Header('x-current-shelter') String? xCurrentShelter,
    @chopper.Tag()
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
  });
}

@JsonSerializable(explicitToJson: true)
class Adopter {
  const Adopter({
    this.id,
    this.url,
    this.shelter,
    required this.firstName,
    this.lastName,
    this.email,
    required this.phoneNumber,
    this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Adopter.fromJson(Map<String, dynamic> json) =>
      _$AdopterFromJson(json);

  static const toJsonFactory = _$AdopterToJson;
  Map<String, dynamic> toJson() => _$AdopterToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
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
  static const fromJsonFactory = _$AdopterFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Adopter &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $AdopterExtension on Adopter {
  Adopter copyWith({
    int? id,
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
    DateTime? updatedAt,
  }) {
    return Adopter(
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Adopter copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<String?>? shelter,
    Wrapped<String>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? email,
    Wrapped<String>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return Adopter(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Adoption {
  const Adoption({this.startDate, this.endDate, this.adopter});

  factory Adoption.fromJson(Map<String, dynamic> json) =>
      _$AdoptionFromJson(json);

  static const toJsonFactory = _$AdoptionToJson;
  Map<String, dynamic> toJson() => _$AdoptionToJson(this);

  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime? startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime? endDate;
  @JsonKey(name: 'adopter')
  final int? adopter;
  static const fromJsonFactory = _$AdoptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Adoption &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.adopter, adopter) ||
                const DeepCollectionEquality().equals(other.adopter, adopter)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(adopter) ^
      runtimeType.hashCode;
}

extension $AdoptionExtension on Adoption {
  Adoption copyWith({DateTime? startDate, DateTime? endDate, int? adopter}) {
    return Adoption(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      adopter: adopter ?? this.adopter,
    );
  }

  Adoption copyWithWrapped({
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<int?>? adopter,
  }) {
    return Adoption(
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      adopter: (adopter != null ? adopter.value : this.adopter),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnalysisPrescription {
  const AnalysisPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory AnalysisPrescription.fromJson(Map<String, dynamic> json) =>
      _$AnalysisPrescriptionFromJson(json);

  static const toJsonFactory = _$AnalysisPrescriptionToJson;
  Map<String, dynamic> toJson() => _$AnalysisPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: analysisPrescriptionMyTypeEnumToJson,
    fromJson: analysisPrescriptionMyTypeEnumFromJson,
  )
  final enums.AnalysisPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$AnalysisPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnalysisPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $AnalysisPrescriptionExtension on AnalysisPrescription {
  AnalysisPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.AnalysisPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return AnalysisPrescription(
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
      files: files ?? this.files,
    );
  }

  AnalysisPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.AnalysisPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return AnalysisPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalAttribute {
  const AnimalAttribute({this.id, required this.name, this.isRequired});

  factory AnimalAttribute.fromJson(Map<String, dynamic> json) =>
      _$AnimalAttributeFromJson(json);

  static const toJsonFactory = _$AnimalAttributeToJson;
  Map<String, dynamic> toJson() => _$AnimalAttributeToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'is_required')
  final bool? isRequired;
  static const fromJsonFactory = _$AnimalAttributeFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalAttribute &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.isRequired, isRequired) ||
                const DeepCollectionEquality().equals(
                  other.isRequired,
                  isRequired,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
      id: id ?? this.id,
      name: name ?? this.name,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  AnimalAttribute copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? name,
    Wrapped<bool?>? isRequired,
  }) {
    return AnimalAttribute(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      isRequired: (isRequired != null ? isRequired.value : this.isRequired),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalAttributeValue {
  const AnimalAttributeValue({
    required this.attrId,
    required this.name,
    required this.value,
    this.isRequired,
  });

  factory AnimalAttributeValue.fromJson(Map<String, dynamic> json) =>
      _$AnimalAttributeValueFromJson(json);

  static const toJsonFactory = _$AnimalAttributeValueToJson;
  Map<String, dynamic> toJson() => _$AnimalAttributeValueToJson(this);

  @JsonKey(name: 'attr_id')
  final int attrId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'value')
  final String value;
  @JsonKey(name: 'is_required')
  final bool? isRequired;
  static const fromJsonFactory = _$AnimalAttributeValueFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalAttributeValue &&
            (identical(other.attrId, attrId) ||
                const DeepCollectionEquality().equals(other.attrId, attrId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.isRequired, isRequired) ||
                const DeepCollectionEquality().equals(
                  other.isRequired,
                  isRequired,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(attrId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(isRequired) ^
      runtimeType.hashCode;
}

extension $AnimalAttributeValueExtension on AnimalAttributeValue {
  AnimalAttributeValue copyWith({
    int? attrId,
    String? name,
    String? value,
    bool? isRequired,
  }) {
    return AnimalAttributeValue(
      attrId: attrId ?? this.attrId,
      name: name ?? this.name,
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  AnimalAttributeValue copyWithWrapped({
    Wrapped<int>? attrId,
    Wrapped<String>? name,
    Wrapped<String>? value,
    Wrapped<bool?>? isRequired,
  }) {
    return AnimalAttributeValue(
      attrId: (attrId != null ? attrId.value : this.attrId),
      name: (name != null ? name.value : this.name),
      value: (value != null ? value.value : this.value),
      isRequired: (isRequired != null ? isRequired.value : this.isRequired),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalHistorySnapshot {
  const AnimalHistorySnapshot({
    required this.animal,
    this.createdAt,
    this.status,
    this.height,
    this.weight,
    required this.shelterName,
    required this.editor,
  });

  factory AnimalHistorySnapshot.fromJson(Map<String, dynamic> json) =>
      _$AnimalHistorySnapshotFromJson(json);

  static const toJsonFactory = _$AnimalHistorySnapshotToJson;
  Map<String, dynamic> toJson() => _$AnimalHistorySnapshotToJson(this);

  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(
    name: 'status',
    toJson: status69fEnumNullableToJson,
    fromJson: status69fEnumNullableFromJson,
  )
  final enums.Status69fEnum? status;
  @JsonKey(name: 'height')
  final String? height;
  @JsonKey(name: 'weight')
  final String? weight;
  @JsonKey(name: 'shelter_name')
  final String shelterName;
  @JsonKey(name: 'editor')
  final String editor;
  static const fromJsonFactory = _$AnimalHistorySnapshotFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalHistorySnapshot &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.shelterName, shelterName) ||
                const DeepCollectionEquality().equals(
                  other.shelterName,
                  shelterName,
                )) &&
            (identical(other.editor, editor) ||
                const DeepCollectionEquality().equals(other.editor, editor)));
  }

  @override
  String toString() => jsonEncode(this);

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
  AnimalHistorySnapshot copyWith({
    int? animal,
    DateTime? createdAt,
    enums.Status69fEnum? status,
    String? height,
    String? weight,
    String? shelterName,
    String? editor,
  }) {
    return AnimalHistorySnapshot(
      animal: animal ?? this.animal,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      shelterName: shelterName ?? this.shelterName,
      editor: editor ?? this.editor,
    );
  }

  AnimalHistorySnapshot copyWithWrapped({
    Wrapped<int>? animal,
    Wrapped<DateTime?>? createdAt,
    Wrapped<enums.Status69fEnum?>? status,
    Wrapped<String?>? height,
    Wrapped<String?>? weight,
    Wrapped<String>? shelterName,
    Wrapped<String>? editor,
  }) {
    return AnimalHistorySnapshot(
      animal: (animal != null ? animal.value : this.animal),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      status: (status != null ? status.value : this.status),
      height: (height != null ? height.value : this.height),
      weight: (weight != null ? weight.value : this.weight),
      shelterName: (shelterName != null ? shelterName.value : this.shelterName),
      editor: (editor != null ? editor.value : this.editor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalImageRead {
  const AnimalImageRead({
    this.id,
    this.isPrimary,
    this.filename,
    required this.image,
  });

  factory AnimalImageRead.fromJson(Map<String, dynamic> json) =>
      _$AnimalImageReadFromJson(json);

  static const toJsonFactory = _$AnimalImageReadToJson;
  Map<String, dynamic> toJson() => _$AnimalImageReadToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'image')
  final ImageThumbnails image;
  static const fromJsonFactory = _$AnimalImageReadFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalImageRead &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isPrimary, isPrimary) ||
                const DeepCollectionEquality().equals(
                  other.isPrimary,
                  isPrimary,
                )) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(
                  other.filename,
                  filename,
                )) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isPrimary) ^
      const DeepCollectionEquality().hash(filename) ^
      const DeepCollectionEquality().hash(image) ^
      runtimeType.hashCode;
}

extension $AnimalImageReadExtension on AnimalImageRead {
  AnimalImageRead copyWith({
    int? id,
    bool? isPrimary,
    String? filename,
    ImageThumbnails? image,
  }) {
    return AnimalImageRead(
      id: id ?? this.id,
      isPrimary: isPrimary ?? this.isPrimary,
      filename: filename ?? this.filename,
      image: image ?? this.image,
    );
  }

  AnimalImageRead copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<bool?>? isPrimary,
    Wrapped<String?>? filename,
    Wrapped<ImageThumbnails>? image,
  }) {
    return AnimalImageRead(
      id: (id != null ? id.value : this.id),
      isPrimary: (isPrimary != null ? isPrimary.value : this.isPrimary),
      filename: (filename != null ? filename.value : this.filename),
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalImageWrite {
  const AnimalImageWrite({
    this.isPrimary,
    required this.name,
    required this.image,
  });

  factory AnimalImageWrite.fromJson(Map<String, dynamic> json) =>
      _$AnimalImageWriteFromJson(json);

  static const toJsonFactory = _$AnimalImageWriteToJson;
  Map<String, dynamic> toJson() => _$AnimalImageWriteToJson(this);

  @JsonKey(name: 'is_primary')
  final bool? isPrimary;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'image')
  final String image;
  static const fromJsonFactory = _$AnimalImageWriteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalImageWrite &&
            (identical(other.isPrimary, isPrimary) ||
                const DeepCollectionEquality().equals(
                  other.isPrimary,
                  isPrimary,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

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
      image: image ?? this.image,
    );
  }

  AnimalImageWrite copyWithWrapped({
    Wrapped<bool?>? isPrimary,
    Wrapped<String>? name,
    Wrapped<String>? image,
  }) {
    return AnimalImageWrite(
      isPrimary: (isPrimary != null ? isPrimary.value : this.isPrimary),
      name: (name != null ? name.value : this.name),
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalNote {
  const AnimalNote({
    this.id,
    this.url,
    required this.animal,
    required this.content,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.isUserCanEditOrDelete,
  });

  factory AnimalNote.fromJson(Map<String, dynamic> json) =>
      _$AnimalNoteFromJson(json);

  static const toJsonFactory = _$AnimalNoteToJson;
  Map<String, dynamic> toJson() => _$AnimalNoteToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(name: 'content')
  final String content;
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalNote &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(
                  other.content,
                  content,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.isUserCanEditOrDelete, isUserCanEditOrDelete) ||
                const DeepCollectionEquality().equals(
                  other.isUserCanEditOrDelete,
                  isUserCanEditOrDelete,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  AnimalNote copyWith({
    int? id,
    String? url,
    int? animal,
    String? content,
    List<AnimalNoteFile>? files,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    bool? isUserCanEditOrDelete,
  }) {
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
      isUserCanEditOrDelete:
          isUserCanEditOrDelete ?? this.isUserCanEditOrDelete,
    );
  }

  AnimalNote copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<String>? content,
    Wrapped<List<AnimalNoteFile>?>? files,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<bool?>? isUserCanEditOrDelete,
  }) {
    return AnimalNote(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      content: (content != null ? content.value : this.content),
      files: (files != null ? files.value : this.files),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      isUserCanEditOrDelete: (isUserCanEditOrDelete != null
          ? isUserCanEditOrDelete.value
          : this.isUserCanEditOrDelete),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalNoteFile {
  const AnimalNoteFile({
    this.id,
    required this.file,
    this.name,
    this.filename,
    this.createdAt,
  });

  factory AnimalNoteFile.fromJson(Map<String, dynamic> json) =>
      _$AnimalNoteFileFromJson(json);

  static const toJsonFactory = _$AnimalNoteFileToJson;
  Map<String, dynamic> toJson() => _$AnimalNoteFileToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'file')
  final String file;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$AnimalNoteFileFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalNoteFile &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(
                  other.filename,
                  filename,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  AnimalNoteFile copyWith({
    int? id,
    String? file,
    String? name,
    String? filename,
    DateTime? createdAt,
  }) {
    return AnimalNoteFile(
      id: id ?? this.id,
      file: file ?? this.file,
      name: name ?? this.name,
      filename: filename ?? this.filename,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  AnimalNoteFile copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? file,
    Wrapped<String?>? name,
    Wrapped<String?>? filename,
    Wrapped<DateTime?>? createdAt,
  }) {
    return AnimalNoteFile(
      id: (id != null ? id.value : this.id),
      file: (file != null ? file.value : this.file),
      name: (name != null ? name.value : this.name),
      filename: (filename != null ? filename.value : this.filename),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalRead {
  const AnimalRead({
    this.id,
    this.uuid,
    this.url,
    this.name,
    required this.images,
    this.spec,
    this.status,
    required this.dateJoined,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    required this.placeOfCatch,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.hasDocuments,
    required this.shelter,
    this.curator,
    this.applicant,
    required this.animalAttributes,
    this.deletedAt,
    this.adoption,
    this.release,
    this.overstay,
    this.canBeShared,
  });

  factory AnimalRead.fromJson(Map<String, dynamic> json) =>
      _$AnimalReadFromJson(json);

  static const toJsonFactory = _$AnimalReadToJson;
  Map<String, dynamic> toJson() => _$AnimalReadToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'uuid')
  final String? uuid;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'images', defaultValue: <AnimalImageRead>[])
  final List<AnimalImageRead> images;
  @JsonKey(name: 'spec')
  final Species? spec;
  @JsonKey(
    name: 'status',
    toJson: status69fEnumNullableToJson,
    fromJson: status69fEnumNullableFromJson,
  )
  final enums.Status69fEnum? status;
  @JsonKey(name: 'date_joined', toJson: _dateToJson)
  final DateTime dateJoined;
  @JsonKey(name: 'birth_date', toJson: _dateToJson)
  final DateTime? birthDate;
  @JsonKey(name: 'death_date', toJson: _dateToJson)
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String placeOfCatch;
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
  final int shelter;
  @JsonKey(name: 'curator')
  final Curator? curator;
  @JsonKey(name: 'applicant')
  final Applicant? applicant;
  @JsonKey(name: 'animal_attributes', defaultValue: <AnimalAttributeValue>[])
  final List<AnimalAttributeValue> animalAttributes;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @JsonKey(name: 'adoption')
  final String? adoption;
  @JsonKey(name: 'release')
  final String? release;
  @JsonKey(name: 'overstay')
  final String? overstay;
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;
  static const fromJsonFactory = _$AnimalReadFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalRead &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uuid, uuid) ||
                const DeepCollectionEquality().equals(other.uuid, uuid)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.spec, spec) ||
                const DeepCollectionEquality().equals(other.spec, spec)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality().equals(
                  other.birthDate,
                  birthDate,
                )) &&
            (identical(other.deathDate, deathDate) ||
                const DeepCollectionEquality().equals(
                  other.deathDate,
                  deathDate,
                )) &&
            (identical(other.deathReason, deathReason) ||
                const DeepCollectionEquality().equals(
                  other.deathReason,
                  deathReason,
                )) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(
                  other.defaultImageId,
                  defaultImageId,
                )) &&
            (identical(other.placeOfCatch, placeOfCatch) ||
                const DeepCollectionEquality().equals(
                  other.placeOfCatch,
                  placeOfCatch,
                )) &&
            (identical(other.placeOfRelease, placeOfRelease) ||
                const DeepCollectionEquality().equals(
                  other.placeOfRelease,
                  placeOfRelease,
                )) &&
            (identical(other.dateOfChipping, dateOfChipping) ||
                const DeepCollectionEquality().equals(
                  other.dateOfChipping,
                  dateOfChipping,
                )) &&
            (identical(other.chippingCode, chippingCode) ||
                const DeepCollectionEquality().equals(
                  other.chippingCode,
                  chippingCode,
                )) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.hasDocuments, hasDocuments) ||
                const DeepCollectionEquality().equals(
                  other.hasDocuments,
                  hasDocuments,
                )) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.curator, curator) ||
                const DeepCollectionEquality().equals(
                  other.curator,
                  curator,
                )) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality().equals(
                  other.applicant,
                  applicant,
                )) &&
            (identical(other.animalAttributes, animalAttributes) ||
                const DeepCollectionEquality().equals(
                  other.animalAttributes,
                  animalAttributes,
                )) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality().equals(
                  other.deletedAt,
                  deletedAt,
                )) &&
            (identical(other.adoption, adoption) ||
                const DeepCollectionEquality().equals(
                  other.adoption,
                  adoption,
                )) &&
            (identical(other.release, release) ||
                const DeepCollectionEquality().equals(
                  other.release,
                  release,
                )) &&
            (identical(other.overstay, overstay) ||
                const DeepCollectionEquality().equals(
                  other.overstay,
                  overstay,
                )) &&
            (identical(other.canBeShared, canBeShared) ||
                const DeepCollectionEquality().equals(
                  other.canBeShared,
                  canBeShared,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uuid) ^
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
      const DeepCollectionEquality().hash(adoption) ^
      const DeepCollectionEquality().hash(release) ^
      const DeepCollectionEquality().hash(overstay) ^
      const DeepCollectionEquality().hash(canBeShared) ^
      runtimeType.hashCode;
}

extension $AnimalReadExtension on AnimalRead {
  AnimalRead copyWith({
    int? id,
    String? uuid,
    String? url,
    String? name,
    List<AnimalImageRead>? images,
    Species? spec,
    enums.Status69fEnum? status,
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
    Curator? curator,
    Applicant? applicant,
    List<AnimalAttributeValue>? animalAttributes,
    DateTime? deletedAt,
    String? adoption,
    String? release,
    String? overstay,
    bool? canBeShared,
  }) {
    return AnimalRead(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
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
      deletedAt: deletedAt ?? this.deletedAt,
      adoption: adoption ?? this.adoption,
      release: release ?? this.release,
      overstay: overstay ?? this.overstay,
      canBeShared: canBeShared ?? this.canBeShared,
    );
  }

  AnimalRead copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? uuid,
    Wrapped<String?>? url,
    Wrapped<String?>? name,
    Wrapped<List<AnimalImageRead>>? images,
    Wrapped<Species?>? spec,
    Wrapped<enums.Status69fEnum?>? status,
    Wrapped<DateTime>? dateJoined,
    Wrapped<DateTime?>? birthDate,
    Wrapped<DateTime?>? deathDate,
    Wrapped<String?>? deathReason,
    Wrapped<int?>? defaultImageId,
    Wrapped<String>? placeOfCatch,
    Wrapped<String?>? placeOfRelease,
    Wrapped<DateTime?>? dateOfChipping,
    Wrapped<String?>? chippingCode,
    Wrapped<String?>? height,
    Wrapped<String?>? weight,
    Wrapped<bool?>? hasDocuments,
    Wrapped<int>? shelter,
    Wrapped<Curator?>? curator,
    Wrapped<Applicant?>? applicant,
    Wrapped<List<AnimalAttributeValue>>? animalAttributes,
    Wrapped<DateTime?>? deletedAt,
    Wrapped<String?>? adoption,
    Wrapped<String?>? release,
    Wrapped<String?>? overstay,
    Wrapped<bool?>? canBeShared,
  }) {
    return AnimalRead(
      id: (id != null ? id.value : this.id),
      uuid: (uuid != null ? uuid.value : this.uuid),
      url: (url != null ? url.value : this.url),
      name: (name != null ? name.value : this.name),
      images: (images != null ? images.value : this.images),
      spec: (spec != null ? spec.value : this.spec),
      status: (status != null ? status.value : this.status),
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      birthDate: (birthDate != null ? birthDate.value : this.birthDate),
      deathDate: (deathDate != null ? deathDate.value : this.deathDate),
      deathReason: (deathReason != null ? deathReason.value : this.deathReason),
      defaultImageId: (defaultImageId != null
          ? defaultImageId.value
          : this.defaultImageId),
      placeOfCatch: (placeOfCatch != null
          ? placeOfCatch.value
          : this.placeOfCatch),
      placeOfRelease: (placeOfRelease != null
          ? placeOfRelease.value
          : this.placeOfRelease),
      dateOfChipping: (dateOfChipping != null
          ? dateOfChipping.value
          : this.dateOfChipping),
      chippingCode: (chippingCode != null
          ? chippingCode.value
          : this.chippingCode),
      height: (height != null ? height.value : this.height),
      weight: (weight != null ? weight.value : this.weight),
      hasDocuments: (hasDocuments != null
          ? hasDocuments.value
          : this.hasDocuments),
      shelter: (shelter != null ? shelter.value : this.shelter),
      curator: (curator != null ? curator.value : this.curator),
      applicant: (applicant != null ? applicant.value : this.applicant),
      animalAttributes: (animalAttributes != null
          ? animalAttributes.value
          : this.animalAttributes),
      deletedAt: (deletedAt != null ? deletedAt.value : this.deletedAt),
      adoption: (adoption != null ? adoption.value : this.adoption),
      release: (release != null ? release.value : this.release),
      overstay: (overstay != null ? overstay.value : this.overstay),
      canBeShared: (canBeShared != null ? canBeShared.value : this.canBeShared),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalShort {
  const AnimalShort({
    this.id,
    this.uuid,
    this.name,
    this.specName,
    this.specParentName,
    this.avatar,
    this.defaultImageId,
  });

  factory AnimalShort.fromJson(Map<String, dynamic> json) =>
      _$AnimalShortFromJson(json);

  static const toJsonFactory = _$AnimalShortToJson;
  Map<String, dynamic> toJson() => _$AnimalShortToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'uuid')
  final String? uuid;
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalShort &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uuid, uuid) ||
                const DeepCollectionEquality().equals(other.uuid, uuid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.specName, specName) ||
                const DeepCollectionEquality().equals(
                  other.specName,
                  specName,
                )) &&
            (identical(other.specParentName, specParentName) ||
                const DeepCollectionEquality().equals(
                  other.specParentName,
                  specParentName,
                )) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(
                  other.defaultImageId,
                  defaultImageId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uuid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(specName) ^
      const DeepCollectionEquality().hash(specParentName) ^
      const DeepCollectionEquality().hash(avatar) ^
      const DeepCollectionEquality().hash(defaultImageId) ^
      runtimeType.hashCode;
}

extension $AnimalShortExtension on AnimalShort {
  AnimalShort copyWith({
    int? id,
    String? uuid,
    String? name,
    String? specName,
    String? specParentName,
    String? avatar,
    int? defaultImageId,
  }) {
    return AnimalShort(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      specName: specName ?? this.specName,
      specParentName: specParentName ?? this.specParentName,
      avatar: avatar ?? this.avatar,
      defaultImageId: defaultImageId ?? this.defaultImageId,
    );
  }

  AnimalShort copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? uuid,
    Wrapped<String?>? name,
    Wrapped<String?>? specName,
    Wrapped<String?>? specParentName,
    Wrapped<String?>? avatar,
    Wrapped<int?>? defaultImageId,
  }) {
    return AnimalShort(
      id: (id != null ? id.value : this.id),
      uuid: (uuid != null ? uuid.value : this.uuid),
      name: (name != null ? name.value : this.name),
      specName: (specName != null ? specName.value : this.specName),
      specParentName: (specParentName != null
          ? specParentName.value
          : this.specParentName),
      avatar: (avatar != null ? avatar.value : this.avatar),
      defaultImageId: (defaultImageId != null
          ? defaultImageId.value
          : this.defaultImageId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalSitter {
  const AnimalSitter({
    this.id,
    this.url,
    this.shelter,
    required this.firstName,
    this.lastName,
    this.email,
    required this.phoneNumber,
    this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AnimalSitter.fromJson(Map<String, dynamic> json) =>
      _$AnimalSitterFromJson(json);

  static const toJsonFactory = _$AnimalSitterToJson;
  Map<String, dynamic> toJson() => _$AnimalSitterToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
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
  static const fromJsonFactory = _$AnimalSitterFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalSitter &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $AnimalSitterExtension on AnimalSitter {
  AnimalSitter copyWith({
    int? id,
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
    DateTime? updatedAt,
  }) {
    return AnimalSitter(
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  AnimalSitter copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<String?>? shelter,
    Wrapped<String>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? email,
    Wrapped<String>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return AnimalSitter(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalStatsResponse {
  const AnimalStatsResponse({
    this.breeds,
    this.species,
    this.dateJoined,
    this.statusTransitions,
  });

  factory AnimalStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnimalStatsResponseFromJson(json);

  static const toJsonFactory = _$AnimalStatsResponseToJson;
  Map<String, dynamic> toJson() => _$AnimalStatsResponseToJson(this);

  @JsonKey(name: 'breeds', defaultValue: <BreedsSpeciesStatsItem>[])
  final List<BreedsSpeciesStatsItem>? breeds;
  @JsonKey(name: 'species', defaultValue: <BreedsSpeciesStatsItem>[])
  final List<BreedsSpeciesStatsItem>? species;
  @JsonKey(name: 'date_joined', defaultValue: <DateJoinedStatsItem>[])
  final List<DateJoinedStatsItem>? dateJoined;
  @JsonKey(name: 'status_transitions', defaultValue: <StatusTransitionsItem>[])
  final List<StatusTransitionsItem>? statusTransitions;
  static const fromJsonFactory = _$AnimalStatsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalStatsResponse &&
            (identical(other.breeds, breeds) ||
                const DeepCollectionEquality().equals(other.breeds, breeds)) &&
            (identical(other.species, species) ||
                const DeepCollectionEquality().equals(
                  other.species,
                  species,
                )) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.statusTransitions, statusTransitions) ||
                const DeepCollectionEquality().equals(
                  other.statusTransitions,
                  statusTransitions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(breeds) ^
      const DeepCollectionEquality().hash(species) ^
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(statusTransitions) ^
      runtimeType.hashCode;
}

extension $AnimalStatsResponseExtension on AnimalStatsResponse {
  AnimalStatsResponse copyWith({
    List<BreedsSpeciesStatsItem>? breeds,
    List<BreedsSpeciesStatsItem>? species,
    List<DateJoinedStatsItem>? dateJoined,
    List<StatusTransitionsItem>? statusTransitions,
  }) {
    return AnimalStatsResponse(
      breeds: breeds ?? this.breeds,
      species: species ?? this.species,
      dateJoined: dateJoined ?? this.dateJoined,
      statusTransitions: statusTransitions ?? this.statusTransitions,
    );
  }

  AnimalStatsResponse copyWithWrapped({
    Wrapped<List<BreedsSpeciesStatsItem>?>? breeds,
    Wrapped<List<BreedsSpeciesStatsItem>?>? species,
    Wrapped<List<DateJoinedStatsItem>?>? dateJoined,
    Wrapped<List<StatusTransitionsItem>?>? statusTransitions,
  }) {
    return AnimalStatsResponse(
      breeds: (breeds != null ? breeds.value : this.breeds),
      species: (species != null ? species.value : this.species),
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      statusTransitions: (statusTransitions != null
          ? statusTransitions.value
          : this.statusTransitions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AnimalWrite {
  const AnimalWrite({
    this.name,
    this.images,
    this.validImages,
    this.specId,
    this.status,
    required this.dateJoined,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    required this.placeOfCatch,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    required this.shelter,
    this.curatorId,
    this.applicantId,
    required this.animalAttributes,
    this.canBeShared,
  });

  factory AnimalWrite.fromJson(Map<String, dynamic> json) =>
      _$AnimalWriteFromJson(json);

  static const toJsonFactory = _$AnimalWriteToJson;
  Map<String, dynamic> toJson() => _$AnimalWriteToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'images', defaultValue: <AnimalImageWrite>[])
  final List<AnimalImageWrite>? images;
  @JsonKey(name: 'valid_images', defaultValue: <int>[])
  final List<int>? validImages;
  @JsonKey(name: 'spec_id')
  final int? specId;
  @JsonKey(
    name: 'status',
    toJson: status69fEnumNullableToJson,
    fromJson: status69fEnumNullableFromJson,
  )
  final enums.Status69fEnum? status;
  @JsonKey(name: 'date_joined', toJson: _dateToJson)
  final DateTime dateJoined;
  @JsonKey(name: 'birth_date', toJson: _dateToJson)
  final DateTime? birthDate;
  @JsonKey(name: 'death_date', toJson: _dateToJson)
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String placeOfCatch;
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
  final int shelter;
  @JsonKey(name: 'curator_id')
  final int? curatorId;
  @JsonKey(name: 'applicant_id')
  final int? applicantId;
  @JsonKey(name: 'animal_attributes', defaultValue: <AnimalAttributeValue>[])
  final List<AnimalAttributeValue> animalAttributes;
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;
  static const fromJsonFactory = _$AnimalWriteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnimalWrite &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.validImages, validImages) ||
                const DeepCollectionEquality().equals(
                  other.validImages,
                  validImages,
                )) &&
            (identical(other.specId, specId) ||
                const DeepCollectionEquality().equals(other.specId, specId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality().equals(
                  other.birthDate,
                  birthDate,
                )) &&
            (identical(other.deathDate, deathDate) ||
                const DeepCollectionEquality().equals(
                  other.deathDate,
                  deathDate,
                )) &&
            (identical(other.deathReason, deathReason) ||
                const DeepCollectionEquality().equals(
                  other.deathReason,
                  deathReason,
                )) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(
                  other.defaultImageId,
                  defaultImageId,
                )) &&
            (identical(other.placeOfCatch, placeOfCatch) ||
                const DeepCollectionEquality().equals(
                  other.placeOfCatch,
                  placeOfCatch,
                )) &&
            (identical(other.placeOfRelease, placeOfRelease) ||
                const DeepCollectionEquality().equals(
                  other.placeOfRelease,
                  placeOfRelease,
                )) &&
            (identical(other.dateOfChipping, dateOfChipping) ||
                const DeepCollectionEquality().equals(
                  other.dateOfChipping,
                  dateOfChipping,
                )) &&
            (identical(other.chippingCode, chippingCode) ||
                const DeepCollectionEquality().equals(
                  other.chippingCode,
                  chippingCode,
                )) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.curatorId, curatorId) ||
                const DeepCollectionEquality().equals(
                  other.curatorId,
                  curatorId,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )) &&
            (identical(other.animalAttributes, animalAttributes) ||
                const DeepCollectionEquality().equals(
                  other.animalAttributes,
                  animalAttributes,
                )) &&
            (identical(other.canBeShared, canBeShared) ||
                const DeepCollectionEquality().equals(
                  other.canBeShared,
                  canBeShared,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
      const DeepCollectionEquality().hash(canBeShared) ^
      runtimeType.hashCode;
}

extension $AnimalWriteExtension on AnimalWrite {
  AnimalWrite copyWith({
    String? name,
    List<AnimalImageWrite>? images,
    List<int>? validImages,
    int? specId,
    enums.Status69fEnum? status,
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
    List<AnimalAttributeValue>? animalAttributes,
    bool? canBeShared,
  }) {
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
      animalAttributes: animalAttributes ?? this.animalAttributes,
      canBeShared: canBeShared ?? this.canBeShared,
    );
  }

  AnimalWrite copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<List<AnimalImageWrite>?>? images,
    Wrapped<List<int>?>? validImages,
    Wrapped<int?>? specId,
    Wrapped<enums.Status69fEnum?>? status,
    Wrapped<DateTime>? dateJoined,
    Wrapped<DateTime?>? birthDate,
    Wrapped<DateTime?>? deathDate,
    Wrapped<String?>? deathReason,
    Wrapped<int?>? defaultImageId,
    Wrapped<String>? placeOfCatch,
    Wrapped<String?>? placeOfRelease,
    Wrapped<DateTime?>? dateOfChipping,
    Wrapped<String?>? chippingCode,
    Wrapped<String?>? height,
    Wrapped<String?>? weight,
    Wrapped<int>? shelter,
    Wrapped<int?>? curatorId,
    Wrapped<int?>? applicantId,
    Wrapped<List<AnimalAttributeValue>>? animalAttributes,
    Wrapped<bool?>? canBeShared,
  }) {
    return AnimalWrite(
      name: (name != null ? name.value : this.name),
      images: (images != null ? images.value : this.images),
      validImages: (validImages != null ? validImages.value : this.validImages),
      specId: (specId != null ? specId.value : this.specId),
      status: (status != null ? status.value : this.status),
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      birthDate: (birthDate != null ? birthDate.value : this.birthDate),
      deathDate: (deathDate != null ? deathDate.value : this.deathDate),
      deathReason: (deathReason != null ? deathReason.value : this.deathReason),
      defaultImageId: (defaultImageId != null
          ? defaultImageId.value
          : this.defaultImageId),
      placeOfCatch: (placeOfCatch != null
          ? placeOfCatch.value
          : this.placeOfCatch),
      placeOfRelease: (placeOfRelease != null
          ? placeOfRelease.value
          : this.placeOfRelease),
      dateOfChipping: (dateOfChipping != null
          ? dateOfChipping.value
          : this.dateOfChipping),
      chippingCode: (chippingCode != null
          ? chippingCode.value
          : this.chippingCode),
      height: (height != null ? height.value : this.height),
      weight: (weight != null ? weight.value : this.weight),
      shelter: (shelter != null ? shelter.value : this.shelter),
      curatorId: (curatorId != null ? curatorId.value : this.curatorId),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
      animalAttributes: (animalAttributes != null
          ? animalAttributes.value
          : this.animalAttributes),
      canBeShared: (canBeShared != null ? canBeShared.value : this.canBeShared),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Applicant {
  const Applicant({
    this.id,
    this.url,
    this.shelter,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNumber,
    this.contactDetails,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.animalId,
    this.applicantFiles,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) =>
      _$ApplicantFromJson(json);

  static const toJsonFactory = _$ApplicantToJson;
  Map<String, dynamic> toJson() => _$ApplicantToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Applicant &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.contactDetails, contactDetails) ||
                const DeepCollectionEquality().equals(
                  other.contactDetails,
                  contactDetails,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.animalId, animalId) ||
                const DeepCollectionEquality().equals(
                  other.animalId,
                  animalId,
                )) &&
            (identical(other.applicantFiles, applicantFiles) ||
                const DeepCollectionEquality().equals(
                  other.applicantFiles,
                  applicantFiles,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  Applicant copyWith({
    int? id,
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
    List<ApplicantFile>? applicantFiles,
  }) {
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
      applicantFiles: applicantFiles ?? this.applicantFiles,
    );
  }

  Applicant copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? shelter,
    Wrapped<String>? firstName,
    Wrapped<String>? lastName,
    Wrapped<String?>? email,
    Wrapped<String>? phoneNumber,
    Wrapped<String?>? contactDetails,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<int?>? animalId,
    Wrapped<List<ApplicantFile>?>? applicantFiles,
  }) {
    return Applicant(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      contactDetails: (contactDetails != null
          ? contactDetails.value
          : this.contactDetails),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      animalId: (animalId != null ? animalId.value : this.animalId),
      applicantFiles: (applicantFiles != null
          ? applicantFiles.value
          : this.applicantFiles),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ApplicantFile {
  const ApplicantFile({
    this.id,
    required this.file,
    this.name,
    this.filename,
    this.createdAt,
  });

  factory ApplicantFile.fromJson(Map<String, dynamic> json) =>
      _$ApplicantFileFromJson(json);

  static const toJsonFactory = _$ApplicantFileToJson;
  Map<String, dynamic> toJson() => _$ApplicantFileToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'file')
  final String file;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$ApplicantFileFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApplicantFile &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(
                  other.filename,
                  filename,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  ApplicantFile copyWith({
    int? id,
    String? file,
    String? name,
    String? filename,
    DateTime? createdAt,
  }) {
    return ApplicantFile(
      id: id ?? this.id,
      file: file ?? this.file,
      name: name ?? this.name,
      filename: filename ?? this.filename,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  ApplicantFile copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? file,
    Wrapped<String?>? name,
    Wrapped<String?>? filename,
    Wrapped<DateTime?>? createdAt,
  }) {
    return ApplicantFile(
      id: (id != null ? id.value : this.id),
      file: (file != null ? file.value : this.file),
      name: (name != null ? name.value : this.name),
      filename: (filename != null ? filename.value : this.filename),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppointmentPrescription {
  const AppointmentPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory AppointmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$AppointmentPrescriptionFromJson(json);

  static const toJsonFactory = _$AppointmentPrescriptionToJson;
  Map<String, dynamic> toJson() => _$AppointmentPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: appointmentPrescriptionMyTypeEnumToJson,
    fromJson: appointmentPrescriptionMyTypeEnumFromJson,
  )
  final enums.AppointmentPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$AppointmentPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppointmentPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $AppointmentPrescriptionExtension on AppointmentPrescription {
  AppointmentPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.AppointmentPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return AppointmentPrescription(
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
      files: files ?? this.files,
    );
  }

  AppointmentPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.AppointmentPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return AppointmentPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Approve {
  const Approve({required this.status});

  factory Approve.fromJson(Map<String, dynamic> json) =>
      _$ApproveFromJson(json);

  static const toJsonFactory = _$ApproveToJson;
  Map<String, dynamic> toJson() => _$ApproveToJson(this);

  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$ApproveFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Approve &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $ApproveExtension on Approve {
  Approve copyWith({String? status}) {
    return Approve(status: status ?? this.status);
  }

  Approve copyWithWrapped({Wrapped<String>? status}) {
    return Approve(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class BreedsSpeciesStatsItem {
  const BreedsSpeciesStatsItem({
    required this.id,
    required this.name,
    required this.count,
  });

  factory BreedsSpeciesStatsItem.fromJson(Map<String, dynamic> json) =>
      _$BreedsSpeciesStatsItemFromJson(json);

  static const toJsonFactory = _$BreedsSpeciesStatsItemToJson;
  Map<String, dynamic> toJson() => _$BreedsSpeciesStatsItemToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'count')
  final int count;
  static const fromJsonFactory = _$BreedsSpeciesStatsItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BreedsSpeciesStatsItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(count) ^
      runtimeType.hashCode;
}

extension $BreedsSpeciesStatsItemExtension on BreedsSpeciesStatsItem {
  BreedsSpeciesStatsItem copyWith({int? id, String? name, int? count}) {
    return BreedsSpeciesStatsItem(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  BreedsSpeciesStatsItem copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? name,
    Wrapped<int>? count,
  }) {
    return BreedsSpeciesStatsItem(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      count: (count != null ? count.value : this.count),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CourseOfTreatmentPrescription {
  const CourseOfTreatmentPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory CourseOfTreatmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$CourseOfTreatmentPrescriptionFromJson(json);

  static const toJsonFactory = _$CourseOfTreatmentPrescriptionToJson;
  Map<String, dynamic> toJson() => _$CourseOfTreatmentPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: courseOfTreatmentPrescriptionMyTypeEnumToJson,
    fromJson: courseOfTreatmentPrescriptionMyTypeEnumFromJson,
  )
  final enums.CourseOfTreatmentPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$CourseOfTreatmentPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CourseOfTreatmentPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $CourseOfTreatmentPrescriptionExtension
    on CourseOfTreatmentPrescription {
  CourseOfTreatmentPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.CourseOfTreatmentPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return CourseOfTreatmentPrescription(
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
      files: files ?? this.files,
    );
  }

  CourseOfTreatmentPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.CourseOfTreatmentPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return CourseOfTreatmentPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Curator {
  const Curator({
    this.id,
    this.url,
    this.shelter,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNumber,
    required this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Curator.fromJson(Map<String, dynamic> json) =>
      _$CuratorFromJson(json);

  static const toJsonFactory = _$CuratorToJson;
  Map<String, dynamic> toJson() => _$CuratorToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'shelter')
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$CuratorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Curator &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  Curator copyWith({
    int? id,
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
    DateTime? updatedAt,
  }) {
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Curator copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<String?>? shelter,
    Wrapped<String>? firstName,
    Wrapped<String>? lastName,
    Wrapped<String?>? email,
    Wrapped<String>? phoneNumber,
    Wrapped<String>? address,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return Curator(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DateJoinedInnerSpeciesCounts {
  const DateJoinedInnerSpeciesCounts({
    required this.id,
    required this.name,
    required this.count,
    this.breeds,
  });

  factory DateJoinedInnerSpeciesCounts.fromJson(Map<String, dynamic> json) =>
      _$DateJoinedInnerSpeciesCountsFromJson(json);

  static const toJsonFactory = _$DateJoinedInnerSpeciesCountsToJson;
  Map<String, dynamic> toJson() => _$DateJoinedInnerSpeciesCountsToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'breeds', defaultValue: <BreedsSpeciesStatsItem>[])
  final List<BreedsSpeciesStatsItem>? breeds;
  static const fromJsonFactory = _$DateJoinedInnerSpeciesCountsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DateJoinedInnerSpeciesCounts &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.breeds, breeds) ||
                const DeepCollectionEquality().equals(other.breeds, breeds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(breeds) ^
      runtimeType.hashCode;
}

extension $DateJoinedInnerSpeciesCountsExtension
    on DateJoinedInnerSpeciesCounts {
  DateJoinedInnerSpeciesCounts copyWith({
    int? id,
    String? name,
    int? count,
    List<BreedsSpeciesStatsItem>? breeds,
  }) {
    return DateJoinedInnerSpeciesCounts(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
      breeds: breeds ?? this.breeds,
    );
  }

  DateJoinedInnerSpeciesCounts copyWithWrapped({
    Wrapped<int>? id,
    Wrapped<String>? name,
    Wrapped<int>? count,
    Wrapped<List<BreedsSpeciesStatsItem>?>? breeds,
  }) {
    return DateJoinedInnerSpeciesCounts(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      count: (count != null ? count.value : this.count),
      breeds: (breeds != null ? breeds.value : this.breeds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DateJoinedStatsItem {
  const DateJoinedStatsItem({
    required this.dateJoined,
    required this.count,
    this.species,
  });

  factory DateJoinedStatsItem.fromJson(Map<String, dynamic> json) =>
      _$DateJoinedStatsItemFromJson(json);

  static const toJsonFactory = _$DateJoinedStatsItemToJson;
  Map<String, dynamic> toJson() => _$DateJoinedStatsItemToJson(this);

  @JsonKey(name: 'date_joined', toJson: _dateToJson)
  final DateTime dateJoined;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'species', defaultValue: <DateJoinedInnerSpeciesCounts>[])
  final List<DateJoinedInnerSpeciesCounts>? species;
  static const fromJsonFactory = _$DateJoinedStatsItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DateJoinedStatsItem &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.species, species) ||
                const DeepCollectionEquality().equals(other.species, species)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dateJoined) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(species) ^
      runtimeType.hashCode;
}

extension $DateJoinedStatsItemExtension on DateJoinedStatsItem {
  DateJoinedStatsItem copyWith({
    DateTime? dateJoined,
    int? count,
    List<DateJoinedInnerSpeciesCounts>? species,
  }) {
    return DateJoinedStatsItem(
      dateJoined: dateJoined ?? this.dateJoined,
      count: count ?? this.count,
      species: species ?? this.species,
    );
  }

  DateJoinedStatsItem copyWithWrapped({
    Wrapped<DateTime>? dateJoined,
    Wrapped<int>? count,
    Wrapped<List<DateJoinedInnerSpeciesCounts>?>? species,
  }) {
    return DateJoinedStatsItem(
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      count: (count != null ? count.value : this.count),
      species: (species != null ? species.value : this.species),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Decline {
  const Decline({required this.status});

  factory Decline.fromJson(Map<String, dynamic> json) =>
      _$DeclineFromJson(json);

  static const toJsonFactory = _$DeclineToJson;
  Map<String, dynamic> toJson() => _$DeclineToJson(this);

  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$DeclineFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Decline &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $DeclineExtension on Decline {
  Decline copyWith({String? status}) {
    return Decline(status: status ?? this.status);
  }

  Decline copyWithWrapped({Wrapped<String>? status}) {
    return Decline(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class Drug {
  const Drug({
    this.id,
    required this.name,
    required this.usageInstruction,
    required this.formOfDrug,
    this.formOfDrugName,
  });

  factory Drug.fromJson(Map<String, dynamic> json) => _$DrugFromJson(json);

  static const toJsonFactory = _$DrugToJson;
  Map<String, dynamic> toJson() => _$DrugToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'usage_instruction')
  final String usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final int formOfDrug;
  @JsonKey(name: 'form_of_drug_name')
  final String? formOfDrugName;
  static const fromJsonFactory = _$DrugFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Drug &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.usageInstruction, usageInstruction) ||
                const DeepCollectionEquality().equals(
                  other.usageInstruction,
                  usageInstruction,
                )) &&
            (identical(other.formOfDrug, formOfDrug) ||
                const DeepCollectionEquality().equals(
                  other.formOfDrug,
                  formOfDrug,
                )) &&
            (identical(other.formOfDrugName, formOfDrugName) ||
                const DeepCollectionEquality().equals(
                  other.formOfDrugName,
                  formOfDrugName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  Drug copyWith({
    int? id,
    String? name,
    String? usageInstruction,
    int? formOfDrug,
    String? formOfDrugName,
  }) {
    return Drug(
      id: id ?? this.id,
      name: name ?? this.name,
      usageInstruction: usageInstruction ?? this.usageInstruction,
      formOfDrug: formOfDrug ?? this.formOfDrug,
      formOfDrugName: formOfDrugName ?? this.formOfDrugName,
    );
  }

  Drug copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? name,
    Wrapped<String>? usageInstruction,
    Wrapped<int>? formOfDrug,
    Wrapped<String?>? formOfDrugName,
  }) {
    return Drug(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      usageInstruction: (usageInstruction != null
          ? usageInstruction.value
          : this.usageInstruction),
      formOfDrug: (formOfDrug != null ? formOfDrug.value : this.formOfDrug),
      formOfDrugName: (formOfDrugName != null
          ? formOfDrugName.value
          : this.formOfDrugName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Email {
  const Email({required this.email});

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  static const toJsonFactory = _$EmailToJson;
  Map<String, dynamic> toJson() => _$EmailToJson(this);

  @JsonKey(name: 'email')
  final String email;
  static const fromJsonFactory = _$EmailFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Email &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $EmailExtension on Email {
  Email copyWith({String? email}) {
    return Email(email: email ?? this.email);
  }

  Email copyWithWrapped({Wrapped<String>? email}) {
    return Email(email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class Feedback {
  const Feedback({
    required this.shelterId,
    required this.shelterName,
    required this.date,
    required this.action,
    required this.email,
    required this.message,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  static const toJsonFactory = _$FeedbackToJson;
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);

  @JsonKey(name: 'shelter_id')
  final int shelterId;
  @JsonKey(name: 'shelter_name')
  final String shelterName;
  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime date;
  @JsonKey(name: 'action')
  final String action;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'message')
  final String message;
  static const fromJsonFactory = _$FeedbackFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Feedback &&
            (identical(other.shelterId, shelterId) ||
                const DeepCollectionEquality().equals(
                  other.shelterId,
                  shelterId,
                )) &&
            (identical(other.shelterName, shelterName) ||
                const DeepCollectionEquality().equals(
                  other.shelterName,
                  shelterName,
                )) &&
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
  String toString() => jsonEncode(this);

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
  Feedback copyWith({
    int? shelterId,
    String? shelterName,
    DateTime? date,
    String? action,
    String? email,
    String? message,
  }) {
    return Feedback(
      shelterId: shelterId ?? this.shelterId,
      shelterName: shelterName ?? this.shelterName,
      date: date ?? this.date,
      action: action ?? this.action,
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  Feedback copyWithWrapped({
    Wrapped<int>? shelterId,
    Wrapped<String>? shelterName,
    Wrapped<DateTime>? date,
    Wrapped<String>? action,
    Wrapped<String>? email,
    Wrapped<String>? message,
  }) {
    return Feedback(
      shelterId: (shelterId != null ? shelterId.value : this.shelterId),
      shelterName: (shelterName != null ? shelterName.value : this.shelterName),
      date: (date != null ? date.value : this.date),
      action: (action != null ? action.value : this.action),
      email: (email != null ? email.value : this.email),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ImageThumbnails {
  const ImageThumbnails({
    required this.large,
    required this.medium,
    required this.small,
  });

  factory ImageThumbnails.fromJson(Map<String, dynamic> json) =>
      _$ImageThumbnailsFromJson(json);

  static const toJsonFactory = _$ImageThumbnailsToJson;
  Map<String, dynamic> toJson() => _$ImageThumbnailsToJson(this);

  @JsonKey(name: 'large')
  final String large;
  @JsonKey(name: 'medium')
  final String medium;
  @JsonKey(name: 'small')
  final String small;
  static const fromJsonFactory = _$ImageThumbnailsFromJson;

  @override
  bool operator ==(Object other) {
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
  String toString() => jsonEncode(this);

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
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
    );
  }

  ImageThumbnails copyWithWrapped({
    Wrapped<String>? large,
    Wrapped<String>? medium,
    Wrapped<String>? small,
  }) {
    return ImageThumbnails(
      large: (large != null ? large.value : this.large),
      medium: (medium != null ? medium.value : this.medium),
      small: (small != null ? small.value : this.small),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OtherPrescription {
  const OtherPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory OtherPrescription.fromJson(Map<String, dynamic> json) =>
      _$OtherPrescriptionFromJson(json);

  static const toJsonFactory = _$OtherPrescriptionToJson;
  Map<String, dynamic> toJson() => _$OtherPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: otherPrescriptionMyTypeEnumToJson,
    fromJson: otherPrescriptionMyTypeEnumFromJson,
  )
  final enums.OtherPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$OtherPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OtherPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $OtherPrescriptionExtension on OtherPrescription {
  OtherPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.OtherPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return OtherPrescription(
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
      files: files ?? this.files,
    );
  }

  OtherPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.OtherPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return OtherPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Overstay {
  const Overstay({this.startDate, this.endDate, this.animalSitter});

  factory Overstay.fromJson(Map<String, dynamic> json) =>
      _$OverstayFromJson(json);

  static const toJsonFactory = _$OverstayToJson;
  Map<String, dynamic> toJson() => _$OverstayToJson(this);

  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime? startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime? endDate;
  @JsonKey(name: 'animal_sitter')
  final int? animalSitter;
  static const fromJsonFactory = _$OverstayFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Overstay &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.animalSitter, animalSitter) ||
                const DeepCollectionEquality().equals(
                  other.animalSitter,
                  animalSitter,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(animalSitter) ^
      runtimeType.hashCode;
}

extension $OverstayExtension on Overstay {
  Overstay copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? animalSitter,
  }) {
    return Overstay(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      animalSitter: animalSitter ?? this.animalSitter,
    );
  }

  Overstay copyWithWrapped({
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<int?>? animalSitter,
  }) {
    return Overstay(
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      animalSitter: (animalSitter != null
          ? animalSitter.value
          : this.animalSitter),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAdopterList {
  const PaginatedAdopterList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAdopterList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAdopterListFromJson(json);

  static const toJsonFactory = _$PaginatedAdopterListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAdopterListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Adopter>[])
  final List<Adopter>? results;
  static const fromJsonFactory = _$PaginatedAdopterListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedAdopterList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAdopterListExtension on PaginatedAdopterList {
  PaginatedAdopterList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Adopter>? results,
  }) {
    return PaginatedAdopterList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedAdopterList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Adopter>?>? results,
  }) {
    return PaginatedAdopterList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAdoptionList {
  const PaginatedAdoptionList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAdoptionList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAdoptionListFromJson(json);

  static const toJsonFactory = _$PaginatedAdoptionListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAdoptionListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Adoption>[])
  final List<Adoption>? results;
  static const fromJsonFactory = _$PaginatedAdoptionListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedAdoptionList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAdoptionListExtension on PaginatedAdoptionList {
  PaginatedAdoptionList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Adoption>? results,
  }) {
    return PaginatedAdoptionList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedAdoptionList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Adoption>?>? results,
  }) {
    return PaginatedAdoptionList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalHistorySnapshotList {
  const PaginatedAnimalHistorySnapshotList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalHistorySnapshotList.fromJson(
    Map<String, dynamic> json,
  ) => _$PaginatedAnimalHistorySnapshotListFromJson(json);

  static const toJsonFactory = _$PaginatedAnimalHistorySnapshotListToJson;
  Map<String, dynamic> toJson() =>
      _$PaginatedAnimalHistorySnapshotListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalHistorySnapshot>[])
  final List<AnimalHistorySnapshot>? results;
  static const fromJsonFactory = _$PaginatedAnimalHistorySnapshotListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedAnimalHistorySnapshotList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalHistorySnapshotListExtension
    on PaginatedAnimalHistorySnapshotList {
  PaginatedAnimalHistorySnapshotList copyWith({
    int? count,
    String? next,
    String? previous,
    List<AnimalHistorySnapshot>? results,
  }) {
    return PaginatedAnimalHistorySnapshotList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedAnimalHistorySnapshotList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<AnimalHistorySnapshot>?>? results,
  }) {
    return PaginatedAnimalHistorySnapshotList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalNoteList {
  const PaginatedAnimalNoteList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalNoteList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAnimalNoteListFromJson(json);

  static const toJsonFactory = _$PaginatedAnimalNoteListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAnimalNoteListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalNote>[])
  final List<AnimalNote>? results;
  static const fromJsonFactory = _$PaginatedAnimalNoteListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedAnimalNoteList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalNoteListExtension on PaginatedAnimalNoteList {
  PaginatedAnimalNoteList copyWith({
    int? count,
    String? next,
    String? previous,
    List<AnimalNote>? results,
  }) {
    return PaginatedAnimalNoteList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedAnimalNoteList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<AnimalNote>?>? results,
  }) {
    return PaginatedAnimalNoteList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalReadList {
  const PaginatedAnimalReadList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalReadList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAnimalReadListFromJson(json);

  static const toJsonFactory = _$PaginatedAnimalReadListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAnimalReadListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalRead>[])
  final List<AnimalRead>? results;
  static const fromJsonFactory = _$PaginatedAnimalReadListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedAnimalReadList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalReadListExtension on PaginatedAnimalReadList {
  PaginatedAnimalReadList copyWith({
    int? count,
    String? next,
    String? previous,
    List<AnimalRead>? results,
  }) {
    return PaginatedAnimalReadList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedAnimalReadList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<AnimalRead>?>? results,
  }) {
    return PaginatedAnimalReadList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedAnimalSitterList {
  const PaginatedAnimalSitterList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedAnimalSitterList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedAnimalSitterListFromJson(json);

  static const toJsonFactory = _$PaginatedAnimalSitterListToJson;
  Map<String, dynamic> toJson() => _$PaginatedAnimalSitterListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <AnimalSitter>[])
  final List<AnimalSitter>? results;
  static const fromJsonFactory = _$PaginatedAnimalSitterListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedAnimalSitterList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedAnimalSitterListExtension on PaginatedAnimalSitterList {
  PaginatedAnimalSitterList copyWith({
    int? count,
    String? next,
    String? previous,
    List<AnimalSitter>? results,
  }) {
    return PaginatedAnimalSitterList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedAnimalSitterList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<AnimalSitter>?>? results,
  }) {
    return PaginatedAnimalSitterList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedApplicantList {
  const PaginatedApplicantList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedApplicantList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedApplicantListFromJson(json);

  static const toJsonFactory = _$PaginatedApplicantListToJson;
  Map<String, dynamic> toJson() => _$PaginatedApplicantListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Applicant>[])
  final List<Applicant>? results;
  static const fromJsonFactory = _$PaginatedApplicantListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedApplicantList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedApplicantListExtension on PaginatedApplicantList {
  PaginatedApplicantList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Applicant>? results,
  }) {
    return PaginatedApplicantList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedApplicantList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Applicant>?>? results,
  }) {
    return PaginatedApplicantList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedCuratorList {
  const PaginatedCuratorList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedCuratorList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedCuratorListFromJson(json);

  static const toJsonFactory = _$PaginatedCuratorListToJson;
  Map<String, dynamic> toJson() => _$PaginatedCuratorListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Curator>[])
  final List<Curator>? results;
  static const fromJsonFactory = _$PaginatedCuratorListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedCuratorList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedCuratorListExtension on PaginatedCuratorList {
  PaginatedCuratorList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Curator>? results,
  }) {
    return PaginatedCuratorList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedCuratorList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Curator>?>? results,
  }) {
    return PaginatedCuratorList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedOverstayList {
  const PaginatedOverstayList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedOverstayList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedOverstayListFromJson(json);

  static const toJsonFactory = _$PaginatedOverstayListToJson;
  Map<String, dynamic> toJson() => _$PaginatedOverstayListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Overstay>[])
  final List<Overstay>? results;
  static const fromJsonFactory = _$PaginatedOverstayListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedOverstayList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedOverstayListExtension on PaginatedOverstayList {
  PaginatedOverstayList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Overstay>? results,
  }) {
    return PaginatedOverstayList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedOverstayList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Overstay>?>? results,
  }) {
    return PaginatedOverstayList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedPrescriptionExecutionTodayList {
  const PaginatedPrescriptionExecutionTodayList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedPrescriptionExecutionTodayList.fromJson(
    Map<String, dynamic> json,
  ) => _$PaginatedPrescriptionExecutionTodayListFromJson(json);

  static const toJsonFactory = _$PaginatedPrescriptionExecutionTodayListToJson;
  Map<String, dynamic> toJson() =>
      _$PaginatedPrescriptionExecutionTodayListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <PrescriptionExecutionToday>[])
  final List<PrescriptionExecutionToday>? results;
  static const fromJsonFactory =
      _$PaginatedPrescriptionExecutionTodayListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedPrescriptionExecutionTodayList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

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
  PaginatedPrescriptionExecutionTodayList copyWith({
    int? count,
    String? next,
    String? previous,
    List<PrescriptionExecutionToday>? results,
  }) {
    return PaginatedPrescriptionExecutionTodayList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedPrescriptionExecutionTodayList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<PrescriptionExecutionToday>?>? results,
  }) {
    return PaginatedPrescriptionExecutionTodayList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedPrescriptionList {
  const PaginatedPrescriptionList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedPrescriptionList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedPrescriptionListFromJson(json);

  static const toJsonFactory = _$PaginatedPrescriptionListToJson;
  Map<String, dynamic> toJson() => _$PaginatedPrescriptionListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Prescription>[])
  final List<Prescription>? results;
  static const fromJsonFactory = _$PaginatedPrescriptionListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedPrescriptionList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedPrescriptionListExtension on PaginatedPrescriptionList {
  PaginatedPrescriptionList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Prescription>? results,
  }) {
    return PaginatedPrescriptionList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedPrescriptionList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Prescription>?>? results,
  }) {
    return PaginatedPrescriptionList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedReleaseSerializersList {
  const PaginatedReleaseSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedReleaseSerializersList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedReleaseSerializersListFromJson(json);

  static const toJsonFactory = _$PaginatedReleaseSerializersListToJson;
  Map<String, dynamic> toJson() =>
      _$PaginatedReleaseSerializersListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <ReleaseSerializers>[])
  final List<ReleaseSerializers>? results;
  static const fromJsonFactory = _$PaginatedReleaseSerializersListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedReleaseSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedReleaseSerializersListExtension
    on PaginatedReleaseSerializersList {
  PaginatedReleaseSerializersList copyWith({
    int? count,
    String? next,
    String? previous,
    List<ReleaseSerializers>? results,
  }) {
    return PaginatedReleaseSerializersList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedReleaseSerializersList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<ReleaseSerializers>?>? results,
  }) {
    return PaginatedReleaseSerializersList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedShelterDrugList {
  const PaginatedShelterDrugList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedShelterDrugList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedShelterDrugListFromJson(json);

  static const toJsonFactory = _$PaginatedShelterDrugListToJson;
  Map<String, dynamic> toJson() => _$PaginatedShelterDrugListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <ShelterDrug>[])
  final List<ShelterDrug>? results;
  static const fromJsonFactory = _$PaginatedShelterDrugListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedShelterDrugList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedShelterDrugListExtension on PaginatedShelterDrugList {
  PaginatedShelterDrugList copyWith({
    int? count,
    String? next,
    String? previous,
    List<ShelterDrug>? results,
  }) {
    return PaginatedShelterDrugList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedShelterDrugList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<ShelterDrug>?>? results,
  }) {
    return PaginatedShelterDrugList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedShelterShortSerializersList {
  const PaginatedShelterShortSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedShelterShortSerializersList.fromJson(
    Map<String, dynamic> json,
  ) => _$PaginatedShelterShortSerializersListFromJson(json);

  static const toJsonFactory = _$PaginatedShelterShortSerializersListToJson;
  Map<String, dynamic> toJson() =>
      _$PaginatedShelterShortSerializersListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <ShelterShortSerializers>[])
  final List<ShelterShortSerializers>? results;
  static const fromJsonFactory = _$PaginatedShelterShortSerializersListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedShelterShortSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedShelterShortSerializersListExtension
    on PaginatedShelterShortSerializersList {
  PaginatedShelterShortSerializersList copyWith({
    int? count,
    String? next,
    String? previous,
    List<ShelterShortSerializers>? results,
  }) {
    return PaginatedShelterShortSerializersList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedShelterShortSerializersList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<ShelterShortSerializers>?>? results,
  }) {
    return PaginatedShelterShortSerializersList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedSpeciesList {
  const PaginatedSpeciesList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedSpeciesList.fromJson(Map<String, dynamic> json) =>
      _$PaginatedSpeciesListFromJson(json);

  static const toJsonFactory = _$PaginatedSpeciesListToJson;
  Map<String, dynamic> toJson() => _$PaginatedSpeciesListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <Species>[])
  final List<Species>? results;
  static const fromJsonFactory = _$PaginatedSpeciesListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedSpeciesList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedSpeciesListExtension on PaginatedSpeciesList {
  PaginatedSpeciesList copyWith({
    int? count,
    String? next,
    String? previous,
    List<Species>? results,
  }) {
    return PaginatedSpeciesList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedSpeciesList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<Species>?>? results,
  }) {
    return PaginatedSpeciesList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedUserSheltersAdminSerializersList {
  const PaginatedUserSheltersAdminSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedUserSheltersAdminSerializersList.fromJson(
    Map<String, dynamic> json,
  ) => _$PaginatedUserSheltersAdminSerializersListFromJson(json);

  static const toJsonFactory =
      _$PaginatedUserSheltersAdminSerializersListToJson;
  Map<String, dynamic> toJson() =>
      _$PaginatedUserSheltersAdminSerializersListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <UserSheltersAdminSerializers>[])
  final List<UserSheltersAdminSerializers>? results;
  static const fromJsonFactory =
      _$PaginatedUserSheltersAdminSerializersListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedUserSheltersAdminSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

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
  PaginatedUserSheltersAdminSerializersList copyWith({
    int? count,
    String? next,
    String? previous,
    List<UserSheltersAdminSerializers>? results,
  }) {
    return PaginatedUserSheltersAdminSerializersList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedUserSheltersAdminSerializersList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<UserSheltersAdminSerializers>?>? results,
  }) {
    return PaginatedUserSheltersAdminSerializersList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedUserShortSerializersList {
  const PaginatedUserShortSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PaginatedUserShortSerializersList.fromJson(
    Map<String, dynamic> json,
  ) => _$PaginatedUserShortSerializersListFromJson(json);

  static const toJsonFactory = _$PaginatedUserShortSerializersListToJson;
  Map<String, dynamic> toJson() =>
      _$PaginatedUserShortSerializersListToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results', defaultValue: <UserShortSerializers>[])
  final List<UserShortSerializers>? results;
  static const fromJsonFactory = _$PaginatedUserShortSerializersListFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedUserShortSerializersList &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality().equals(
                  other.previous,
                  previous,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PaginatedUserShortSerializersListExtension
    on PaginatedUserShortSerializersList {
  PaginatedUserShortSerializersList copyWith({
    int? count,
    String? next,
    String? previous,
    List<UserShortSerializers>? results,
  }) {
    return PaginatedUserShortSerializersList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  PaginatedUserShortSerializersList copyWithWrapped({
    Wrapped<int?>? count,
    Wrapped<String?>? next,
    Wrapped<String?>? previous,
    Wrapped<List<UserShortSerializers>?>? results,
  }) {
    return PaginatedUserShortSerializersList(
      count: (count != null ? count.value : this.count),
      next: (next != null ? next.value : this.next),
      previous: (previous != null ? previous.value : this.previous),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ParasitesPrescriptionExtraAttr {
  const ParasitesPrescriptionExtraAttr({this.parasitesType, this.reaction});

  factory ParasitesPrescriptionExtraAttr.fromJson(Map<String, dynamic> json) =>
      _$ParasitesPrescriptionExtraAttrFromJson(json);

  static const toJsonFactory = _$ParasitesPrescriptionExtraAttrToJson;
  Map<String, dynamic> toJson() => _$ParasitesPrescriptionExtraAttrToJson(this);

  @JsonKey(
    name: 'parasites_type',
    toJson: parasitesTypeEnumNullableToJson,
    fromJson: parasitesTypeEnumNullableFromJson,
  )
  final enums.ParasitesTypeEnum? parasitesType;
  @JsonKey(name: 'reaction')
  final String? reaction;
  static const fromJsonFactory = _$ParasitesPrescriptionExtraAttrFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ParasitesPrescriptionExtraAttr &&
            (identical(other.parasitesType, parasitesType) ||
                const DeepCollectionEquality().equals(
                  other.parasitesType,
                  parasitesType,
                )) &&
            (identical(other.reaction, reaction) ||
                const DeepCollectionEquality().equals(
                  other.reaction,
                  reaction,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(parasitesType) ^
      const DeepCollectionEquality().hash(reaction) ^
      runtimeType.hashCode;
}

extension $ParasitesPrescriptionExtraAttrExtension
    on ParasitesPrescriptionExtraAttr {
  ParasitesPrescriptionExtraAttr copyWith({
    enums.ParasitesTypeEnum? parasitesType,
    String? reaction,
  }) {
    return ParasitesPrescriptionExtraAttr(
      parasitesType: parasitesType ?? this.parasitesType,
      reaction: reaction ?? this.reaction,
    );
  }

  ParasitesPrescriptionExtraAttr copyWithWrapped({
    Wrapped<enums.ParasitesTypeEnum?>? parasitesType,
    Wrapped<String?>? reaction,
  }) {
    return ParasitesPrescriptionExtraAttr(
      parasitesType: (parasitesType != null
          ? parasitesType.value
          : this.parasitesType),
      reaction: (reaction != null ? reaction.value : this.reaction),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ParasitesTreatmentPrescription {
  const ParasitesTreatmentPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    required this.extraTypeAttributes,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory ParasitesTreatmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$ParasitesTreatmentPrescriptionFromJson(json);

  static const toJsonFactory = _$ParasitesTreatmentPrescriptionToJson;
  Map<String, dynamic> toJson() => _$ParasitesTreatmentPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: parasitesTreatmentPrescriptionMyTypeEnumToJson,
    fromJson: parasitesTreatmentPrescriptionMyTypeEnumFromJson,
  )
  final enums.ParasitesTreatmentPrescriptionMyTypeEnum myType;
  @JsonKey(name: 'extra_type_attributes')
  final ParasitesPrescriptionExtraAttr extraTypeAttributes;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$ParasitesTreatmentPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ParasitesTreatmentPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.extraTypeAttributes, extraTypeAttributes) ||
                const DeepCollectionEquality().equals(
                  other.extraTypeAttributes,
                  extraTypeAttributes,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(myType) ^
      const DeepCollectionEquality().hash(extraTypeAttributes) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(drugs) ^
      const DeepCollectionEquality().hash(executions) ^
      const DeepCollectionEquality().hash(files) ^
      runtimeType.hashCode;
}

extension $ParasitesTreatmentPrescriptionExtension
    on ParasitesTreatmentPrescription {
  ParasitesTreatmentPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.ParasitesTreatmentPrescriptionMyTypeEnum? myType,
    ParasitesPrescriptionExtraAttr? extraTypeAttributes,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return ParasitesTreatmentPrescription(
      id: id ?? this.id,
      url: url ?? this.url,
      animal: animal ?? this.animal,
      myType: myType ?? this.myType,
      extraTypeAttributes: extraTypeAttributes ?? this.extraTypeAttributes,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      drugs: drugs ?? this.drugs,
      executions: executions ?? this.executions,
      files: files ?? this.files,
    );
  }

  ParasitesTreatmentPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.ParasitesTreatmentPrescriptionMyTypeEnum>? myType,
    Wrapped<ParasitesPrescriptionExtraAttr>? extraTypeAttributes,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return ParasitesTreatmentPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      extraTypeAttributes: (extraTypeAttributes != null
          ? extraTypeAttributes.value
          : this.extraTypeAttributes),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAdopter {
  const PatchedAdopter({
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

  factory PatchedAdopter.fromJson(Map<String, dynamic> json) =>
      _$PatchedAdopterFromJson(json);

  static const toJsonFactory = _$PatchedAdopterToJson;
  Map<String, dynamic> toJson() => _$PatchedAdopterToJson(this);

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
  static const fromJsonFactory = _$PatchedAdopterFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAdopter &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedAdopterExtension on PatchedAdopter {
  PatchedAdopter copyWith({
    int? id,
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
    DateTime? updatedAt,
  }) {
    return PatchedAdopter(
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  PatchedAdopter copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<String?>? shelter,
    Wrapped<String?>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return PatchedAdopter(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAdoption {
  const PatchedAdoption({this.startDate, this.endDate, this.adopter});

  factory PatchedAdoption.fromJson(Map<String, dynamic> json) =>
      _$PatchedAdoptionFromJson(json);

  static const toJsonFactory = _$PatchedAdoptionToJson;
  Map<String, dynamic> toJson() => _$PatchedAdoptionToJson(this);

  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime? startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime? endDate;
  @JsonKey(name: 'adopter')
  final int? adopter;
  static const fromJsonFactory = _$PatchedAdoptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAdoption &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.adopter, adopter) ||
                const DeepCollectionEquality().equals(other.adopter, adopter)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(adopter) ^
      runtimeType.hashCode;
}

extension $PatchedAdoptionExtension on PatchedAdoption {
  PatchedAdoption copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? adopter,
  }) {
    return PatchedAdoption(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      adopter: adopter ?? this.adopter,
    );
  }

  PatchedAdoption copyWithWrapped({
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<int?>? adopter,
  }) {
    return PatchedAdoption(
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      adopter: (adopter != null ? adopter.value : this.adopter),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAnalysisPrescription {
  const PatchedAnalysisPrescription({
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

  factory PatchedAnalysisPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedAnalysisPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedAnalysisPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedAnalysisPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: analysisPrescriptionMyTypeEnumNullableToJson,
    fromJson: analysisPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.AnalysisPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedAnalysisPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAnalysisPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedAnalysisPrescriptionExtension on PatchedAnalysisPrescription {
  PatchedAnalysisPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.AnalysisPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedAnalysisPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedAnalysisPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.AnalysisPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedAnalysisPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAnimalNote {
  const PatchedAnimalNote({
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

  static const toJsonFactory = _$PatchedAnimalNoteToJson;
  Map<String, dynamic> toJson() => _$PatchedAnimalNoteToJson(this);

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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAnimalNote &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(
                  other.content,
                  content,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.isUserCanEditOrDelete, isUserCanEditOrDelete) ||
                const DeepCollectionEquality().equals(
                  other.isUserCanEditOrDelete,
                  isUserCanEditOrDelete,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  PatchedAnimalNote copyWith({
    int? id,
    String? url,
    int? animal,
    String? content,
    List<AnimalNoteFile>? files,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    bool? isUserCanEditOrDelete,
  }) {
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
      isUserCanEditOrDelete:
          isUserCanEditOrDelete ?? this.isUserCanEditOrDelete,
    );
  }

  PatchedAnimalNote copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<String?>? content,
    Wrapped<List<AnimalNoteFile>?>? files,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<bool?>? isUserCanEditOrDelete,
  }) {
    return PatchedAnimalNote(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      content: (content != null ? content.value : this.content),
      files: (files != null ? files.value : this.files),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      isUserCanEditOrDelete: (isUserCanEditOrDelete != null
          ? isUserCanEditOrDelete.value
          : this.isUserCanEditOrDelete),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAnimalSitter {
  const PatchedAnimalSitter({
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

  factory PatchedAnimalSitter.fromJson(Map<String, dynamic> json) =>
      _$PatchedAnimalSitterFromJson(json);

  static const toJsonFactory = _$PatchedAnimalSitterToJson;
  Map<String, dynamic> toJson() => _$PatchedAnimalSitterToJson(this);

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
  static const fromJsonFactory = _$PatchedAnimalSitterFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAnimalSitter &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedAnimalSitterExtension on PatchedAnimalSitter {
  PatchedAnimalSitter copyWith({
    int? id,
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
    DateTime? updatedAt,
  }) {
    return PatchedAnimalSitter(
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  PatchedAnimalSitter copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<String?>? shelter,
    Wrapped<String?>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return PatchedAnimalSitter(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAnimalWrite {
  const PatchedAnimalWrite({
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
    this.canBeShared,
  });

  factory PatchedAnimalWrite.fromJson(Map<String, dynamic> json) =>
      _$PatchedAnimalWriteFromJson(json);

  static const toJsonFactory = _$PatchedAnimalWriteToJson;
  Map<String, dynamic> toJson() => _$PatchedAnimalWriteToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'images', defaultValue: <AnimalImageWrite>[])
  final List<AnimalImageWrite>? images;
  @JsonKey(name: 'valid_images', defaultValue: <int>[])
  final List<int>? validImages;
  @JsonKey(name: 'spec_id')
  final int? specId;
  @JsonKey(
    name: 'status',
    toJson: status69fEnumNullableToJson,
    fromJson: status69fEnumNullableFromJson,
  )
  final enums.Status69fEnum? status;
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
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;
  static const fromJsonFactory = _$PatchedAnimalWriteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAnimalWrite &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.validImages, validImages) ||
                const DeepCollectionEquality().equals(
                  other.validImages,
                  validImages,
                )) &&
            (identical(other.specId, specId) ||
                const DeepCollectionEquality().equals(other.specId, specId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.birthDate, birthDate) ||
                const DeepCollectionEquality().equals(
                  other.birthDate,
                  birthDate,
                )) &&
            (identical(other.deathDate, deathDate) ||
                const DeepCollectionEquality().equals(
                  other.deathDate,
                  deathDate,
                )) &&
            (identical(other.deathReason, deathReason) ||
                const DeepCollectionEquality().equals(
                  other.deathReason,
                  deathReason,
                )) &&
            (identical(other.defaultImageId, defaultImageId) ||
                const DeepCollectionEquality().equals(
                  other.defaultImageId,
                  defaultImageId,
                )) &&
            (identical(other.placeOfCatch, placeOfCatch) ||
                const DeepCollectionEquality().equals(
                  other.placeOfCatch,
                  placeOfCatch,
                )) &&
            (identical(other.placeOfRelease, placeOfRelease) ||
                const DeepCollectionEquality().equals(
                  other.placeOfRelease,
                  placeOfRelease,
                )) &&
            (identical(other.dateOfChipping, dateOfChipping) ||
                const DeepCollectionEquality().equals(
                  other.dateOfChipping,
                  dateOfChipping,
                )) &&
            (identical(other.chippingCode, chippingCode) ||
                const DeepCollectionEquality().equals(
                  other.chippingCode,
                  chippingCode,
                )) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.curatorId, curatorId) ||
                const DeepCollectionEquality().equals(
                  other.curatorId,
                  curatorId,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )) &&
            (identical(other.animalAttributes, animalAttributes) ||
                const DeepCollectionEquality().equals(
                  other.animalAttributes,
                  animalAttributes,
                )) &&
            (identical(other.canBeShared, canBeShared) ||
                const DeepCollectionEquality().equals(
                  other.canBeShared,
                  canBeShared,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
      const DeepCollectionEquality().hash(canBeShared) ^
      runtimeType.hashCode;
}

extension $PatchedAnimalWriteExtension on PatchedAnimalWrite {
  PatchedAnimalWrite copyWith({
    String? name,
    List<AnimalImageWrite>? images,
    List<int>? validImages,
    int? specId,
    enums.Status69fEnum? status,
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
    List<AnimalAttributeValue>? animalAttributes,
    bool? canBeShared,
  }) {
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
      animalAttributes: animalAttributes ?? this.animalAttributes,
      canBeShared: canBeShared ?? this.canBeShared,
    );
  }

  PatchedAnimalWrite copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<List<AnimalImageWrite>?>? images,
    Wrapped<List<int>?>? validImages,
    Wrapped<int?>? specId,
    Wrapped<enums.Status69fEnum?>? status,
    Wrapped<DateTime?>? dateJoined,
    Wrapped<DateTime?>? birthDate,
    Wrapped<DateTime?>? deathDate,
    Wrapped<String?>? deathReason,
    Wrapped<int?>? defaultImageId,
    Wrapped<String?>? placeOfCatch,
    Wrapped<String?>? placeOfRelease,
    Wrapped<DateTime?>? dateOfChipping,
    Wrapped<String?>? chippingCode,
    Wrapped<String?>? height,
    Wrapped<String?>? weight,
    Wrapped<int?>? shelter,
    Wrapped<int?>? curatorId,
    Wrapped<int?>? applicantId,
    Wrapped<List<AnimalAttributeValue>?>? animalAttributes,
    Wrapped<bool?>? canBeShared,
  }) {
    return PatchedAnimalWrite(
      name: (name != null ? name.value : this.name),
      images: (images != null ? images.value : this.images),
      validImages: (validImages != null ? validImages.value : this.validImages),
      specId: (specId != null ? specId.value : this.specId),
      status: (status != null ? status.value : this.status),
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      birthDate: (birthDate != null ? birthDate.value : this.birthDate),
      deathDate: (deathDate != null ? deathDate.value : this.deathDate),
      deathReason: (deathReason != null ? deathReason.value : this.deathReason),
      defaultImageId: (defaultImageId != null
          ? defaultImageId.value
          : this.defaultImageId),
      placeOfCatch: (placeOfCatch != null
          ? placeOfCatch.value
          : this.placeOfCatch),
      placeOfRelease: (placeOfRelease != null
          ? placeOfRelease.value
          : this.placeOfRelease),
      dateOfChipping: (dateOfChipping != null
          ? dateOfChipping.value
          : this.dateOfChipping),
      chippingCode: (chippingCode != null
          ? chippingCode.value
          : this.chippingCode),
      height: (height != null ? height.value : this.height),
      weight: (weight != null ? weight.value : this.weight),
      shelter: (shelter != null ? shelter.value : this.shelter),
      curatorId: (curatorId != null ? curatorId.value : this.curatorId),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
      animalAttributes: (animalAttributes != null
          ? animalAttributes.value
          : this.animalAttributes),
      canBeShared: (canBeShared != null ? canBeShared.value : this.canBeShared),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedApplicant {
  const PatchedApplicant({
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

  factory PatchedApplicant.fromJson(Map<String, dynamic> json) =>
      _$PatchedApplicantFromJson(json);

  static const toJsonFactory = _$PatchedApplicantToJson;
  Map<String, dynamic> toJson() => _$PatchedApplicantToJson(this);

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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedApplicant &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.contactDetails, contactDetails) ||
                const DeepCollectionEquality().equals(
                  other.contactDetails,
                  contactDetails,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.animalId, animalId) ||
                const DeepCollectionEquality().equals(
                  other.animalId,
                  animalId,
                )) &&
            (identical(other.applicantFiles, applicantFiles) ||
                const DeepCollectionEquality().equals(
                  other.applicantFiles,
                  applicantFiles,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  PatchedApplicant copyWith({
    int? id,
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
    List<ApplicantFile>? applicantFiles,
  }) {
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
      applicantFiles: applicantFiles ?? this.applicantFiles,
    );
  }

  PatchedApplicant copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? shelter,
    Wrapped<String?>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? contactDetails,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<int?>? animalId,
    Wrapped<List<ApplicantFile>?>? applicantFiles,
  }) {
    return PatchedApplicant(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      contactDetails: (contactDetails != null
          ? contactDetails.value
          : this.contactDetails),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      animalId: (animalId != null ? animalId.value : this.animalId),
      applicantFiles: (applicantFiles != null
          ? applicantFiles.value
          : this.applicantFiles),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAppointmentPrescription {
  const PatchedAppointmentPrescription({
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

  factory PatchedAppointmentPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedAppointmentPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedAppointmentPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedAppointmentPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: appointmentPrescriptionMyTypeEnumNullableToJson,
    fromJson: appointmentPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.AppointmentPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedAppointmentPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAppointmentPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedAppointmentPrescriptionExtension
    on PatchedAppointmentPrescription {
  PatchedAppointmentPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.AppointmentPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedAppointmentPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedAppointmentPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.AppointmentPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedAppointmentPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedCourseOfTreatmentPrescription {
  const PatchedCourseOfTreatmentPrescription({
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

  factory PatchedCourseOfTreatmentPrescription.fromJson(
    Map<String, dynamic> json,
  ) => _$PatchedCourseOfTreatmentPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedCourseOfTreatmentPrescriptionToJson;
  Map<String, dynamic> toJson() =>
      _$PatchedCourseOfTreatmentPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: courseOfTreatmentPrescriptionMyTypeEnumNullableToJson,
    fromJson: courseOfTreatmentPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.CourseOfTreatmentPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedCourseOfTreatmentPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedCourseOfTreatmentPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedCourseOfTreatmentPrescriptionExtension
    on PatchedCourseOfTreatmentPrescription {
  PatchedCourseOfTreatmentPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.CourseOfTreatmentPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedCourseOfTreatmentPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedCourseOfTreatmentPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.CourseOfTreatmentPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedCourseOfTreatmentPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedCurator {
  const PatchedCurator({
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

  factory PatchedCurator.fromJson(Map<String, dynamic> json) =>
      _$PatchedCuratorFromJson(json);

  static const toJsonFactory = _$PatchedCuratorToJson;
  Map<String, dynamic> toJson() => _$PatchedCuratorToJson(this);

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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedCurator &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  PatchedCurator copyWith({
    int? id,
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
    DateTime? updatedAt,
  }) {
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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  PatchedCurator copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<String?>? shelter,
    Wrapped<String?>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return PatchedCurator(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      shelter: (shelter != null ? shelter.value : this.shelter),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedOtherPrescription {
  const PatchedOtherPrescription({
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

  factory PatchedOtherPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedOtherPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedOtherPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedOtherPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: otherPrescriptionMyTypeEnumNullableToJson,
    fromJson: otherPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.OtherPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedOtherPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedOtherPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedOtherPrescriptionExtension on PatchedOtherPrescription {
  PatchedOtherPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.OtherPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedOtherPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedOtherPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.OtherPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedOtherPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedOverstay {
  const PatchedOverstay({this.startDate, this.endDate, this.animalSitter});

  factory PatchedOverstay.fromJson(Map<String, dynamic> json) =>
      _$PatchedOverstayFromJson(json);

  static const toJsonFactory = _$PatchedOverstayToJson;
  Map<String, dynamic> toJson() => _$PatchedOverstayToJson(this);

  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime? startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime? endDate;
  @JsonKey(name: 'animal_sitter')
  final int? animalSitter;
  static const fromJsonFactory = _$PatchedOverstayFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedOverstay &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.animalSitter, animalSitter) ||
                const DeepCollectionEquality().equals(
                  other.animalSitter,
                  animalSitter,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(animalSitter) ^
      runtimeType.hashCode;
}

extension $PatchedOverstayExtension on PatchedOverstay {
  PatchedOverstay copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? animalSitter,
  }) {
    return PatchedOverstay(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      animalSitter: animalSitter ?? this.animalSitter,
    );
  }

  PatchedOverstay copyWithWrapped({
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<int?>? animalSitter,
  }) {
    return PatchedOverstay(
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      animalSitter: (animalSitter != null
          ? animalSitter.value
          : this.animalSitter),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedParasitesTreatmentPrescription {
  const PatchedParasitesTreatmentPrescription({
    this.id,
    this.url,
    this.animal,
    this.myType,
    this.extraTypeAttributes,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.drugs,
    this.executions,
    this.files,
  });

  factory PatchedParasitesTreatmentPrescription.fromJson(
    Map<String, dynamic> json,
  ) => _$PatchedParasitesTreatmentPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedParasitesTreatmentPrescriptionToJson;
  Map<String, dynamic> toJson() =>
      _$PatchedParasitesTreatmentPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: parasitesTreatmentPrescriptionMyTypeEnumNullableToJson,
    fromJson: parasitesTreatmentPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.ParasitesTreatmentPrescriptionMyTypeEnum? myType;
  @JsonKey(name: 'extra_type_attributes')
  final ParasitesPrescriptionExtraAttr? extraTypeAttributes;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory =
      _$PatchedParasitesTreatmentPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedParasitesTreatmentPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.extraTypeAttributes, extraTypeAttributes) ||
                const DeepCollectionEquality().equals(
                  other.extraTypeAttributes,
                  extraTypeAttributes,
                )) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(myType) ^
      const DeepCollectionEquality().hash(extraTypeAttributes) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(drugs) ^
      const DeepCollectionEquality().hash(executions) ^
      const DeepCollectionEquality().hash(files) ^
      runtimeType.hashCode;
}

extension $PatchedParasitesTreatmentPrescriptionExtension
    on PatchedParasitesTreatmentPrescription {
  PatchedParasitesTreatmentPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.ParasitesTreatmentPrescriptionMyTypeEnum? myType,
    ParasitesPrescriptionExtraAttr? extraTypeAttributes,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedParasitesTreatmentPrescription(
      id: id ?? this.id,
      url: url ?? this.url,
      animal: animal ?? this.animal,
      myType: myType ?? this.myType,
      extraTypeAttributes: extraTypeAttributes ?? this.extraTypeAttributes,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      drugs: drugs ?? this.drugs,
      executions: executions ?? this.executions,
      files: files ?? this.files,
    );
  }

  PatchedParasitesTreatmentPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.ParasitesTreatmentPrescriptionMyTypeEnum?>? myType,
    Wrapped<ParasitesPrescriptionExtraAttr?>? extraTypeAttributes,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedParasitesTreatmentPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      extraTypeAttributes: (extraTypeAttributes != null
          ? extraTypeAttributes.value
          : this.extraTypeAttributes),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedPrescription {
  const PatchedPrescription();

  factory PatchedPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedPrescriptionToJson(this);

  static const fromJsonFactory = _$PatchedPrescriptionFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class PatchedReadmissionPrescription {
  const PatchedReadmissionPrescription({
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

  factory PatchedReadmissionPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedReadmissionPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedReadmissionPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedReadmissionPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: readmissionPrescriptionMyTypeEnumNullableToJson,
    fromJson: readmissionPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.ReadmissionPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedReadmissionPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedReadmissionPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedReadmissionPrescriptionExtension
    on PatchedReadmissionPrescription {
  PatchedReadmissionPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.ReadmissionPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedReadmissionPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedReadmissionPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.ReadmissionPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedReadmissionPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedReleaseSerializers {
  const PatchedReleaseSerializers({
    this.id,
    this.place,
    this.date,
    this.veterinarianName,
    this.veterinarianSurname,
    this.veterinarianPatronymic,
    this.createdAt,
    this.updatedAt,
  });

  factory PatchedReleaseSerializers.fromJson(Map<String, dynamic> json) =>
      _$PatchedReleaseSerializersFromJson(json);

  static const toJsonFactory = _$PatchedReleaseSerializersToJson;
  Map<String, dynamic> toJson() => _$PatchedReleaseSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'place')
  final String? place;
  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(name: 'veterinarian_name')
  final String? veterinarianName;
  @JsonKey(name: 'veterinarian_surname')
  final String? veterinarianSurname;
  @JsonKey(name: 'veterinarian_patronymic')
  final String? veterinarianPatronymic;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$PatchedReleaseSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedReleaseSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.place, place) ||
                const DeepCollectionEquality().equals(other.place, place)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.veterinarianName, veterinarianName) ||
                const DeepCollectionEquality().equals(
                  other.veterinarianName,
                  veterinarianName,
                )) &&
            (identical(other.veterinarianSurname, veterinarianSurname) ||
                const DeepCollectionEquality().equals(
                  other.veterinarianSurname,
                  veterinarianSurname,
                )) &&
            (identical(other.veterinarianPatronymic, veterinarianPatronymic) ||
                const DeepCollectionEquality().equals(
                  other.veterinarianPatronymic,
                  veterinarianPatronymic,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(place) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(veterinarianName) ^
      const DeepCollectionEquality().hash(veterinarianSurname) ^
      const DeepCollectionEquality().hash(veterinarianPatronymic) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $PatchedReleaseSerializersExtension on PatchedReleaseSerializers {
  PatchedReleaseSerializers copyWith({
    int? id,
    String? place,
    DateTime? date,
    String? veterinarianName,
    String? veterinarianSurname,
    String? veterinarianPatronymic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatchedReleaseSerializers(
      id: id ?? this.id,
      place: place ?? this.place,
      date: date ?? this.date,
      veterinarianName: veterinarianName ?? this.veterinarianName,
      veterinarianSurname: veterinarianSurname ?? this.veterinarianSurname,
      veterinarianPatronymic:
          veterinarianPatronymic ?? this.veterinarianPatronymic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  PatchedReleaseSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? place,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? veterinarianName,
    Wrapped<String?>? veterinarianSurname,
    Wrapped<String?>? veterinarianPatronymic,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return PatchedReleaseSerializers(
      id: (id != null ? id.value : this.id),
      place: (place != null ? place.value : this.place),
      date: (date != null ? date.value : this.date),
      veterinarianName: (veterinarianName != null
          ? veterinarianName.value
          : this.veterinarianName),
      veterinarianSurname: (veterinarianSurname != null
          ? veterinarianSurname.value
          : this.veterinarianSurname),
      veterinarianPatronymic: (veterinarianPatronymic != null
          ? veterinarianPatronymic.value
          : this.veterinarianPatronymic),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedRemovingStitchesPrescription {
  const PatchedRemovingStitchesPrescription({
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

  factory PatchedRemovingStitchesPrescription.fromJson(
    Map<String, dynamic> json,
  ) => _$PatchedRemovingStitchesPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedRemovingStitchesPrescriptionToJson;
  Map<String, dynamic> toJson() =>
      _$PatchedRemovingStitchesPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: removingStitchesPrescriptionMyTypeEnumNullableToJson,
    fromJson: removingStitchesPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.RemovingStitchesPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedRemovingStitchesPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedRemovingStitchesPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedRemovingStitchesPrescriptionExtension
    on PatchedRemovingStitchesPrescription {
  PatchedRemovingStitchesPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.RemovingStitchesPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedRemovingStitchesPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedRemovingStitchesPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.RemovingStitchesPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedRemovingStitchesPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedShelterSerializers {
  const PatchedShelterSerializers({
    this.id,
    this.name,
    this.country,
    this.city,
    this.state,
    this.region,
    this.street,
    this.house,
    this.apartment,
    this.officialName,
    this.ogrn,
    this.inn,
    this.kpp,
    this.organizationEmail,
    this.phoneNumber,
    this.websiteLink,
    this.positionOfManager,
    this.firstNameOfManager,
    this.lastNameOfManager,
    this.middleNameOfManager,
    this.fullNameOfTheBank,
    this.shortBankName,
    this.fullEnglishBankName,
    this.legalAddressOfTheBank,
    this.postalAddressOfTheBank,
    this.correspondentAccountOfTheBank,
    this.paymentAccountOfTheOrganization,
    this.bicOfTheBank,
  });

  factory PatchedShelterSerializers.fromJson(Map<String, dynamic> json) =>
      _$PatchedShelterSerializersFromJson(json);

  static const toJsonFactory = _$PatchedShelterSerializersToJson;
  Map<String, dynamic> toJson() => _$PatchedShelterSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
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
  @JsonKey(name: 'official_name')
  final String? officialName;
  @JsonKey(name: 'ogrn')
  final String? ogrn;
  @JsonKey(name: 'inn')
  final String? inn;
  @JsonKey(name: 'kpp')
  final String? kpp;
  @JsonKey(name: 'organization_email')
  final String? organizationEmail;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'website_link')
  final String? websiteLink;
  @JsonKey(name: 'position_of_manager')
  final String? positionOfManager;
  @JsonKey(name: 'first_name_of_manager')
  final String? firstNameOfManager;
  @JsonKey(name: 'last_name_of_manager')
  final String? lastNameOfManager;
  @JsonKey(name: 'middle_name_of_manager')
  final String? middleNameOfManager;
  @JsonKey(name: 'full_name_of_the_bank')
  final String? fullNameOfTheBank;
  @JsonKey(name: 'short_bank_name')
  final String? shortBankName;
  @JsonKey(name: 'full_english_bank_name')
  final String? fullEnglishBankName;
  @JsonKey(name: 'legal_address_of_the_bank')
  final String? legalAddressOfTheBank;
  @JsonKey(name: 'postal_address_of_the_bank')
  final String? postalAddressOfTheBank;
  @JsonKey(name: 'correspondent_account_of_the_bank')
  final String? correspondentAccountOfTheBank;
  @JsonKey(name: 'payment_account_of_the_organization')
  final String? paymentAccountOfTheOrganization;
  @JsonKey(name: 'bic_of_the_bank')
  final String? bicOfTheBank;
  static const fromJsonFactory = _$PatchedShelterSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedShelterSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality().equals(
                  other.country,
                  country,
                )) &&
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
                const DeepCollectionEquality().equals(
                  other.apartment,
                  apartment,
                )) &&
            (identical(other.officialName, officialName) ||
                const DeepCollectionEquality().equals(
                  other.officialName,
                  officialName,
                )) &&
            (identical(other.ogrn, ogrn) ||
                const DeepCollectionEquality().equals(other.ogrn, ogrn)) &&
            (identical(other.inn, inn) ||
                const DeepCollectionEquality().equals(other.inn, inn)) &&
            (identical(other.kpp, kpp) ||
                const DeepCollectionEquality().equals(other.kpp, kpp)) &&
            (identical(other.organizationEmail, organizationEmail) ||
                const DeepCollectionEquality().equals(
                  other.organizationEmail,
                  organizationEmail,
                )) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.websiteLink, websiteLink) ||
                const DeepCollectionEquality().equals(
                  other.websiteLink,
                  websiteLink,
                )) &&
            (identical(other.positionOfManager, positionOfManager) ||
                const DeepCollectionEquality().equals(
                  other.positionOfManager,
                  positionOfManager,
                )) &&
            (identical(other.firstNameOfManager, firstNameOfManager) ||
                const DeepCollectionEquality().equals(
                  other.firstNameOfManager,
                  firstNameOfManager,
                )) &&
            (identical(other.lastNameOfManager, lastNameOfManager) ||
                const DeepCollectionEquality().equals(
                  other.lastNameOfManager,
                  lastNameOfManager,
                )) &&
            (identical(other.middleNameOfManager, middleNameOfManager) ||
                const DeepCollectionEquality().equals(
                  other.middleNameOfManager,
                  middleNameOfManager,
                )) &&
            (identical(other.fullNameOfTheBank, fullNameOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.fullNameOfTheBank,
                  fullNameOfTheBank,
                )) &&
            (identical(other.shortBankName, shortBankName) ||
                const DeepCollectionEquality().equals(
                  other.shortBankName,
                  shortBankName,
                )) &&
            (identical(other.fullEnglishBankName, fullEnglishBankName) ||
                const DeepCollectionEquality().equals(
                  other.fullEnglishBankName,
                  fullEnglishBankName,
                )) &&
            (identical(other.legalAddressOfTheBank, legalAddressOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.legalAddressOfTheBank,
                  legalAddressOfTheBank,
                )) &&
            (identical(other.postalAddressOfTheBank, postalAddressOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.postalAddressOfTheBank,
                  postalAddressOfTheBank,
                )) &&
            (identical(
                  other.correspondentAccountOfTheBank,
                  correspondentAccountOfTheBank,
                ) ||
                const DeepCollectionEquality().equals(
                  other.correspondentAccountOfTheBank,
                  correspondentAccountOfTheBank,
                )) &&
            (identical(
                  other.paymentAccountOfTheOrganization,
                  paymentAccountOfTheOrganization,
                ) ||
                const DeepCollectionEquality().equals(
                  other.paymentAccountOfTheOrganization,
                  paymentAccountOfTheOrganization,
                )) &&
            (identical(other.bicOfTheBank, bicOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.bicOfTheBank,
                  bicOfTheBank,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(region) ^
      const DeepCollectionEquality().hash(street) ^
      const DeepCollectionEquality().hash(house) ^
      const DeepCollectionEquality().hash(apartment) ^
      const DeepCollectionEquality().hash(officialName) ^
      const DeepCollectionEquality().hash(ogrn) ^
      const DeepCollectionEquality().hash(inn) ^
      const DeepCollectionEquality().hash(kpp) ^
      const DeepCollectionEquality().hash(organizationEmail) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(websiteLink) ^
      const DeepCollectionEquality().hash(positionOfManager) ^
      const DeepCollectionEquality().hash(firstNameOfManager) ^
      const DeepCollectionEquality().hash(lastNameOfManager) ^
      const DeepCollectionEquality().hash(middleNameOfManager) ^
      const DeepCollectionEquality().hash(fullNameOfTheBank) ^
      const DeepCollectionEquality().hash(shortBankName) ^
      const DeepCollectionEquality().hash(fullEnglishBankName) ^
      const DeepCollectionEquality().hash(legalAddressOfTheBank) ^
      const DeepCollectionEquality().hash(postalAddressOfTheBank) ^
      const DeepCollectionEquality().hash(correspondentAccountOfTheBank) ^
      const DeepCollectionEquality().hash(paymentAccountOfTheOrganization) ^
      const DeepCollectionEquality().hash(bicOfTheBank) ^
      runtimeType.hashCode;
}

extension $PatchedShelterSerializersExtension on PatchedShelterSerializers {
  PatchedShelterSerializers copyWith({
    int? id,
    String? name,
    String? country,
    String? city,
    String? state,
    String? region,
    String? street,
    String? house,
    String? apartment,
    String? officialName,
    String? ogrn,
    String? inn,
    String? kpp,
    String? organizationEmail,
    String? phoneNumber,
    String? websiteLink,
    String? positionOfManager,
    String? firstNameOfManager,
    String? lastNameOfManager,
    String? middleNameOfManager,
    String? fullNameOfTheBank,
    String? shortBankName,
    String? fullEnglishBankName,
    String? legalAddressOfTheBank,
    String? postalAddressOfTheBank,
    String? correspondentAccountOfTheBank,
    String? paymentAccountOfTheOrganization,
    String? bicOfTheBank,
  }) {
    return PatchedShelterSerializers(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      region: region ?? this.region,
      street: street ?? this.street,
      house: house ?? this.house,
      apartment: apartment ?? this.apartment,
      officialName: officialName ?? this.officialName,
      ogrn: ogrn ?? this.ogrn,
      inn: inn ?? this.inn,
      kpp: kpp ?? this.kpp,
      organizationEmail: organizationEmail ?? this.organizationEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      websiteLink: websiteLink ?? this.websiteLink,
      positionOfManager: positionOfManager ?? this.positionOfManager,
      firstNameOfManager: firstNameOfManager ?? this.firstNameOfManager,
      lastNameOfManager: lastNameOfManager ?? this.lastNameOfManager,
      middleNameOfManager: middleNameOfManager ?? this.middleNameOfManager,
      fullNameOfTheBank: fullNameOfTheBank ?? this.fullNameOfTheBank,
      shortBankName: shortBankName ?? this.shortBankName,
      fullEnglishBankName: fullEnglishBankName ?? this.fullEnglishBankName,
      legalAddressOfTheBank:
          legalAddressOfTheBank ?? this.legalAddressOfTheBank,
      postalAddressOfTheBank:
          postalAddressOfTheBank ?? this.postalAddressOfTheBank,
      correspondentAccountOfTheBank:
          correspondentAccountOfTheBank ?? this.correspondentAccountOfTheBank,
      paymentAccountOfTheOrganization:
          paymentAccountOfTheOrganization ??
          this.paymentAccountOfTheOrganization,
      bicOfTheBank: bicOfTheBank ?? this.bicOfTheBank,
    );
  }

  PatchedShelterSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? country,
    Wrapped<String?>? city,
    Wrapped<String?>? state,
    Wrapped<String?>? region,
    Wrapped<String?>? street,
    Wrapped<String?>? house,
    Wrapped<String?>? apartment,
    Wrapped<String?>? officialName,
    Wrapped<String?>? ogrn,
    Wrapped<String?>? inn,
    Wrapped<String?>? kpp,
    Wrapped<String?>? organizationEmail,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? websiteLink,
    Wrapped<String?>? positionOfManager,
    Wrapped<String?>? firstNameOfManager,
    Wrapped<String?>? lastNameOfManager,
    Wrapped<String?>? middleNameOfManager,
    Wrapped<String?>? fullNameOfTheBank,
    Wrapped<String?>? shortBankName,
    Wrapped<String?>? fullEnglishBankName,
    Wrapped<String?>? legalAddressOfTheBank,
    Wrapped<String?>? postalAddressOfTheBank,
    Wrapped<String?>? correspondentAccountOfTheBank,
    Wrapped<String?>? paymentAccountOfTheOrganization,
    Wrapped<String?>? bicOfTheBank,
  }) {
    return PatchedShelterSerializers(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      country: (country != null ? country.value : this.country),
      city: (city != null ? city.value : this.city),
      state: (state != null ? state.value : this.state),
      region: (region != null ? region.value : this.region),
      street: (street != null ? street.value : this.street),
      house: (house != null ? house.value : this.house),
      apartment: (apartment != null ? apartment.value : this.apartment),
      officialName: (officialName != null
          ? officialName.value
          : this.officialName),
      ogrn: (ogrn != null ? ogrn.value : this.ogrn),
      inn: (inn != null ? inn.value : this.inn),
      kpp: (kpp != null ? kpp.value : this.kpp),
      organizationEmail: (organizationEmail != null
          ? organizationEmail.value
          : this.organizationEmail),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      websiteLink: (websiteLink != null ? websiteLink.value : this.websiteLink),
      positionOfManager: (positionOfManager != null
          ? positionOfManager.value
          : this.positionOfManager),
      firstNameOfManager: (firstNameOfManager != null
          ? firstNameOfManager.value
          : this.firstNameOfManager),
      lastNameOfManager: (lastNameOfManager != null
          ? lastNameOfManager.value
          : this.lastNameOfManager),
      middleNameOfManager: (middleNameOfManager != null
          ? middleNameOfManager.value
          : this.middleNameOfManager),
      fullNameOfTheBank: (fullNameOfTheBank != null
          ? fullNameOfTheBank.value
          : this.fullNameOfTheBank),
      shortBankName: (shortBankName != null
          ? shortBankName.value
          : this.shortBankName),
      fullEnglishBankName: (fullEnglishBankName != null
          ? fullEnglishBankName.value
          : this.fullEnglishBankName),
      legalAddressOfTheBank: (legalAddressOfTheBank != null
          ? legalAddressOfTheBank.value
          : this.legalAddressOfTheBank),
      postalAddressOfTheBank: (postalAddressOfTheBank != null
          ? postalAddressOfTheBank.value
          : this.postalAddressOfTheBank),
      correspondentAccountOfTheBank: (correspondentAccountOfTheBank != null
          ? correspondentAccountOfTheBank.value
          : this.correspondentAccountOfTheBank),
      paymentAccountOfTheOrganization: (paymentAccountOfTheOrganization != null
          ? paymentAccountOfTheOrganization.value
          : this.paymentAccountOfTheOrganization),
      bicOfTheBank: (bicOfTheBank != null
          ? bicOfTheBank.value
          : this.bicOfTheBank),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedUserChangePasswordSerializers {
  const PatchedUserChangePasswordSerializers({
    this.id,
    this.password,
    this.rePassword,
    this.oldPassword,
  });

  factory PatchedUserChangePasswordSerializers.fromJson(
    Map<String, dynamic> json,
  ) => _$PatchedUserChangePasswordSerializersFromJson(json);

  static const toJsonFactory = _$PatchedUserChangePasswordSerializersToJson;
  Map<String, dynamic> toJson() =>
      _$PatchedUserChangePasswordSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'old_password')
  final String? oldPassword;
  static const fromJsonFactory = _$PatchedUserChangePasswordSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedUserChangePasswordSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(
                  other.rePassword,
                  rePassword,
                )) &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality().equals(
                  other.oldPassword,
                  oldPassword,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(rePassword) ^
      const DeepCollectionEquality().hash(oldPassword) ^
      runtimeType.hashCode;
}

extension $PatchedUserChangePasswordSerializersExtension
    on PatchedUserChangePasswordSerializers {
  PatchedUserChangePasswordSerializers copyWith({
    int? id,
    String? password,
    String? rePassword,
    String? oldPassword,
  }) {
    return PatchedUserChangePasswordSerializers(
      id: id ?? this.id,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      oldPassword: oldPassword ?? this.oldPassword,
    );
  }

  PatchedUserChangePasswordSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? password,
    Wrapped<String?>? rePassword,
    Wrapped<String?>? oldPassword,
  }) {
    return PatchedUserChangePasswordSerializers(
      id: (id != null ? id.value : this.id),
      password: (password != null ? password.value : this.password),
      rePassword: (rePassword != null ? rePassword.value : this.rePassword),
      oldPassword: (oldPassword != null ? oldPassword.value : this.oldPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedUserSerializers {
  const PatchedUserSerializers({
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
    this.isOfferSigned,
  });

  factory PatchedUserSerializers.fromJson(Map<String, dynamic> json) =>
      _$PatchedUserSerializersFromJson(json);

  static const toJsonFactory = _$PatchedUserSerializersToJson;
  Map<String, dynamic> toJson() => _$PatchedUserSerializersToJson(this);

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
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;
  static const fromJsonFactory = _$PatchedUserSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedUserSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(
                  other.fathersName,
                  fathersName,
                )) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(
                  other.fullName,
                  fullName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.isVerified, isVerified) ||
                const DeepCollectionEquality().equals(
                  other.isVerified,
                  isVerified,
                )) &&
            (identical(other.isOfferSigned, isOfferSigned) ||
                const DeepCollectionEquality().equals(
                  other.isOfferSigned,
                  isOfferSigned,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
      const DeepCollectionEquality().hash(isOfferSigned) ^
      runtimeType.hashCode;
}

extension $PatchedUserSerializersExtension on PatchedUserSerializers {
  PatchedUserSerializers copyWith({
    int? id,
    String? username,
    String? firstName,
    String? lastName,
    String? fathersName,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? address,
    DateTime? dateJoined,
    bool? isVerified,
    bool? isOfferSigned,
  }) {
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
      isVerified: isVerified ?? this.isVerified,
      isOfferSigned: isOfferSigned ?? this.isOfferSigned,
    );
  }

  PatchedUserSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? username,
    Wrapped<String?>? firstName,
    Wrapped<String?>? lastName,
    Wrapped<String?>? fathersName,
    Wrapped<String?>? fullName,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<DateTime?>? dateJoined,
    Wrapped<bool?>? isVerified,
    Wrapped<bool?>? isOfferSigned,
  }) {
    return PatchedUserSerializers(
      id: (id != null ? id.value : this.id),
      username: (username != null ? username.value : this.username),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      fathersName: (fathersName != null ? fathersName.value : this.fathersName),
      fullName: (fullName != null ? fullName.value : this.fullName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      isVerified: (isVerified != null ? isVerified.value : this.isVerified),
      isOfferSigned: (isOfferSigned != null
          ? isOfferSigned.value
          : this.isOfferSigned),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedUserSheltersAdminSerializers {
  const PatchedUserSheltersAdminSerializers({
    this.id,
    this.user,
    this.userId,
    this.role,
    this.isVerifiedByAdmin,
  });

  factory PatchedUserSheltersAdminSerializers.fromJson(
    Map<String, dynamic> json,
  ) => _$PatchedUserSheltersAdminSerializersFromJson(json);

  static const toJsonFactory = _$PatchedUserSheltersAdminSerializersToJson;
  Map<String, dynamic> toJson() =>
      _$PatchedUserSheltersAdminSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'user')
  final UserSerializers? user;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(
    name: 'role',
    toJson: roleEnumNullableToJson,
    fromJson: roleEnumNullableFromJson,
  )
  final enums.RoleEnum? role;
  @JsonKey(name: 'is_verified_by_admin')
  final bool? isVerifiedByAdmin;
  static const fromJsonFactory = _$PatchedUserSheltersAdminSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedUserSheltersAdminSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.isVerifiedByAdmin, isVerifiedByAdmin) ||
                const DeepCollectionEquality().equals(
                  other.isVerifiedByAdmin,
                  isVerifiedByAdmin,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(isVerifiedByAdmin) ^
      runtimeType.hashCode;
}

extension $PatchedUserSheltersAdminSerializersExtension
    on PatchedUserSheltersAdminSerializers {
  PatchedUserSheltersAdminSerializers copyWith({
    int? id,
    UserSerializers? user,
    int? userId,
    enums.RoleEnum? role,
    bool? isVerifiedByAdmin,
  }) {
    return PatchedUserSheltersAdminSerializers(
      id: id ?? this.id,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      isVerifiedByAdmin: isVerifiedByAdmin ?? this.isVerifiedByAdmin,
    );
  }

  PatchedUserSheltersAdminSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<UserSerializers?>? user,
    Wrapped<int?>? userId,
    Wrapped<enums.RoleEnum?>? role,
    Wrapped<bool?>? isVerifiedByAdmin,
  }) {
    return PatchedUserSheltersAdminSerializers(
      id: (id != null ? id.value : this.id),
      user: (user != null ? user.value : this.user),
      userId: (userId != null ? userId.value : this.userId),
      role: (role != null ? role.value : this.role),
      isVerifiedByAdmin: (isVerifiedByAdmin != null
          ? isVerifiedByAdmin.value
          : this.isVerifiedByAdmin),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedVaccinationPrescription {
  const PatchedVaccinationPrescription({
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

  factory PatchedVaccinationPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedVaccinationPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedVaccinationPrescriptionToJson;
  Map<String, dynamic> toJson() => _$PatchedVaccinationPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: vaccinationPrescriptionMyTypeEnumNullableToJson,
    fromJson: vaccinationPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.VaccinationPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedVaccinationPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedVaccinationPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedVaccinationPrescriptionExtension
    on PatchedVaccinationPrescription {
  PatchedVaccinationPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.VaccinationPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedVaccinationPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedVaccinationPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.VaccinationPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedVaccinationPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedWoundHealingPrescription {
  const PatchedWoundHealingPrescription({
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

  factory PatchedWoundHealingPrescription.fromJson(Map<String, dynamic> json) =>
      _$PatchedWoundHealingPrescriptionFromJson(json);

  static const toJsonFactory = _$PatchedWoundHealingPrescriptionToJson;
  Map<String, dynamic> toJson() =>
      _$PatchedWoundHealingPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int? animal;
  @JsonKey(
    name: 'my_type',
    toJson: woundHealingPrescriptionMyTypeEnumNullableToJson,
    fromJson: woundHealingPrescriptionMyTypeEnumNullableFromJson,
  )
  final enums.WoundHealingPrescriptionMyTypeEnum? myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
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
  static const fromJsonFactory = _$PatchedWoundHealingPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedWoundHealingPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $PatchedWoundHealingPrescriptionExtension
    on PatchedWoundHealingPrescription {
  PatchedWoundHealingPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.WoundHealingPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return PatchedWoundHealingPrescription(
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
      files: files ?? this.files,
    );
  }

  PatchedWoundHealingPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int?>? animal,
    Wrapped<enums.WoundHealingPrescriptionMyTypeEnum?>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>?>? drugs,
    Wrapped<List<PrescriptionExecution>?>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PatchedWoundHealingPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Prescription {
  const Prescription();

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);

  static const toJsonFactory = _$PrescriptionToJson;
  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);

  static const fromJsonFactory = _$PrescriptionFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class PrescriptionDrug {
  const PrescriptionDrug({
    required this.drugId,
    required this.drugName,
    this.usageInstruction,
    this.formOfDrug,
    required this.drugDosage,
  });

  factory PrescriptionDrug.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDrugFromJson(json);

  static const toJsonFactory = _$PrescriptionDrugToJson;
  Map<String, dynamic> toJson() => _$PrescriptionDrugToJson(this);

  @JsonKey(name: 'drug_id')
  final int drugId;
  @JsonKey(name: 'drug_name')
  final String drugName;
  @JsonKey(name: 'usage_instruction')
  final String? usageInstruction;
  @JsonKey(name: 'form_of_drug')
  final String? formOfDrug;
  @JsonKey(name: 'drug_dosage')
  final double drugDosage;
  static const fromJsonFactory = _$PrescriptionDrugFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrescriptionDrug &&
            (identical(other.drugId, drugId) ||
                const DeepCollectionEquality().equals(other.drugId, drugId)) &&
            (identical(other.drugName, drugName) ||
                const DeepCollectionEquality().equals(
                  other.drugName,
                  drugName,
                )) &&
            (identical(other.usageInstruction, usageInstruction) ||
                const DeepCollectionEquality().equals(
                  other.usageInstruction,
                  usageInstruction,
                )) &&
            (identical(other.formOfDrug, formOfDrug) ||
                const DeepCollectionEquality().equals(
                  other.formOfDrug,
                  formOfDrug,
                )) &&
            (identical(other.drugDosage, drugDosage) ||
                const DeepCollectionEquality().equals(
                  other.drugDosage,
                  drugDosage,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  PrescriptionDrug copyWith({
    int? drugId,
    String? drugName,
    String? usageInstruction,
    String? formOfDrug,
    double? drugDosage,
  }) {
    return PrescriptionDrug(
      drugId: drugId ?? this.drugId,
      drugName: drugName ?? this.drugName,
      usageInstruction: usageInstruction ?? this.usageInstruction,
      formOfDrug: formOfDrug ?? this.formOfDrug,
      drugDosage: drugDosage ?? this.drugDosage,
    );
  }

  PrescriptionDrug copyWithWrapped({
    Wrapped<int>? drugId,
    Wrapped<String>? drugName,
    Wrapped<String?>? usageInstruction,
    Wrapped<String?>? formOfDrug,
    Wrapped<double>? drugDosage,
  }) {
    return PrescriptionDrug(
      drugId: (drugId != null ? drugId.value : this.drugId),
      drugName: (drugName != null ? drugName.value : this.drugName),
      usageInstruction: (usageInstruction != null
          ? usageInstruction.value
          : this.usageInstruction),
      formOfDrug: (formOfDrug != null ? formOfDrug.value : this.formOfDrug),
      drugDosage: (drugDosage != null ? drugDosage.value : this.drugDosage),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionExecution {
  const PrescriptionExecution({this.id, required this.executeAt, this.status});

  factory PrescriptionExecution.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionExecutionFromJson(json);

  static const toJsonFactory = _$PrescriptionExecutionToJson;
  Map<String, dynamic> toJson() => _$PrescriptionExecutionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'execute_at')
  final DateTime executeAt;
  @JsonKey(
    name: 'status',
    toJson: prescriptionExecutionStatusEnumNullableToJson,
    fromJson: prescriptionExecutionStatusEnumNullableFromJson,
  )
  final enums.PrescriptionExecutionStatusEnum? status;
  static const fromJsonFactory = _$PrescriptionExecutionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrescriptionExecution &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.executeAt, executeAt) ||
                const DeepCollectionEquality().equals(
                  other.executeAt,
                  executeAt,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(executeAt) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $PrescriptionExecutionExtension on PrescriptionExecution {
  PrescriptionExecution copyWith({
    int? id,
    DateTime? executeAt,
    enums.PrescriptionExecutionStatusEnum? status,
  }) {
    return PrescriptionExecution(
      id: id ?? this.id,
      executeAt: executeAt ?? this.executeAt,
      status: status ?? this.status,
    );
  }

  PrescriptionExecution copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<DateTime>? executeAt,
    Wrapped<enums.PrescriptionExecutionStatusEnum?>? status,
  }) {
    return PrescriptionExecution(
      id: (id != null ? id.value : this.id),
      executeAt: (executeAt != null ? executeAt.value : this.executeAt),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionExecutionToday {
  const PrescriptionExecutionToday({
    this.id,
    required this.prescription,
    required this.executeAt,
  });

  factory PrescriptionExecutionToday.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionExecutionTodayFromJson(json);

  static const toJsonFactory = _$PrescriptionExecutionTodayToJson;
  Map<String, dynamic> toJson() => _$PrescriptionExecutionTodayToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'prescription')
  final PrescriptionShort prescription;
  @JsonKey(name: 'execute_at')
  final DateTime executeAt;
  static const fromJsonFactory = _$PrescriptionExecutionTodayFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrescriptionExecutionToday &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.prescription, prescription) ||
                const DeepCollectionEquality().equals(
                  other.prescription,
                  prescription,
                )) &&
            (identical(other.executeAt, executeAt) ||
                const DeepCollectionEquality().equals(
                  other.executeAt,
                  executeAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(prescription) ^
      const DeepCollectionEquality().hash(executeAt) ^
      runtimeType.hashCode;
}

extension $PrescriptionExecutionTodayExtension on PrescriptionExecutionToday {
  PrescriptionExecutionToday copyWith({
    int? id,
    PrescriptionShort? prescription,
    DateTime? executeAt,
  }) {
    return PrescriptionExecutionToday(
      id: id ?? this.id,
      prescription: prescription ?? this.prescription,
      executeAt: executeAt ?? this.executeAt,
    );
  }

  PrescriptionExecutionToday copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<PrescriptionShort>? prescription,
    Wrapped<DateTime>? executeAt,
  }) {
    return PrescriptionExecutionToday(
      id: (id != null ? id.value : this.id),
      prescription: (prescription != null
          ? prescription.value
          : this.prescription),
      executeAt: (executeAt != null ? executeAt.value : this.executeAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionFile {
  const PrescriptionFile({
    this.id,
    required this.file,
    this.name,
    this.filename,
    this.createdAt,
  });

  factory PrescriptionFile.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFileFromJson(json);

  static const toJsonFactory = _$PrescriptionFileToJson;
  Map<String, dynamic> toJson() => _$PrescriptionFileToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'file')
  final String file;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'filename')
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$PrescriptionFileFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrescriptionFile &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality().equals(
                  other.filename,
                  filename,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  PrescriptionFile copyWith({
    int? id,
    String? file,
    String? name,
    String? filename,
    DateTime? createdAt,
  }) {
    return PrescriptionFile(
      id: id ?? this.id,
      file: file ?? this.file,
      name: name ?? this.name,
      filename: filename ?? this.filename,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  PrescriptionFile copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? file,
    Wrapped<String?>? name,
    Wrapped<String?>? filename,
    Wrapped<DateTime?>? createdAt,
  }) {
    return PrescriptionFile(
      id: (id != null ? id.value : this.id),
      file: (file != null ? file.value : this.file),
      name: (name != null ? name.value : this.name),
      filename: (filename != null ? filename.value : this.filename),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PrescriptionShort {
  const PrescriptionShort({
    this.id,
    this.myType,
    this.extraTypeAttributes,
    this.description,
    required this.animal,
    required this.drugs,
    this.createdBy,
    this.updatedBy,
    this.files,
  });

  factory PrescriptionShort.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionShortFromJson(json);

  static const toJsonFactory = _$PrescriptionShortToJson;
  Map<String, dynamic> toJson() => _$PrescriptionShortToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(
    name: 'my_type',
    toJson: prescriptionShortMyTypeEnumNullableToJson,
    fromJson: prescriptionShortMyTypeEnumNullableFromJson,
  )
  final enums.PrescriptionShortMyTypeEnum? myType;
  @JsonKey(name: 'extra_type_attributes')
  final dynamic extraTypeAttributes;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'animal')
  final AnimalShort animal;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$PrescriptionShortFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrescriptionShort &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.extraTypeAttributes, extraTypeAttributes) ||
                const DeepCollectionEquality().equals(
                  other.extraTypeAttributes,
                  extraTypeAttributes,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(myType) ^
      const DeepCollectionEquality().hash(extraTypeAttributes) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(animal) ^
      const DeepCollectionEquality().hash(drugs) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(files) ^
      runtimeType.hashCode;
}

extension $PrescriptionShortExtension on PrescriptionShort {
  PrescriptionShort copyWith({
    int? id,
    enums.PrescriptionShortMyTypeEnum? myType,
    dynamic extraTypeAttributes,
    String? description,
    AnimalShort? animal,
    List<PrescriptionDrug>? drugs,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionFile>? files,
  }) {
    return PrescriptionShort(
      id: id ?? this.id,
      myType: myType ?? this.myType,
      extraTypeAttributes: extraTypeAttributes ?? this.extraTypeAttributes,
      description: description ?? this.description,
      animal: animal ?? this.animal,
      drugs: drugs ?? this.drugs,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      files: files ?? this.files,
    );
  }

  PrescriptionShort copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<enums.PrescriptionShortMyTypeEnum?>? myType,
    Wrapped<dynamic>? extraTypeAttributes,
    Wrapped<String?>? description,
    Wrapped<AnimalShort>? animal,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return PrescriptionShort(
      id: (id != null ? id.value : this.id),
      myType: (myType != null ? myType.value : this.myType),
      extraTypeAttributes: (extraTypeAttributes != null
          ? extraTypeAttributes.value
          : this.extraTypeAttributes),
      description: (description != null ? description.value : this.description),
      animal: (animal != null ? animal.value : this.animal),
      drugs: (drugs != null ? drugs.value : this.drugs),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ReadmissionPrescription {
  const ReadmissionPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory ReadmissionPrescription.fromJson(Map<String, dynamic> json) =>
      _$ReadmissionPrescriptionFromJson(json);

  static const toJsonFactory = _$ReadmissionPrescriptionToJson;
  Map<String, dynamic> toJson() => _$ReadmissionPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: readmissionPrescriptionMyTypeEnumToJson,
    fromJson: readmissionPrescriptionMyTypeEnumFromJson,
  )
  final enums.ReadmissionPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$ReadmissionPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ReadmissionPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $ReadmissionPrescriptionExtension on ReadmissionPrescription {
  ReadmissionPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.ReadmissionPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return ReadmissionPrescription(
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
      files: files ?? this.files,
    );
  }

  ReadmissionPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.ReadmissionPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return ReadmissionPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ReleaseSerializers {
  const ReleaseSerializers({
    this.id,
    this.place,
    this.date,
    this.veterinarianName,
    this.veterinarianSurname,
    this.veterinarianPatronymic,
    this.createdAt,
    this.updatedAt,
  });

  factory ReleaseSerializers.fromJson(Map<String, dynamic> json) =>
      _$ReleaseSerializersFromJson(json);

  static const toJsonFactory = _$ReleaseSerializersToJson;
  Map<String, dynamic> toJson() => _$ReleaseSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'place')
  final String? place;
  @JsonKey(name: 'date', toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(name: 'veterinarian_name')
  final String? veterinarianName;
  @JsonKey(name: 'veterinarian_surname')
  final String? veterinarianSurname;
  @JsonKey(name: 'veterinarian_patronymic')
  final String? veterinarianPatronymic;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  static const fromJsonFactory = _$ReleaseSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ReleaseSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.place, place) ||
                const DeepCollectionEquality().equals(other.place, place)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.veterinarianName, veterinarianName) ||
                const DeepCollectionEquality().equals(
                  other.veterinarianName,
                  veterinarianName,
                )) &&
            (identical(other.veterinarianSurname, veterinarianSurname) ||
                const DeepCollectionEquality().equals(
                  other.veterinarianSurname,
                  veterinarianSurname,
                )) &&
            (identical(other.veterinarianPatronymic, veterinarianPatronymic) ||
                const DeepCollectionEquality().equals(
                  other.veterinarianPatronymic,
                  veterinarianPatronymic,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(place) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(veterinarianName) ^
      const DeepCollectionEquality().hash(veterinarianSurname) ^
      const DeepCollectionEquality().hash(veterinarianPatronymic) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $ReleaseSerializersExtension on ReleaseSerializers {
  ReleaseSerializers copyWith({
    int? id,
    String? place,
    DateTime? date,
    String? veterinarianName,
    String? veterinarianSurname,
    String? veterinarianPatronymic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReleaseSerializers(
      id: id ?? this.id,
      place: place ?? this.place,
      date: date ?? this.date,
      veterinarianName: veterinarianName ?? this.veterinarianName,
      veterinarianSurname: veterinarianSurname ?? this.veterinarianSurname,
      veterinarianPatronymic:
          veterinarianPatronymic ?? this.veterinarianPatronymic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ReleaseSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? place,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? veterinarianName,
    Wrapped<String?>? veterinarianSurname,
    Wrapped<String?>? veterinarianPatronymic,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
  }) {
    return ReleaseSerializers(
      id: (id != null ? id.value : this.id),
      place: (place != null ? place.value : this.place),
      date: (date != null ? date.value : this.date),
      veterinarianName: (veterinarianName != null
          ? veterinarianName.value
          : this.veterinarianName),
      veterinarianSurname: (veterinarianSurname != null
          ? veterinarianSurname.value
          : this.veterinarianSurname),
      veterinarianPatronymic: (veterinarianPatronymic != null
          ? veterinarianPatronymic.value
          : this.veterinarianPatronymic),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RemovingStitchesPrescription {
  const RemovingStitchesPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory RemovingStitchesPrescription.fromJson(Map<String, dynamic> json) =>
      _$RemovingStitchesPrescriptionFromJson(json);

  static const toJsonFactory = _$RemovingStitchesPrescriptionToJson;
  Map<String, dynamic> toJson() => _$RemovingStitchesPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: removingStitchesPrescriptionMyTypeEnumToJson,
    fromJson: removingStitchesPrescriptionMyTypeEnumFromJson,
  )
  final enums.RemovingStitchesPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$RemovingStitchesPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RemovingStitchesPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $RemovingStitchesPrescriptionExtension
    on RemovingStitchesPrescription {
  RemovingStitchesPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.RemovingStitchesPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return RemovingStitchesPrescription(
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
      files: files ?? this.files,
    );
  }

  RemovingStitchesPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.RemovingStitchesPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return RemovingStitchesPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ShelterDrug {
  const ShelterDrug({required this.drug, this.drugResiduesCount});

  factory ShelterDrug.fromJson(Map<String, dynamic> json) =>
      _$ShelterDrugFromJson(json);

  static const toJsonFactory = _$ShelterDrugToJson;
  Map<String, dynamic> toJson() => _$ShelterDrugToJson(this);

  @JsonKey(name: 'drug')
  final Drug drug;
  @JsonKey(name: 'drug_residues_count')
  final int? drugResiduesCount;
  static const fromJsonFactory = _$ShelterDrugFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ShelterDrug &&
            (identical(other.drug, drug) ||
                const DeepCollectionEquality().equals(other.drug, drug)) &&
            (identical(other.drugResiduesCount, drugResiduesCount) ||
                const DeepCollectionEquality().equals(
                  other.drugResiduesCount,
                  drugResiduesCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(drug) ^
      const DeepCollectionEquality().hash(drugResiduesCount) ^
      runtimeType.hashCode;
}

extension $ShelterDrugExtension on ShelterDrug {
  ShelterDrug copyWith({Drug? drug, int? drugResiduesCount}) {
    return ShelterDrug(
      drug: drug ?? this.drug,
      drugResiduesCount: drugResiduesCount ?? this.drugResiduesCount,
    );
  }

  ShelterDrug copyWithWrapped({
    Wrapped<Drug>? drug,
    Wrapped<int?>? drugResiduesCount,
  }) {
    return ShelterDrug(
      drug: (drug != null ? drug.value : this.drug),
      drugResiduesCount: (drugResiduesCount != null
          ? drugResiduesCount.value
          : this.drugResiduesCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ShelterSerializers {
  const ShelterSerializers({
    this.id,
    required this.name,
    required this.country,
    required this.city,
    this.state,
    this.region,
    this.street,
    this.house,
    this.apartment,
    this.officialName,
    this.ogrn,
    this.inn,
    this.kpp,
    this.organizationEmail,
    this.phoneNumber,
    this.websiteLink,
    this.positionOfManager,
    this.firstNameOfManager,
    this.lastNameOfManager,
    this.middleNameOfManager,
    this.fullNameOfTheBank,
    this.shortBankName,
    this.fullEnglishBankName,
    this.legalAddressOfTheBank,
    this.postalAddressOfTheBank,
    this.correspondentAccountOfTheBank,
    this.paymentAccountOfTheOrganization,
    this.bicOfTheBank,
  });

  factory ShelterSerializers.fromJson(Map<String, dynamic> json) =>
      _$ShelterSerializersFromJson(json);

  static const toJsonFactory = _$ShelterSerializersToJson;
  Map<String, dynamic> toJson() => _$ShelterSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'country')
  final String country;
  @JsonKey(name: 'city')
  final String city;
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
  @JsonKey(name: 'official_name')
  final String? officialName;
  @JsonKey(name: 'ogrn')
  final String? ogrn;
  @JsonKey(name: 'inn')
  final String? inn;
  @JsonKey(name: 'kpp')
  final String? kpp;
  @JsonKey(name: 'organization_email')
  final String? organizationEmail;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'website_link')
  final String? websiteLink;
  @JsonKey(name: 'position_of_manager')
  final String? positionOfManager;
  @JsonKey(name: 'first_name_of_manager')
  final String? firstNameOfManager;
  @JsonKey(name: 'last_name_of_manager')
  final String? lastNameOfManager;
  @JsonKey(name: 'middle_name_of_manager')
  final String? middleNameOfManager;
  @JsonKey(name: 'full_name_of_the_bank')
  final String? fullNameOfTheBank;
  @JsonKey(name: 'short_bank_name')
  final String? shortBankName;
  @JsonKey(name: 'full_english_bank_name')
  final String? fullEnglishBankName;
  @JsonKey(name: 'legal_address_of_the_bank')
  final String? legalAddressOfTheBank;
  @JsonKey(name: 'postal_address_of_the_bank')
  final String? postalAddressOfTheBank;
  @JsonKey(name: 'correspondent_account_of_the_bank')
  final String? correspondentAccountOfTheBank;
  @JsonKey(name: 'payment_account_of_the_organization')
  final String? paymentAccountOfTheOrganization;
  @JsonKey(name: 'bic_of_the_bank')
  final String? bicOfTheBank;
  static const fromJsonFactory = _$ShelterSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ShelterSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality().equals(
                  other.country,
                  country,
                )) &&
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
                const DeepCollectionEquality().equals(
                  other.apartment,
                  apartment,
                )) &&
            (identical(other.officialName, officialName) ||
                const DeepCollectionEquality().equals(
                  other.officialName,
                  officialName,
                )) &&
            (identical(other.ogrn, ogrn) ||
                const DeepCollectionEquality().equals(other.ogrn, ogrn)) &&
            (identical(other.inn, inn) ||
                const DeepCollectionEquality().equals(other.inn, inn)) &&
            (identical(other.kpp, kpp) ||
                const DeepCollectionEquality().equals(other.kpp, kpp)) &&
            (identical(other.organizationEmail, organizationEmail) ||
                const DeepCollectionEquality().equals(
                  other.organizationEmail,
                  organizationEmail,
                )) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.websiteLink, websiteLink) ||
                const DeepCollectionEquality().equals(
                  other.websiteLink,
                  websiteLink,
                )) &&
            (identical(other.positionOfManager, positionOfManager) ||
                const DeepCollectionEquality().equals(
                  other.positionOfManager,
                  positionOfManager,
                )) &&
            (identical(other.firstNameOfManager, firstNameOfManager) ||
                const DeepCollectionEquality().equals(
                  other.firstNameOfManager,
                  firstNameOfManager,
                )) &&
            (identical(other.lastNameOfManager, lastNameOfManager) ||
                const DeepCollectionEquality().equals(
                  other.lastNameOfManager,
                  lastNameOfManager,
                )) &&
            (identical(other.middleNameOfManager, middleNameOfManager) ||
                const DeepCollectionEquality().equals(
                  other.middleNameOfManager,
                  middleNameOfManager,
                )) &&
            (identical(other.fullNameOfTheBank, fullNameOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.fullNameOfTheBank,
                  fullNameOfTheBank,
                )) &&
            (identical(other.shortBankName, shortBankName) ||
                const DeepCollectionEquality().equals(
                  other.shortBankName,
                  shortBankName,
                )) &&
            (identical(other.fullEnglishBankName, fullEnglishBankName) ||
                const DeepCollectionEquality().equals(
                  other.fullEnglishBankName,
                  fullEnglishBankName,
                )) &&
            (identical(other.legalAddressOfTheBank, legalAddressOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.legalAddressOfTheBank,
                  legalAddressOfTheBank,
                )) &&
            (identical(other.postalAddressOfTheBank, postalAddressOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.postalAddressOfTheBank,
                  postalAddressOfTheBank,
                )) &&
            (identical(
                  other.correspondentAccountOfTheBank,
                  correspondentAccountOfTheBank,
                ) ||
                const DeepCollectionEquality().equals(
                  other.correspondentAccountOfTheBank,
                  correspondentAccountOfTheBank,
                )) &&
            (identical(
                  other.paymentAccountOfTheOrganization,
                  paymentAccountOfTheOrganization,
                ) ||
                const DeepCollectionEquality().equals(
                  other.paymentAccountOfTheOrganization,
                  paymentAccountOfTheOrganization,
                )) &&
            (identical(other.bicOfTheBank, bicOfTheBank) ||
                const DeepCollectionEquality().equals(
                  other.bicOfTheBank,
                  bicOfTheBank,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(region) ^
      const DeepCollectionEquality().hash(street) ^
      const DeepCollectionEquality().hash(house) ^
      const DeepCollectionEquality().hash(apartment) ^
      const DeepCollectionEquality().hash(officialName) ^
      const DeepCollectionEquality().hash(ogrn) ^
      const DeepCollectionEquality().hash(inn) ^
      const DeepCollectionEquality().hash(kpp) ^
      const DeepCollectionEquality().hash(organizationEmail) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(websiteLink) ^
      const DeepCollectionEquality().hash(positionOfManager) ^
      const DeepCollectionEquality().hash(firstNameOfManager) ^
      const DeepCollectionEquality().hash(lastNameOfManager) ^
      const DeepCollectionEquality().hash(middleNameOfManager) ^
      const DeepCollectionEquality().hash(fullNameOfTheBank) ^
      const DeepCollectionEquality().hash(shortBankName) ^
      const DeepCollectionEquality().hash(fullEnglishBankName) ^
      const DeepCollectionEquality().hash(legalAddressOfTheBank) ^
      const DeepCollectionEquality().hash(postalAddressOfTheBank) ^
      const DeepCollectionEquality().hash(correspondentAccountOfTheBank) ^
      const DeepCollectionEquality().hash(paymentAccountOfTheOrganization) ^
      const DeepCollectionEquality().hash(bicOfTheBank) ^
      runtimeType.hashCode;
}

extension $ShelterSerializersExtension on ShelterSerializers {
  ShelterSerializers copyWith({
    int? id,
    String? name,
    String? country,
    String? city,
    String? state,
    String? region,
    String? street,
    String? house,
    String? apartment,
    String? officialName,
    String? ogrn,
    String? inn,
    String? kpp,
    String? organizationEmail,
    String? phoneNumber,
    String? websiteLink,
    String? positionOfManager,
    String? firstNameOfManager,
    String? lastNameOfManager,
    String? middleNameOfManager,
    String? fullNameOfTheBank,
    String? shortBankName,
    String? fullEnglishBankName,
    String? legalAddressOfTheBank,
    String? postalAddressOfTheBank,
    String? correspondentAccountOfTheBank,
    String? paymentAccountOfTheOrganization,
    String? bicOfTheBank,
  }) {
    return ShelterSerializers(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      region: region ?? this.region,
      street: street ?? this.street,
      house: house ?? this.house,
      apartment: apartment ?? this.apartment,
      officialName: officialName ?? this.officialName,
      ogrn: ogrn ?? this.ogrn,
      inn: inn ?? this.inn,
      kpp: kpp ?? this.kpp,
      organizationEmail: organizationEmail ?? this.organizationEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      websiteLink: websiteLink ?? this.websiteLink,
      positionOfManager: positionOfManager ?? this.positionOfManager,
      firstNameOfManager: firstNameOfManager ?? this.firstNameOfManager,
      lastNameOfManager: lastNameOfManager ?? this.lastNameOfManager,
      middleNameOfManager: middleNameOfManager ?? this.middleNameOfManager,
      fullNameOfTheBank: fullNameOfTheBank ?? this.fullNameOfTheBank,
      shortBankName: shortBankName ?? this.shortBankName,
      fullEnglishBankName: fullEnglishBankName ?? this.fullEnglishBankName,
      legalAddressOfTheBank:
          legalAddressOfTheBank ?? this.legalAddressOfTheBank,
      postalAddressOfTheBank:
          postalAddressOfTheBank ?? this.postalAddressOfTheBank,
      correspondentAccountOfTheBank:
          correspondentAccountOfTheBank ?? this.correspondentAccountOfTheBank,
      paymentAccountOfTheOrganization:
          paymentAccountOfTheOrganization ??
          this.paymentAccountOfTheOrganization,
      bicOfTheBank: bicOfTheBank ?? this.bicOfTheBank,
    );
  }

  ShelterSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? name,
    Wrapped<String>? country,
    Wrapped<String>? city,
    Wrapped<String?>? state,
    Wrapped<String?>? region,
    Wrapped<String?>? street,
    Wrapped<String?>? house,
    Wrapped<String?>? apartment,
    Wrapped<String?>? officialName,
    Wrapped<String?>? ogrn,
    Wrapped<String?>? inn,
    Wrapped<String?>? kpp,
    Wrapped<String?>? organizationEmail,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? websiteLink,
    Wrapped<String?>? positionOfManager,
    Wrapped<String?>? firstNameOfManager,
    Wrapped<String?>? lastNameOfManager,
    Wrapped<String?>? middleNameOfManager,
    Wrapped<String?>? fullNameOfTheBank,
    Wrapped<String?>? shortBankName,
    Wrapped<String?>? fullEnglishBankName,
    Wrapped<String?>? legalAddressOfTheBank,
    Wrapped<String?>? postalAddressOfTheBank,
    Wrapped<String?>? correspondentAccountOfTheBank,
    Wrapped<String?>? paymentAccountOfTheOrganization,
    Wrapped<String?>? bicOfTheBank,
  }) {
    return ShelterSerializers(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      country: (country != null ? country.value : this.country),
      city: (city != null ? city.value : this.city),
      state: (state != null ? state.value : this.state),
      region: (region != null ? region.value : this.region),
      street: (street != null ? street.value : this.street),
      house: (house != null ? house.value : this.house),
      apartment: (apartment != null ? apartment.value : this.apartment),
      officialName: (officialName != null
          ? officialName.value
          : this.officialName),
      ogrn: (ogrn != null ? ogrn.value : this.ogrn),
      inn: (inn != null ? inn.value : this.inn),
      kpp: (kpp != null ? kpp.value : this.kpp),
      organizationEmail: (organizationEmail != null
          ? organizationEmail.value
          : this.organizationEmail),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      websiteLink: (websiteLink != null ? websiteLink.value : this.websiteLink),
      positionOfManager: (positionOfManager != null
          ? positionOfManager.value
          : this.positionOfManager),
      firstNameOfManager: (firstNameOfManager != null
          ? firstNameOfManager.value
          : this.firstNameOfManager),
      lastNameOfManager: (lastNameOfManager != null
          ? lastNameOfManager.value
          : this.lastNameOfManager),
      middleNameOfManager: (middleNameOfManager != null
          ? middleNameOfManager.value
          : this.middleNameOfManager),
      fullNameOfTheBank: (fullNameOfTheBank != null
          ? fullNameOfTheBank.value
          : this.fullNameOfTheBank),
      shortBankName: (shortBankName != null
          ? shortBankName.value
          : this.shortBankName),
      fullEnglishBankName: (fullEnglishBankName != null
          ? fullEnglishBankName.value
          : this.fullEnglishBankName),
      legalAddressOfTheBank: (legalAddressOfTheBank != null
          ? legalAddressOfTheBank.value
          : this.legalAddressOfTheBank),
      postalAddressOfTheBank: (postalAddressOfTheBank != null
          ? postalAddressOfTheBank.value
          : this.postalAddressOfTheBank),
      correspondentAccountOfTheBank: (correspondentAccountOfTheBank != null
          ? correspondentAccountOfTheBank.value
          : this.correspondentAccountOfTheBank),
      paymentAccountOfTheOrganization: (paymentAccountOfTheOrganization != null
          ? paymentAccountOfTheOrganization.value
          : this.paymentAccountOfTheOrganization),
      bicOfTheBank: (bicOfTheBank != null
          ? bicOfTheBank.value
          : this.bicOfTheBank),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ShelterShortSerializers {
  const ShelterShortSerializers({this.id, required this.name});

  factory ShelterShortSerializers.fromJson(Map<String, dynamic> json) =>
      _$ShelterShortSerializersFromJson(json);

  static const toJsonFactory = _$ShelterShortSerializersToJson;
  Map<String, dynamic> toJson() => _$ShelterShortSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$ShelterShortSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ShelterShortSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

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

  ShelterShortSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? name,
  }) {
    return ShelterShortSerializers(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Species {
  const Species({
    this.id,
    required this.name,
    required this.level,
    this.parentId,
    this.parentName,
    this.categoryName,
  });

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);

  static const toJsonFactory = _$SpeciesToJson;
  Map<String, dynamic> toJson() => _$SpeciesToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'level', toJson: levelEnumToJson, fromJson: levelEnumFromJson)
  final enums.LevelEnum level;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'parent_name')
  final String? parentName;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  static const fromJsonFactory = _$SpeciesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Species &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)) &&
            (identical(other.parentId, parentId) ||
                const DeepCollectionEquality().equals(
                  other.parentId,
                  parentId,
                )) &&
            (identical(other.parentName, parentName) ||
                const DeepCollectionEquality().equals(
                  other.parentName,
                  parentName,
                )) &&
            (identical(other.categoryName, categoryName) ||
                const DeepCollectionEquality().equals(
                  other.categoryName,
                  categoryName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
  Species copyWith({
    int? id,
    String? name,
    enums.LevelEnum? level,
    int? parentId,
    String? parentName,
    String? categoryName,
  }) {
    return Species(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      parentId: parentId ?? this.parentId,
      parentName: parentName ?? this.parentName,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Species copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? name,
    Wrapped<enums.LevelEnum>? level,
    Wrapped<int?>? parentId,
    Wrapped<String?>? parentName,
    Wrapped<String?>? categoryName,
  }) {
    return Species(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      level: (level != null ? level.value : this.level),
      parentId: (parentId != null ? parentId.value : this.parentId),
      parentName: (parentName != null ? parentName.value : this.parentName),
      categoryName: (categoryName != null
          ? categoryName.value
          : this.categoryName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Status {
  const Status({required this.status});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  static const toJsonFactory = _$StatusToJson;
  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @JsonKey(name: 'status')
  final String status;
  static const fromJsonFactory = _$StatusFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Status &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $StatusExtension on Status {
  Status copyWith({String? status}) {
    return Status(status: status ?? this.status);
  }

  Status copyWithWrapped({Wrapped<String>? status}) {
    return Status(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class StatusTransitionsItem {
  const StatusTransitionsItem({
    required this.statusSequence,
    required this.count,
  });

  factory StatusTransitionsItem.fromJson(Map<String, dynamic> json) =>
      _$StatusTransitionsItemFromJson(json);

  static const toJsonFactory = _$StatusTransitionsItemToJson;
  Map<String, dynamic> toJson() => _$StatusTransitionsItemToJson(this);

  @JsonKey(name: 'status_sequence', defaultValue: <Object>[])
  final List<Object> statusSequence;
  @JsonKey(name: 'count')
  final int count;
  static const fromJsonFactory = _$StatusTransitionsItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StatusTransitionsItem &&
            (identical(other.statusSequence, statusSequence) ||
                const DeepCollectionEquality().equals(
                  other.statusSequence,
                  statusSequence,
                )) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(statusSequence) ^
      const DeepCollectionEquality().hash(count) ^
      runtimeType.hashCode;
}

extension $StatusTransitionsItemExtension on StatusTransitionsItem {
  StatusTransitionsItem copyWith({List<Object>? statusSequence, int? count}) {
    return StatusTransitionsItem(
      statusSequence: statusSequence ?? this.statusSequence,
      count: count ?? this.count,
    );
  }

  StatusTransitionsItem copyWithWrapped({
    Wrapped<List<Object>>? statusSequence,
    Wrapped<int>? count,
  }) {
    return StatusTransitionsItem(
      statusSequence: (statusSequence != null
          ? statusSequence.value
          : this.statusSequence),
      count: (count != null ? count.value : this.count),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenObtainPair {
  const TokenObtainPair({
    this.username,
    this.password,
    this.access,
    this.refresh,
  });

  factory TokenObtainPair.fromJson(Map<String, dynamic> json) =>
      _$TokenObtainPairFromJson(json);

  static const toJsonFactory = _$TokenObtainPairToJson;
  Map<String, dynamic> toJson() => _$TokenObtainPairToJson(this);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'access')
  final String? access;
  @JsonKey(name: 'refresh')
  final String? refresh;
  static const fromJsonFactory = _$TokenObtainPairFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenObtainPair &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      runtimeType.hashCode;
}

extension $TokenObtainPairExtension on TokenObtainPair {
  TokenObtainPair copyWith({
    String? username,
    String? password,
    String? access,
    String? refresh,
  }) {
    return TokenObtainPair(
      username: username ?? this.username,
      password: password ?? this.password,
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  TokenObtainPair copyWithWrapped({
    Wrapped<String?>? username,
    Wrapped<String?>? password,
    Wrapped<String?>? access,
    Wrapped<String?>? refresh,
  }) {
    return TokenObtainPair(
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
      access: (access != null ? access.value : this.access),
      refresh: (refresh != null ? refresh.value : this.refresh),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenRefresh {
  const TokenRefresh({this.access, this.refresh});

  factory TokenRefresh.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshFromJson(json);

  static const toJsonFactory = _$TokenRefreshToJson;
  Map<String, dynamic> toJson() => _$TokenRefreshToJson(this);

  @JsonKey(name: 'access')
  final String? access;
  @JsonKey(name: 'refresh')
  final String? refresh;
  static const fromJsonFactory = _$TokenRefreshFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenRefresh &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      runtimeType.hashCode;
}

extension $TokenRefreshExtension on TokenRefresh {
  TokenRefresh copyWith({String? access, String? refresh}) {
    return TokenRefresh(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  TokenRefresh copyWithWrapped({
    Wrapped<String?>? access,
    Wrapped<String?>? refresh,
  }) {
    return TokenRefresh(
      access: (access != null ? access.value : this.access),
      refresh: (refresh != null ? refresh.value : this.refresh),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserChangePasswordSerializers {
  const UserChangePasswordSerializers({
    this.id,
    this.password,
    this.rePassword,
    this.oldPassword,
  });

  factory UserChangePasswordSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserChangePasswordSerializersFromJson(json);

  static const toJsonFactory = _$UserChangePasswordSerializersToJson;
  Map<String, dynamic> toJson() => _$UserChangePasswordSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'old_password')
  final String? oldPassword;
  static const fromJsonFactory = _$UserChangePasswordSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserChangePasswordSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(
                  other.rePassword,
                  rePassword,
                )) &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality().equals(
                  other.oldPassword,
                  oldPassword,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(rePassword) ^
      const DeepCollectionEquality().hash(oldPassword) ^
      runtimeType.hashCode;
}

extension $UserChangePasswordSerializersExtension
    on UserChangePasswordSerializers {
  UserChangePasswordSerializers copyWith({
    int? id,
    String? password,
    String? rePassword,
    String? oldPassword,
  }) {
    return UserChangePasswordSerializers(
      id: id ?? this.id,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      oldPassword: oldPassword ?? this.oldPassword,
    );
  }

  UserChangePasswordSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? password,
    Wrapped<String?>? rePassword,
    Wrapped<String?>? oldPassword,
  }) {
    return UserChangePasswordSerializers(
      id: (id != null ? id.value : this.id),
      password: (password != null ? password.value : this.password),
      rePassword: (rePassword != null ? rePassword.value : this.rePassword),
      oldPassword: (oldPassword != null ? oldPassword.value : this.oldPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserCurrentShelterSerializers {
  const UserCurrentShelterSerializers({
    required this.currentShelter,
    required this.currentShelterUserRole,
    required this.isUserCanEdit,
    required this.isUserCanDelete,
  });

  factory UserCurrentShelterSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserCurrentShelterSerializersFromJson(json);

  static const toJsonFactory = _$UserCurrentShelterSerializersToJson;
  Map<String, dynamic> toJson() => _$UserCurrentShelterSerializersToJson(this);

  @JsonKey(name: 'current_shelter')
  final int currentShelter;
  @JsonKey(name: 'current_shelter_user_role')
  final String currentShelterUserRole;
  @JsonKey(name: 'is_user_can_edit')
  final bool isUserCanEdit;
  @JsonKey(name: 'is_user_can_delete')
  final bool isUserCanDelete;
  static const fromJsonFactory = _$UserCurrentShelterSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserCurrentShelterSerializers &&
            (identical(other.currentShelter, currentShelter) ||
                const DeepCollectionEquality().equals(
                  other.currentShelter,
                  currentShelter,
                )) &&
            (identical(other.currentShelterUserRole, currentShelterUserRole) ||
                const DeepCollectionEquality().equals(
                  other.currentShelterUserRole,
                  currentShelterUserRole,
                )) &&
            (identical(other.isUserCanEdit, isUserCanEdit) ||
                const DeepCollectionEquality().equals(
                  other.isUserCanEdit,
                  isUserCanEdit,
                )) &&
            (identical(other.isUserCanDelete, isUserCanDelete) ||
                const DeepCollectionEquality().equals(
                  other.isUserCanDelete,
                  isUserCanDelete,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(currentShelter) ^
      const DeepCollectionEquality().hash(currentShelterUserRole) ^
      const DeepCollectionEquality().hash(isUserCanEdit) ^
      const DeepCollectionEquality().hash(isUserCanDelete) ^
      runtimeType.hashCode;
}

extension $UserCurrentShelterSerializersExtension
    on UserCurrentShelterSerializers {
  UserCurrentShelterSerializers copyWith({
    int? currentShelter,
    String? currentShelterUserRole,
    bool? isUserCanEdit,
    bool? isUserCanDelete,
  }) {
    return UserCurrentShelterSerializers(
      currentShelter: currentShelter ?? this.currentShelter,
      currentShelterUserRole:
          currentShelterUserRole ?? this.currentShelterUserRole,
      isUserCanEdit: isUserCanEdit ?? this.isUserCanEdit,
      isUserCanDelete: isUserCanDelete ?? this.isUserCanDelete,
    );
  }

  UserCurrentShelterSerializers copyWithWrapped({
    Wrapped<int>? currentShelter,
    Wrapped<String>? currentShelterUserRole,
    Wrapped<bool>? isUserCanEdit,
    Wrapped<bool>? isUserCanDelete,
  }) {
    return UserCurrentShelterSerializers(
      currentShelter: (currentShelter != null
          ? currentShelter.value
          : this.currentShelter),
      currentShelterUserRole: (currentShelterUserRole != null
          ? currentShelterUserRole.value
          : this.currentShelterUserRole),
      isUserCanEdit: (isUserCanEdit != null
          ? isUserCanEdit.value
          : this.isUserCanEdit),
      isUserCanDelete: (isUserCanDelete != null
          ? isUserCanDelete.value
          : this.isUserCanDelete),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserResetPasswordComplete {
  const UserResetPasswordComplete({
    required this.uidb64,
    required this.token,
    this.newPassword,
  });

  factory UserResetPasswordComplete.fromJson(Map<String, dynamic> json) =>
      _$UserResetPasswordCompleteFromJson(json);

  static const toJsonFactory = _$UserResetPasswordCompleteToJson;
  Map<String, dynamic> toJson() => _$UserResetPasswordCompleteToJson(this);

  @JsonKey(name: 'uidb64')
  final String uidb64;
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'new_password')
  final String? newPassword;
  static const fromJsonFactory = _$UserResetPasswordCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserResetPasswordComplete &&
            (identical(other.uidb64, uidb64) ||
                const DeepCollectionEquality().equals(other.uidb64, uidb64)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality().equals(
                  other.newPassword,
                  newPassword,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uidb64) ^
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $UserResetPasswordCompleteExtension on UserResetPasswordComplete {
  UserResetPasswordComplete copyWith({
    String? uidb64,
    String? token,
    String? newPassword,
  }) {
    return UserResetPasswordComplete(
      uidb64: uidb64 ?? this.uidb64,
      token: token ?? this.token,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  UserResetPasswordComplete copyWithWrapped({
    Wrapped<String>? uidb64,
    Wrapped<String>? token,
    Wrapped<String?>? newPassword,
  }) {
    return UserResetPasswordComplete(
      uidb64: (uidb64 != null ? uidb64.value : this.uidb64),
      token: (token != null ? token.value : this.token),
      newPassword: (newPassword != null ? newPassword.value : this.newPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserSerializers {
  const UserSerializers({
    this.id,
    this.username,
    required this.firstName,
    required this.lastName,
    this.fathersName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.dateJoined,
    this.isVerified,
    this.isOfferSigned,
  });

  factory UserSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserSerializersFromJson(json);

  static const toJsonFactory = _$UserSerializersToJson;
  Map<String, dynamic> toJson() => _$UserSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
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
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;
  static const fromJsonFactory = _$UserSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(
                  other.fathersName,
                  fathersName,
                )) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(
                  other.fullName,
                  fullName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.dateJoined, dateJoined) ||
                const DeepCollectionEquality().equals(
                  other.dateJoined,
                  dateJoined,
                )) &&
            (identical(other.isVerified, isVerified) ||
                const DeepCollectionEquality().equals(
                  other.isVerified,
                  isVerified,
                )) &&
            (identical(other.isOfferSigned, isOfferSigned) ||
                const DeepCollectionEquality().equals(
                  other.isOfferSigned,
                  isOfferSigned,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
      const DeepCollectionEquality().hash(isOfferSigned) ^
      runtimeType.hashCode;
}

extension $UserSerializersExtension on UserSerializers {
  UserSerializers copyWith({
    int? id,
    String? username,
    String? firstName,
    String? lastName,
    String? fathersName,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? address,
    DateTime? dateJoined,
    bool? isVerified,
    bool? isOfferSigned,
  }) {
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
      isVerified: isVerified ?? this.isVerified,
      isOfferSigned: isOfferSigned ?? this.isOfferSigned,
    );
  }

  UserSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? username,
    Wrapped<String>? firstName,
    Wrapped<String>? lastName,
    Wrapped<String?>? fathersName,
    Wrapped<String?>? fullName,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<DateTime?>? dateJoined,
    Wrapped<bool?>? isVerified,
    Wrapped<bool?>? isOfferSigned,
  }) {
    return UserSerializers(
      id: (id != null ? id.value : this.id),
      username: (username != null ? username.value : this.username),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      fathersName: (fathersName != null ? fathersName.value : this.fathersName),
      fullName: (fullName != null ? fullName.value : this.fullName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      dateJoined: (dateJoined != null ? dateJoined.value : this.dateJoined),
      isVerified: (isVerified != null ? isVerified.value : this.isVerified),
      isOfferSigned: (isOfferSigned != null
          ? isOfferSigned.value
          : this.isOfferSigned),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserShelterAdminSerializers {
  const UserShelterAdminSerializers({
    this.id,
    required this.firstName,
    required this.lastName,
    this.fathersName,
    required this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.rePassword,
    required this.isOfferSigned,
    this.shelter,
  });

  factory UserShelterAdminSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserShelterAdminSerializersFromJson(json);

  static const toJsonFactory = _$UserShelterAdminSerializersToJson;
  Map<String, dynamic> toJson() => _$UserShelterAdminSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 're_password')
  final String? rePassword;
  @JsonKey(name: 'is_offer_signed')
  final bool isOfferSigned;
  @JsonKey(name: 'shelter')
  final ShelterSerializers? shelter;
  static const fromJsonFactory = _$UserShelterAdminSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserShelterAdminSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(
                  other.fathersName,
                  fathersName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(
                  other.rePassword,
                  rePassword,
                )) &&
            (identical(other.isOfferSigned, isOfferSigned) ||
                const DeepCollectionEquality().equals(
                  other.isOfferSigned,
                  isOfferSigned,
                )) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(other.shelter, shelter)));
  }

  @override
  String toString() => jsonEncode(this);

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
      const DeepCollectionEquality().hash(isOfferSigned) ^
      const DeepCollectionEquality().hash(shelter) ^
      runtimeType.hashCode;
}

extension $UserShelterAdminSerializersExtension on UserShelterAdminSerializers {
  UserShelterAdminSerializers copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? fathersName,
    String? email,
    String? phoneNumber,
    String? address,
    String? password,
    String? rePassword,
    bool? isOfferSigned,
    ShelterSerializers? shelter,
  }) {
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
      isOfferSigned: isOfferSigned ?? this.isOfferSigned,
      shelter: shelter ?? this.shelter,
    );
  }

  UserShelterAdminSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? firstName,
    Wrapped<String>? lastName,
    Wrapped<String?>? fathersName,
    Wrapped<String>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? password,
    Wrapped<String?>? rePassword,
    Wrapped<bool>? isOfferSigned,
    Wrapped<ShelterSerializers?>? shelter,
  }) {
    return UserShelterAdminSerializers(
      id: (id != null ? id.value : this.id),
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      fathersName: (fathersName != null ? fathersName.value : this.fathersName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      password: (password != null ? password.value : this.password),
      rePassword: (rePassword != null ? rePassword.value : this.rePassword),
      isOfferSigned: (isOfferSigned != null
          ? isOfferSigned.value
          : this.isOfferSigned),
      shelter: (shelter != null ? shelter.value : this.shelter),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserShelterWorkerSerializers {
  const UserShelterWorkerSerializers({
    required this.firstName,
    required this.lastName,
    this.fathersName,
    required this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.rePassword,
    this.shelter,
    this.role,
    required this.isOfferSigned,
  });

  factory UserShelterWorkerSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserShelterWorkerSerializersFromJson(json);

  static const toJsonFactory = _$UserShelterWorkerSerializersToJson;
  Map<String, dynamic> toJson() => _$UserShelterWorkerSerializersToJson(this);

  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'email')
  final String email;
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
  @JsonKey(
    name: 'role',
    toJson: roleEnumNullableToJson,
    fromJson: roleEnumNullableFromJson,
  )
  final enums.RoleEnum? role;
  @JsonKey(name: 'is_offer_signed')
  final bool isOfferSigned;
  static const fromJsonFactory = _$UserShelterWorkerSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserShelterWorkerSerializers &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality().equals(
                  other.firstName,
                  firstName,
                )) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality().equals(
                  other.lastName,
                  lastName,
                )) &&
            (identical(other.fathersName, fathersName) ||
                const DeepCollectionEquality().equals(
                  other.fathersName,
                  fathersName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.rePassword, rePassword) ||
                const DeepCollectionEquality().equals(
                  other.rePassword,
                  rePassword,
                )) &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.isOfferSigned, isOfferSigned) ||
                const DeepCollectionEquality().equals(
                  other.isOfferSigned,
                  isOfferSigned,
                )));
  }

  @override
  String toString() => jsonEncode(this);

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
      const DeepCollectionEquality().hash(isOfferSigned) ^
      runtimeType.hashCode;
}

extension $UserShelterWorkerSerializersExtension
    on UserShelterWorkerSerializers {
  UserShelterWorkerSerializers copyWith({
    String? firstName,
    String? lastName,
    String? fathersName,
    String? email,
    String? phoneNumber,
    String? address,
    String? password,
    String? rePassword,
    int? shelter,
    enums.RoleEnum? role,
    bool? isOfferSigned,
  }) {
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
      role: role ?? this.role,
      isOfferSigned: isOfferSigned ?? this.isOfferSigned,
    );
  }

  UserShelterWorkerSerializers copyWithWrapped({
    Wrapped<String>? firstName,
    Wrapped<String>? lastName,
    Wrapped<String?>? fathersName,
    Wrapped<String>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
    Wrapped<String?>? password,
    Wrapped<String?>? rePassword,
    Wrapped<int?>? shelter,
    Wrapped<enums.RoleEnum?>? role,
    Wrapped<bool>? isOfferSigned,
  }) {
    return UserShelterWorkerSerializers(
      firstName: (firstName != null ? firstName.value : this.firstName),
      lastName: (lastName != null ? lastName.value : this.lastName),
      fathersName: (fathersName != null ? fathersName.value : this.fathersName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
      password: (password != null ? password.value : this.password),
      rePassword: (rePassword != null ? rePassword.value : this.rePassword),
      shelter: (shelter != null ? shelter.value : this.shelter),
      role: (role != null ? role.value : this.role),
      isOfferSigned: (isOfferSigned != null
          ? isOfferSigned.value
          : this.isOfferSigned),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserSheltersAdminSerializers {
  const UserSheltersAdminSerializers({
    this.id,
    this.user,
    this.userId,
    required this.role,
    this.isVerifiedByAdmin,
  });

  factory UserSheltersAdminSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserSheltersAdminSerializersFromJson(json);

  static const toJsonFactory = _$UserSheltersAdminSerializersToJson;
  Map<String, dynamic> toJson() => _$UserSheltersAdminSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'user')
  final UserSerializers? user;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'role', toJson: roleEnumToJson, fromJson: roleEnumFromJson)
  final enums.RoleEnum role;
  @JsonKey(name: 'is_verified_by_admin')
  final bool? isVerifiedByAdmin;
  static const fromJsonFactory = _$UserSheltersAdminSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSheltersAdminSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.isVerifiedByAdmin, isVerifiedByAdmin) ||
                const DeepCollectionEquality().equals(
                  other.isVerifiedByAdmin,
                  isVerifiedByAdmin,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(isVerifiedByAdmin) ^
      runtimeType.hashCode;
}

extension $UserSheltersAdminSerializersExtension
    on UserSheltersAdminSerializers {
  UserSheltersAdminSerializers copyWith({
    int? id,
    UserSerializers? user,
    int? userId,
    enums.RoleEnum? role,
    bool? isVerifiedByAdmin,
  }) {
    return UserSheltersAdminSerializers(
      id: id ?? this.id,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      isVerifiedByAdmin: isVerifiedByAdmin ?? this.isVerifiedByAdmin,
    );
  }

  UserSheltersAdminSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<UserSerializers?>? user,
    Wrapped<int?>? userId,
    Wrapped<enums.RoleEnum>? role,
    Wrapped<bool?>? isVerifiedByAdmin,
  }) {
    return UserSheltersAdminSerializers(
      id: (id != null ? id.value : this.id),
      user: (user != null ? user.value : this.user),
      userId: (userId != null ? userId.value : this.userId),
      role: (role != null ? role.value : this.role),
      isVerifiedByAdmin: (isVerifiedByAdmin != null
          ? isVerifiedByAdmin.value
          : this.isVerifiedByAdmin),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserSheltersWorkerSerializers {
  const UserSheltersWorkerSerializers({this.shelter, required this.role});

  factory UserSheltersWorkerSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserSheltersWorkerSerializersFromJson(json);

  static const toJsonFactory = _$UserSheltersWorkerSerializersToJson;
  Map<String, dynamic> toJson() => _$UserSheltersWorkerSerializersToJson(this);

  @JsonKey(name: 'shelter')
  final int? shelter;
  @JsonKey(name: 'role', toJson: roleEnumToJson, fromJson: roleEnumFromJson)
  final enums.RoleEnum role;
  static const fromJsonFactory = _$UserSheltersWorkerSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSheltersWorkerSerializers &&
            (identical(other.shelter, shelter) ||
                const DeepCollectionEquality().equals(
                  other.shelter,
                  shelter,
                )) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(shelter) ^
      const DeepCollectionEquality().hash(role) ^
      runtimeType.hashCode;
}

extension $UserSheltersWorkerSerializersExtension
    on UserSheltersWorkerSerializers {
  UserSheltersWorkerSerializers copyWith({int? shelter, enums.RoleEnum? role}) {
    return UserSheltersWorkerSerializers(
      shelter: shelter ?? this.shelter,
      role: role ?? this.role,
    );
  }

  UserSheltersWorkerSerializers copyWithWrapped({
    Wrapped<int?>? shelter,
    Wrapped<enums.RoleEnum>? role,
  }) {
    return UserSheltersWorkerSerializers(
      shelter: (shelter != null ? shelter.value : this.shelter),
      role: (role != null ? role.value : this.role),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserShortSerializers {
  const UserShortSerializers({
    this.id,
    this.fullName,
    required this.email,
    this.phoneNumber,
    this.address,
  });

  factory UserShortSerializers.fromJson(Map<String, dynamic> json) =>
      _$UserShortSerializersFromJson(json);

  static const toJsonFactory = _$UserShortSerializersToJson;
  Map<String, dynamic> toJson() => _$UserShortSerializersToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'address')
  final String? address;
  static const fromJsonFactory = _$UserShortSerializersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserShortSerializers &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality().equals(
                  other.fullName,
                  fullName,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumber,
                  phoneNumber,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  String toString() => jsonEncode(this);

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
  UserShortSerializers copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? address,
  }) {
    return UserShortSerializers(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  UserShortSerializers copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? fullName,
    Wrapped<String>? email,
    Wrapped<String?>? phoneNumber,
    Wrapped<String?>? address,
  }) {
    return UserShortSerializers(
      id: (id != null ? id.value : this.id),
      fullName: (fullName != null ? fullName.value : this.fullName),
      email: (email != null ? email.value : this.email),
      phoneNumber: (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
      address: (address != null ? address.value : this.address),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VaccinationPrescription {
  const VaccinationPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory VaccinationPrescription.fromJson(Map<String, dynamic> json) =>
      _$VaccinationPrescriptionFromJson(json);

  static const toJsonFactory = _$VaccinationPrescriptionToJson;
  Map<String, dynamic> toJson() => _$VaccinationPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: vaccinationPrescriptionMyTypeEnumToJson,
    fromJson: vaccinationPrescriptionMyTypeEnumFromJson,
  )
  final enums.VaccinationPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$VaccinationPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VaccinationPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $VaccinationPrescriptionExtension on VaccinationPrescription {
  VaccinationPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.VaccinationPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return VaccinationPrescription(
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
      files: files ?? this.files,
    );
  }

  VaccinationPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.VaccinationPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return VaccinationPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ValuesForSelection {
  const ValuesForSelection({required this.choicesName});

  factory ValuesForSelection.fromJson(Map<String, dynamic> json) =>
      _$ValuesForSelectionFromJson(json);

  static const toJsonFactory = _$ValuesForSelectionToJson;
  Map<String, dynamic> toJson() => _$ValuesForSelectionToJson(this);

  @JsonKey(name: 'choices_name', defaultValue: <ValuesForSelectionItem>[])
  final List<ValuesForSelectionItem> choicesName;
  static const fromJsonFactory = _$ValuesForSelectionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ValuesForSelection &&
            (identical(other.choicesName, choicesName) ||
                const DeepCollectionEquality().equals(
                  other.choicesName,
                  choicesName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(choicesName) ^ runtimeType.hashCode;
}

extension $ValuesForSelectionExtension on ValuesForSelection {
  ValuesForSelection copyWith({List<ValuesForSelectionItem>? choicesName}) {
    return ValuesForSelection(choicesName: choicesName ?? this.choicesName);
  }

  ValuesForSelection copyWithWrapped({
    Wrapped<List<ValuesForSelectionItem>>? choicesName,
  }) {
    return ValuesForSelection(
      choicesName: (choicesName != null ? choicesName.value : this.choicesName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ValuesForSelectionItem {
  const ValuesForSelectionItem({
    required this.displayName,
    required this.value,
  });

  factory ValuesForSelectionItem.fromJson(Map<String, dynamic> json) =>
      _$ValuesForSelectionItemFromJson(json);

  static const toJsonFactory = _$ValuesForSelectionItemToJson;
  Map<String, dynamic> toJson() => _$ValuesForSelectionItemToJson(this);

  @JsonKey(name: 'display_name')
  final String displayName;
  @JsonKey(name: 'value')
  final String value;
  static const fromJsonFactory = _$ValuesForSelectionItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ValuesForSelectionItem &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality().equals(
                  other.displayName,
                  displayName,
                )) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(value) ^
      runtimeType.hashCode;
}

extension $ValuesForSelectionItemExtension on ValuesForSelectionItem {
  ValuesForSelectionItem copyWith({String? displayName, String? value}) {
    return ValuesForSelectionItem(
      displayName: displayName ?? this.displayName,
      value: value ?? this.value,
    );
  }

  ValuesForSelectionItem copyWithWrapped({
    Wrapped<String>? displayName,
    Wrapped<String>? value,
  }) {
    return ValuesForSelectionItem(
      displayName: (displayName != null ? displayName.value : this.displayName),
      value: (value != null ? value.value : this.value),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WoundHealingPrescription {
  const WoundHealingPrescription({
    this.id,
    this.url,
    required this.animal,
    required this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    required this.drugs,
    required this.executions,
    this.files,
  });

  factory WoundHealingPrescription.fromJson(Map<String, dynamic> json) =>
      _$WoundHealingPrescriptionFromJson(json);

  static const toJsonFactory = _$WoundHealingPrescriptionToJson;
  Map<String, dynamic> toJson() => _$WoundHealingPrescriptionToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'animal')
  final int animal;
  @JsonKey(
    name: 'my_type',
    toJson: woundHealingPrescriptionMyTypeEnumToJson,
    fromJson: woundHealingPrescriptionMyTypeEnumFromJson,
  )
  final enums.WoundHealingPrescriptionMyTypeEnum myType;
  @JsonKey(
    name: 'duration',
    toJson: durationEnumNullableToJson,
    fromJson: durationEnumNullableFromJson,
  )
  final enums.DurationEnum? duration;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'drugs', defaultValue: <PrescriptionDrug>[])
  final List<PrescriptionDrug> drugs;
  @JsonKey(name: 'executions', defaultValue: <PrescriptionExecution>[])
  final List<PrescriptionExecution> executions;
  @JsonKey(name: 'files', defaultValue: <PrescriptionFile>[])
  final List<PrescriptionFile>? files;
  static const fromJsonFactory = _$WoundHealingPrescriptionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WoundHealingPrescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.animal, animal) ||
                const DeepCollectionEquality().equals(other.animal, animal)) &&
            (identical(other.myType, myType) ||
                const DeepCollectionEquality().equals(other.myType, myType)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality().equals(
                  other.updatedBy,
                  updatedBy,
                )) &&
            (identical(other.drugs, drugs) ||
                const DeepCollectionEquality().equals(other.drugs, drugs)) &&
            (identical(other.executions, executions) ||
                const DeepCollectionEquality().equals(
                  other.executions,
                  executions,
                )) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  String toString() => jsonEncode(this);

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

extension $WoundHealingPrescriptionExtension on WoundHealingPrescription {
  WoundHealingPrescription copyWith({
    int? id,
    String? url,
    int? animal,
    enums.WoundHealingPrescriptionMyTypeEnum? myType,
    enums.DurationEnum? duration,
    String? description,
    String? createdBy,
    String? updatedBy,
    List<PrescriptionDrug>? drugs,
    List<PrescriptionExecution>? executions,
    List<PrescriptionFile>? files,
  }) {
    return WoundHealingPrescription(
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
      files: files ?? this.files,
    );
  }

  WoundHealingPrescription copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? url,
    Wrapped<int>? animal,
    Wrapped<enums.WoundHealingPrescriptionMyTypeEnum>? myType,
    Wrapped<enums.DurationEnum?>? duration,
    Wrapped<String?>? description,
    Wrapped<String?>? createdBy,
    Wrapped<String?>? updatedBy,
    Wrapped<List<PrescriptionDrug>>? drugs,
    Wrapped<List<PrescriptionExecution>>? executions,
    Wrapped<List<PrescriptionFile>?>? files,
  }) {
    return WoundHealingPrescription(
      id: (id != null ? id.value : this.id),
      url: (url != null ? url.value : this.url),
      animal: (animal != null ? animal.value : this.animal),
      myType: (myType != null ? myType.value : this.myType),
      duration: (duration != null ? duration.value : this.duration),
      description: (description != null ? description.value : this.description),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
      drugs: (drugs != null ? drugs.value : this.drugs),
      executions: (executions != null ? executions.value : this.executions),
      files: (files != null ? files.value : this.files),
    );
  }
}

String? analysisPrescriptionMyTypeEnumNullableToJson(
  enums.AnalysisPrescriptionMyTypeEnum? analysisPrescriptionMyTypeEnum,
) {
  return analysisPrescriptionMyTypeEnum?.value;
}

String? analysisPrescriptionMyTypeEnumToJson(
  enums.AnalysisPrescriptionMyTypeEnum analysisPrescriptionMyTypeEnum,
) {
  return analysisPrescriptionMyTypeEnum.value;
}

enums.AnalysisPrescriptionMyTypeEnum analysisPrescriptionMyTypeEnumFromJson(
  Object? analysisPrescriptionMyTypeEnum, [
  enums.AnalysisPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.AnalysisPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == analysisPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.AnalysisPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.AnalysisPrescriptionMyTypeEnum?
analysisPrescriptionMyTypeEnumNullableFromJson(
  Object? analysisPrescriptionMyTypeEnum, [
  enums.AnalysisPrescriptionMyTypeEnum? defaultValue,
]) {
  if (analysisPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.AnalysisPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == analysisPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String analysisPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.AnalysisPrescriptionMyTypeEnum>? analysisPrescriptionMyTypeEnum,
) {
  return analysisPrescriptionMyTypeEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> analysisPrescriptionMyTypeEnumListToJson(
  List<enums.AnalysisPrescriptionMyTypeEnum>? analysisPrescriptionMyTypeEnum,
) {
  if (analysisPrescriptionMyTypeEnum == null) {
    return [];
  }

  return analysisPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.AnalysisPrescriptionMyTypeEnum>
analysisPrescriptionMyTypeEnumListFromJson(
  List? analysisPrescriptionMyTypeEnum, [
  List<enums.AnalysisPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (analysisPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return analysisPrescriptionMyTypeEnum
      .map((e) => analysisPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.AnalysisPrescriptionMyTypeEnum>?
analysisPrescriptionMyTypeEnumNullableListFromJson(
  List? analysisPrescriptionMyTypeEnum, [
  List<enums.AnalysisPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (analysisPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return analysisPrescriptionMyTypeEnum
      .map((e) => analysisPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? appointmentPrescriptionMyTypeEnumNullableToJson(
  enums.AppointmentPrescriptionMyTypeEnum? appointmentPrescriptionMyTypeEnum,
) {
  return appointmentPrescriptionMyTypeEnum?.value;
}

String? appointmentPrescriptionMyTypeEnumToJson(
  enums.AppointmentPrescriptionMyTypeEnum appointmentPrescriptionMyTypeEnum,
) {
  return appointmentPrescriptionMyTypeEnum.value;
}

enums.AppointmentPrescriptionMyTypeEnum
appointmentPrescriptionMyTypeEnumFromJson(
  Object? appointmentPrescriptionMyTypeEnum, [
  enums.AppointmentPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.AppointmentPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == appointmentPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.AppointmentPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.AppointmentPrescriptionMyTypeEnum?
appointmentPrescriptionMyTypeEnumNullableFromJson(
  Object? appointmentPrescriptionMyTypeEnum, [
  enums.AppointmentPrescriptionMyTypeEnum? defaultValue,
]) {
  if (appointmentPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.AppointmentPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == appointmentPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String appointmentPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.AppointmentPrescriptionMyTypeEnum>?
  appointmentPrescriptionMyTypeEnum,
) {
  return appointmentPrescriptionMyTypeEnum?.map((e) => e.value!).join(',') ??
      '';
}

List<String> appointmentPrescriptionMyTypeEnumListToJson(
  List<enums.AppointmentPrescriptionMyTypeEnum>?
  appointmentPrescriptionMyTypeEnum,
) {
  if (appointmentPrescriptionMyTypeEnum == null) {
    return [];
  }

  return appointmentPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.AppointmentPrescriptionMyTypeEnum>
appointmentPrescriptionMyTypeEnumListFromJson(
  List? appointmentPrescriptionMyTypeEnum, [
  List<enums.AppointmentPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (appointmentPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return appointmentPrescriptionMyTypeEnum
      .map((e) => appointmentPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.AppointmentPrescriptionMyTypeEnum>?
appointmentPrescriptionMyTypeEnumNullableListFromJson(
  List? appointmentPrescriptionMyTypeEnum, [
  List<enums.AppointmentPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (appointmentPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return appointmentPrescriptionMyTypeEnum
      .map((e) => appointmentPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? courseOfTreatmentPrescriptionMyTypeEnumNullableToJson(
  enums.CourseOfTreatmentPrescriptionMyTypeEnum?
  courseOfTreatmentPrescriptionMyTypeEnum,
) {
  return courseOfTreatmentPrescriptionMyTypeEnum?.value;
}

String? courseOfTreatmentPrescriptionMyTypeEnumToJson(
  enums.CourseOfTreatmentPrescriptionMyTypeEnum
  courseOfTreatmentPrescriptionMyTypeEnum,
) {
  return courseOfTreatmentPrescriptionMyTypeEnum.value;
}

enums.CourseOfTreatmentPrescriptionMyTypeEnum
courseOfTreatmentPrescriptionMyTypeEnumFromJson(
  Object? courseOfTreatmentPrescriptionMyTypeEnum, [
  enums.CourseOfTreatmentPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.CourseOfTreatmentPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == courseOfTreatmentPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.CourseOfTreatmentPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.CourseOfTreatmentPrescriptionMyTypeEnum?
courseOfTreatmentPrescriptionMyTypeEnumNullableFromJson(
  Object? courseOfTreatmentPrescriptionMyTypeEnum, [
  enums.CourseOfTreatmentPrescriptionMyTypeEnum? defaultValue,
]) {
  if (courseOfTreatmentPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.CourseOfTreatmentPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == courseOfTreatmentPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String courseOfTreatmentPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.CourseOfTreatmentPrescriptionMyTypeEnum>?
  courseOfTreatmentPrescriptionMyTypeEnum,
) {
  return courseOfTreatmentPrescriptionMyTypeEnum
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> courseOfTreatmentPrescriptionMyTypeEnumListToJson(
  List<enums.CourseOfTreatmentPrescriptionMyTypeEnum>?
  courseOfTreatmentPrescriptionMyTypeEnum,
) {
  if (courseOfTreatmentPrescriptionMyTypeEnum == null) {
    return [];
  }

  return courseOfTreatmentPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.CourseOfTreatmentPrescriptionMyTypeEnum>
courseOfTreatmentPrescriptionMyTypeEnumListFromJson(
  List? courseOfTreatmentPrescriptionMyTypeEnum, [
  List<enums.CourseOfTreatmentPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (courseOfTreatmentPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return courseOfTreatmentPrescriptionMyTypeEnum
      .map((e) => courseOfTreatmentPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.CourseOfTreatmentPrescriptionMyTypeEnum>?
courseOfTreatmentPrescriptionMyTypeEnumNullableListFromJson(
  List? courseOfTreatmentPrescriptionMyTypeEnum, [
  List<enums.CourseOfTreatmentPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (courseOfTreatmentPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return courseOfTreatmentPrescriptionMyTypeEnum
      .map((e) => courseOfTreatmentPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? durationEnumNullableToJson(enums.DurationEnum? durationEnum) {
  return durationEnum?.value;
}

String? durationEnumToJson(enums.DurationEnum durationEnum) {
  return durationEnum.value;
}

enums.DurationEnum durationEnumFromJson(
  Object? durationEnum, [
  enums.DurationEnum? defaultValue,
]) {
  return enums.DurationEnum.values.firstWhereOrNull(
        (e) => e.value == durationEnum,
      ) ??
      defaultValue ??
      enums.DurationEnum.swaggerGeneratedUnknown;
}

enums.DurationEnum? durationEnumNullableFromJson(
  Object? durationEnum, [
  enums.DurationEnum? defaultValue,
]) {
  if (durationEnum == null) {
    return null;
  }
  return enums.DurationEnum.values.firstWhereOrNull(
        (e) => e.value == durationEnum,
      ) ??
      defaultValue;
}

String durationEnumExplodedListToJson(List<enums.DurationEnum>? durationEnum) {
  return durationEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> durationEnumListToJson(List<enums.DurationEnum>? durationEnum) {
  if (durationEnum == null) {
    return [];
  }

  return durationEnum.map((e) => e.value!).toList();
}

List<enums.DurationEnum> durationEnumListFromJson(
  List? durationEnum, [
  List<enums.DurationEnum>? defaultValue,
]) {
  if (durationEnum == null) {
    return defaultValue ?? [];
  }

  return durationEnum.map((e) => durationEnumFromJson(e.toString())).toList();
}

List<enums.DurationEnum>? durationEnumNullableListFromJson(
  List? durationEnum, [
  List<enums.DurationEnum>? defaultValue,
]) {
  if (durationEnum == null) {
    return defaultValue;
  }

  return durationEnum.map((e) => durationEnumFromJson(e.toString())).toList();
}

int? levelEnumNullableToJson(enums.LevelEnum? levelEnum) {
  return levelEnum?.value;
}

int? levelEnumToJson(enums.LevelEnum levelEnum) {
  return levelEnum.value;
}

enums.LevelEnum levelEnumFromJson(
  Object? levelEnum, [
  enums.LevelEnum? defaultValue,
]) {
  return enums.LevelEnum.values.firstWhereOrNull((e) => e.value == levelEnum) ??
      defaultValue ??
      enums.LevelEnum.swaggerGeneratedUnknown;
}

enums.LevelEnum? levelEnumNullableFromJson(
  Object? levelEnum, [
  enums.LevelEnum? defaultValue,
]) {
  if (levelEnum == null) {
    return null;
  }
  return enums.LevelEnum.values.firstWhereOrNull((e) => e.value == levelEnum) ??
      defaultValue;
}

String levelEnumExplodedListToJson(List<enums.LevelEnum>? levelEnum) {
  return levelEnum?.map((e) => e.value!).join(',') ?? '';
}

List<int> levelEnumListToJson(List<enums.LevelEnum>? levelEnum) {
  if (levelEnum == null) {
    return [];
  }

  return levelEnum.map((e) => e.value!).toList();
}

List<enums.LevelEnum> levelEnumListFromJson(
  List? levelEnum, [
  List<enums.LevelEnum>? defaultValue,
]) {
  if (levelEnum == null) {
    return defaultValue ?? [];
  }

  return levelEnum.map((e) => levelEnumFromJson(e)).toList();
}

List<enums.LevelEnum>? levelEnumNullableListFromJson(
  List? levelEnum, [
  List<enums.LevelEnum>? defaultValue,
]) {
  if (levelEnum == null) {
    return defaultValue;
  }

  return levelEnum.map((e) => levelEnumFromJson(e)).toList();
}

String? otherPrescriptionMyTypeEnumNullableToJson(
  enums.OtherPrescriptionMyTypeEnum? otherPrescriptionMyTypeEnum,
) {
  return otherPrescriptionMyTypeEnum?.value;
}

String? otherPrescriptionMyTypeEnumToJson(
  enums.OtherPrescriptionMyTypeEnum otherPrescriptionMyTypeEnum,
) {
  return otherPrescriptionMyTypeEnum.value;
}

enums.OtherPrescriptionMyTypeEnum otherPrescriptionMyTypeEnumFromJson(
  Object? otherPrescriptionMyTypeEnum, [
  enums.OtherPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.OtherPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == otherPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.OtherPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.OtherPrescriptionMyTypeEnum? otherPrescriptionMyTypeEnumNullableFromJson(
  Object? otherPrescriptionMyTypeEnum, [
  enums.OtherPrescriptionMyTypeEnum? defaultValue,
]) {
  if (otherPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.OtherPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == otherPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String otherPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.OtherPrescriptionMyTypeEnum>? otherPrescriptionMyTypeEnum,
) {
  return otherPrescriptionMyTypeEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> otherPrescriptionMyTypeEnumListToJson(
  List<enums.OtherPrescriptionMyTypeEnum>? otherPrescriptionMyTypeEnum,
) {
  if (otherPrescriptionMyTypeEnum == null) {
    return [];
  }

  return otherPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.OtherPrescriptionMyTypeEnum> otherPrescriptionMyTypeEnumListFromJson(
  List? otherPrescriptionMyTypeEnum, [
  List<enums.OtherPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (otherPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return otherPrescriptionMyTypeEnum
      .map((e) => otherPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.OtherPrescriptionMyTypeEnum>?
otherPrescriptionMyTypeEnumNullableListFromJson(
  List? otherPrescriptionMyTypeEnum, [
  List<enums.OtherPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (otherPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return otherPrescriptionMyTypeEnum
      .map((e) => otherPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? parasitesTreatmentPrescriptionMyTypeEnumNullableToJson(
  enums.ParasitesTreatmentPrescriptionMyTypeEnum?
  parasitesTreatmentPrescriptionMyTypeEnum,
) {
  return parasitesTreatmentPrescriptionMyTypeEnum?.value;
}

String? parasitesTreatmentPrescriptionMyTypeEnumToJson(
  enums.ParasitesTreatmentPrescriptionMyTypeEnum
  parasitesTreatmentPrescriptionMyTypeEnum,
) {
  return parasitesTreatmentPrescriptionMyTypeEnum.value;
}

enums.ParasitesTreatmentPrescriptionMyTypeEnum
parasitesTreatmentPrescriptionMyTypeEnumFromJson(
  Object? parasitesTreatmentPrescriptionMyTypeEnum, [
  enums.ParasitesTreatmentPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.ParasitesTreatmentPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == parasitesTreatmentPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.ParasitesTreatmentPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.ParasitesTreatmentPrescriptionMyTypeEnum?
parasitesTreatmentPrescriptionMyTypeEnumNullableFromJson(
  Object? parasitesTreatmentPrescriptionMyTypeEnum, [
  enums.ParasitesTreatmentPrescriptionMyTypeEnum? defaultValue,
]) {
  if (parasitesTreatmentPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.ParasitesTreatmentPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == parasitesTreatmentPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String parasitesTreatmentPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.ParasitesTreatmentPrescriptionMyTypeEnum>?
  parasitesTreatmentPrescriptionMyTypeEnum,
) {
  return parasitesTreatmentPrescriptionMyTypeEnum
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> parasitesTreatmentPrescriptionMyTypeEnumListToJson(
  List<enums.ParasitesTreatmentPrescriptionMyTypeEnum>?
  parasitesTreatmentPrescriptionMyTypeEnum,
) {
  if (parasitesTreatmentPrescriptionMyTypeEnum == null) {
    return [];
  }

  return parasitesTreatmentPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.ParasitesTreatmentPrescriptionMyTypeEnum>
parasitesTreatmentPrescriptionMyTypeEnumListFromJson(
  List? parasitesTreatmentPrescriptionMyTypeEnum, [
  List<enums.ParasitesTreatmentPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (parasitesTreatmentPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return parasitesTreatmentPrescriptionMyTypeEnum
      .map(
        (e) => parasitesTreatmentPrescriptionMyTypeEnumFromJson(e.toString()),
      )
      .toList();
}

List<enums.ParasitesTreatmentPrescriptionMyTypeEnum>?
parasitesTreatmentPrescriptionMyTypeEnumNullableListFromJson(
  List? parasitesTreatmentPrescriptionMyTypeEnum, [
  List<enums.ParasitesTreatmentPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (parasitesTreatmentPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return parasitesTreatmentPrescriptionMyTypeEnum
      .map(
        (e) => parasitesTreatmentPrescriptionMyTypeEnumFromJson(e.toString()),
      )
      .toList();
}

String? parasitesTypeEnumNullableToJson(
  enums.ParasitesTypeEnum? parasitesTypeEnum,
) {
  return parasitesTypeEnum?.value;
}

String? parasitesTypeEnumToJson(enums.ParasitesTypeEnum parasitesTypeEnum) {
  return parasitesTypeEnum.value;
}

enums.ParasitesTypeEnum parasitesTypeEnumFromJson(
  Object? parasitesTypeEnum, [
  enums.ParasitesTypeEnum? defaultValue,
]) {
  return enums.ParasitesTypeEnum.values.firstWhereOrNull(
        (e) => e.value == parasitesTypeEnum,
      ) ??
      defaultValue ??
      enums.ParasitesTypeEnum.swaggerGeneratedUnknown;
}

enums.ParasitesTypeEnum? parasitesTypeEnumNullableFromJson(
  Object? parasitesTypeEnum, [
  enums.ParasitesTypeEnum? defaultValue,
]) {
  if (parasitesTypeEnum == null) {
    return null;
  }
  return enums.ParasitesTypeEnum.values.firstWhereOrNull(
        (e) => e.value == parasitesTypeEnum,
      ) ??
      defaultValue;
}

String parasitesTypeEnumExplodedListToJson(
  List<enums.ParasitesTypeEnum>? parasitesTypeEnum,
) {
  return parasitesTypeEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> parasitesTypeEnumListToJson(
  List<enums.ParasitesTypeEnum>? parasitesTypeEnum,
) {
  if (parasitesTypeEnum == null) {
    return [];
  }

  return parasitesTypeEnum.map((e) => e.value!).toList();
}

List<enums.ParasitesTypeEnum> parasitesTypeEnumListFromJson(
  List? parasitesTypeEnum, [
  List<enums.ParasitesTypeEnum>? defaultValue,
]) {
  if (parasitesTypeEnum == null) {
    return defaultValue ?? [];
  }

  return parasitesTypeEnum
      .map((e) => parasitesTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.ParasitesTypeEnum>? parasitesTypeEnumNullableListFromJson(
  List? parasitesTypeEnum, [
  List<enums.ParasitesTypeEnum>? defaultValue,
]) {
  if (parasitesTypeEnum == null) {
    return defaultValue;
  }

  return parasitesTypeEnum
      .map((e) => parasitesTypeEnumFromJson(e.toString()))
      .toList();
}

String? prescriptionExecutionStatusEnumNullableToJson(
  enums.PrescriptionExecutionStatusEnum? prescriptionExecutionStatusEnum,
) {
  return prescriptionExecutionStatusEnum?.value;
}

String? prescriptionExecutionStatusEnumToJson(
  enums.PrescriptionExecutionStatusEnum prescriptionExecutionStatusEnum,
) {
  return prescriptionExecutionStatusEnum.value;
}

enums.PrescriptionExecutionStatusEnum prescriptionExecutionStatusEnumFromJson(
  Object? prescriptionExecutionStatusEnum, [
  enums.PrescriptionExecutionStatusEnum? defaultValue,
]) {
  return enums.PrescriptionExecutionStatusEnum.values.firstWhereOrNull(
        (e) => e.value == prescriptionExecutionStatusEnum,
      ) ??
      defaultValue ??
      enums.PrescriptionExecutionStatusEnum.swaggerGeneratedUnknown;
}

enums.PrescriptionExecutionStatusEnum?
prescriptionExecutionStatusEnumNullableFromJson(
  Object? prescriptionExecutionStatusEnum, [
  enums.PrescriptionExecutionStatusEnum? defaultValue,
]) {
  if (prescriptionExecutionStatusEnum == null) {
    return null;
  }
  return enums.PrescriptionExecutionStatusEnum.values.firstWhereOrNull(
        (e) => e.value == prescriptionExecutionStatusEnum,
      ) ??
      defaultValue;
}

String prescriptionExecutionStatusEnumExplodedListToJson(
  List<enums.PrescriptionExecutionStatusEnum>? prescriptionExecutionStatusEnum,
) {
  return prescriptionExecutionStatusEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> prescriptionExecutionStatusEnumListToJson(
  List<enums.PrescriptionExecutionStatusEnum>? prescriptionExecutionStatusEnum,
) {
  if (prescriptionExecutionStatusEnum == null) {
    return [];
  }

  return prescriptionExecutionStatusEnum.map((e) => e.value!).toList();
}

List<enums.PrescriptionExecutionStatusEnum>
prescriptionExecutionStatusEnumListFromJson(
  List? prescriptionExecutionStatusEnum, [
  List<enums.PrescriptionExecutionStatusEnum>? defaultValue,
]) {
  if (prescriptionExecutionStatusEnum == null) {
    return defaultValue ?? [];
  }

  return prescriptionExecutionStatusEnum
      .map((e) => prescriptionExecutionStatusEnumFromJson(e.toString()))
      .toList();
}

List<enums.PrescriptionExecutionStatusEnum>?
prescriptionExecutionStatusEnumNullableListFromJson(
  List? prescriptionExecutionStatusEnum, [
  List<enums.PrescriptionExecutionStatusEnum>? defaultValue,
]) {
  if (prescriptionExecutionStatusEnum == null) {
    return defaultValue;
  }

  return prescriptionExecutionStatusEnum
      .map((e) => prescriptionExecutionStatusEnumFromJson(e.toString()))
      .toList();
}

String? prescriptionShortMyTypeEnumNullableToJson(
  enums.PrescriptionShortMyTypeEnum? prescriptionShortMyTypeEnum,
) {
  return prescriptionShortMyTypeEnum?.value;
}

String? prescriptionShortMyTypeEnumToJson(
  enums.PrescriptionShortMyTypeEnum prescriptionShortMyTypeEnum,
) {
  return prescriptionShortMyTypeEnum.value;
}

enums.PrescriptionShortMyTypeEnum prescriptionShortMyTypeEnumFromJson(
  Object? prescriptionShortMyTypeEnum, [
  enums.PrescriptionShortMyTypeEnum? defaultValue,
]) {
  return enums.PrescriptionShortMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == prescriptionShortMyTypeEnum,
      ) ??
      defaultValue ??
      enums.PrescriptionShortMyTypeEnum.swaggerGeneratedUnknown;
}

enums.PrescriptionShortMyTypeEnum? prescriptionShortMyTypeEnumNullableFromJson(
  Object? prescriptionShortMyTypeEnum, [
  enums.PrescriptionShortMyTypeEnum? defaultValue,
]) {
  if (prescriptionShortMyTypeEnum == null) {
    return null;
  }
  return enums.PrescriptionShortMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == prescriptionShortMyTypeEnum,
      ) ??
      defaultValue;
}

String prescriptionShortMyTypeEnumExplodedListToJson(
  List<enums.PrescriptionShortMyTypeEnum>? prescriptionShortMyTypeEnum,
) {
  return prescriptionShortMyTypeEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> prescriptionShortMyTypeEnumListToJson(
  List<enums.PrescriptionShortMyTypeEnum>? prescriptionShortMyTypeEnum,
) {
  if (prescriptionShortMyTypeEnum == null) {
    return [];
  }

  return prescriptionShortMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.PrescriptionShortMyTypeEnum> prescriptionShortMyTypeEnumListFromJson(
  List? prescriptionShortMyTypeEnum, [
  List<enums.PrescriptionShortMyTypeEnum>? defaultValue,
]) {
  if (prescriptionShortMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return prescriptionShortMyTypeEnum
      .map((e) => prescriptionShortMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.PrescriptionShortMyTypeEnum>?
prescriptionShortMyTypeEnumNullableListFromJson(
  List? prescriptionShortMyTypeEnum, [
  List<enums.PrescriptionShortMyTypeEnum>? defaultValue,
]) {
  if (prescriptionShortMyTypeEnum == null) {
    return defaultValue;
  }

  return prescriptionShortMyTypeEnum
      .map((e) => prescriptionShortMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? readmissionPrescriptionMyTypeEnumNullableToJson(
  enums.ReadmissionPrescriptionMyTypeEnum? readmissionPrescriptionMyTypeEnum,
) {
  return readmissionPrescriptionMyTypeEnum?.value;
}

String? readmissionPrescriptionMyTypeEnumToJson(
  enums.ReadmissionPrescriptionMyTypeEnum readmissionPrescriptionMyTypeEnum,
) {
  return readmissionPrescriptionMyTypeEnum.value;
}

enums.ReadmissionPrescriptionMyTypeEnum
readmissionPrescriptionMyTypeEnumFromJson(
  Object? readmissionPrescriptionMyTypeEnum, [
  enums.ReadmissionPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.ReadmissionPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == readmissionPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.ReadmissionPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.ReadmissionPrescriptionMyTypeEnum?
readmissionPrescriptionMyTypeEnumNullableFromJson(
  Object? readmissionPrescriptionMyTypeEnum, [
  enums.ReadmissionPrescriptionMyTypeEnum? defaultValue,
]) {
  if (readmissionPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.ReadmissionPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == readmissionPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String readmissionPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.ReadmissionPrescriptionMyTypeEnum>?
  readmissionPrescriptionMyTypeEnum,
) {
  return readmissionPrescriptionMyTypeEnum?.map((e) => e.value!).join(',') ??
      '';
}

List<String> readmissionPrescriptionMyTypeEnumListToJson(
  List<enums.ReadmissionPrescriptionMyTypeEnum>?
  readmissionPrescriptionMyTypeEnum,
) {
  if (readmissionPrescriptionMyTypeEnum == null) {
    return [];
  }

  return readmissionPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.ReadmissionPrescriptionMyTypeEnum>
readmissionPrescriptionMyTypeEnumListFromJson(
  List? readmissionPrescriptionMyTypeEnum, [
  List<enums.ReadmissionPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (readmissionPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return readmissionPrescriptionMyTypeEnum
      .map((e) => readmissionPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.ReadmissionPrescriptionMyTypeEnum>?
readmissionPrescriptionMyTypeEnumNullableListFromJson(
  List? readmissionPrescriptionMyTypeEnum, [
  List<enums.ReadmissionPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (readmissionPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return readmissionPrescriptionMyTypeEnum
      .map((e) => readmissionPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? removingStitchesPrescriptionMyTypeEnumNullableToJson(
  enums.RemovingStitchesPrescriptionMyTypeEnum?
  removingStitchesPrescriptionMyTypeEnum,
) {
  return removingStitchesPrescriptionMyTypeEnum?.value;
}

String? removingStitchesPrescriptionMyTypeEnumToJson(
  enums.RemovingStitchesPrescriptionMyTypeEnum
  removingStitchesPrescriptionMyTypeEnum,
) {
  return removingStitchesPrescriptionMyTypeEnum.value;
}

enums.RemovingStitchesPrescriptionMyTypeEnum
removingStitchesPrescriptionMyTypeEnumFromJson(
  Object? removingStitchesPrescriptionMyTypeEnum, [
  enums.RemovingStitchesPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.RemovingStitchesPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == removingStitchesPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.RemovingStitchesPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.RemovingStitchesPrescriptionMyTypeEnum?
removingStitchesPrescriptionMyTypeEnumNullableFromJson(
  Object? removingStitchesPrescriptionMyTypeEnum, [
  enums.RemovingStitchesPrescriptionMyTypeEnum? defaultValue,
]) {
  if (removingStitchesPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.RemovingStitchesPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == removingStitchesPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String removingStitchesPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.RemovingStitchesPrescriptionMyTypeEnum>?
  removingStitchesPrescriptionMyTypeEnum,
) {
  return removingStitchesPrescriptionMyTypeEnum
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> removingStitchesPrescriptionMyTypeEnumListToJson(
  List<enums.RemovingStitchesPrescriptionMyTypeEnum>?
  removingStitchesPrescriptionMyTypeEnum,
) {
  if (removingStitchesPrescriptionMyTypeEnum == null) {
    return [];
  }

  return removingStitchesPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.RemovingStitchesPrescriptionMyTypeEnum>
removingStitchesPrescriptionMyTypeEnumListFromJson(
  List? removingStitchesPrescriptionMyTypeEnum, [
  List<enums.RemovingStitchesPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (removingStitchesPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return removingStitchesPrescriptionMyTypeEnum
      .map((e) => removingStitchesPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.RemovingStitchesPrescriptionMyTypeEnum>?
removingStitchesPrescriptionMyTypeEnumNullableListFromJson(
  List? removingStitchesPrescriptionMyTypeEnum, [
  List<enums.RemovingStitchesPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (removingStitchesPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return removingStitchesPrescriptionMyTypeEnum
      .map((e) => removingStitchesPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? roleEnumNullableToJson(enums.RoleEnum? roleEnum) {
  return roleEnum?.value;
}

String? roleEnumToJson(enums.RoleEnum roleEnum) {
  return roleEnum.value;
}

enums.RoleEnum roleEnumFromJson(
  Object? roleEnum, [
  enums.RoleEnum? defaultValue,
]) {
  return enums.RoleEnum.values.firstWhereOrNull((e) => e.value == roleEnum) ??
      defaultValue ??
      enums.RoleEnum.swaggerGeneratedUnknown;
}

enums.RoleEnum? roleEnumNullableFromJson(
  Object? roleEnum, [
  enums.RoleEnum? defaultValue,
]) {
  if (roleEnum == null) {
    return null;
  }
  return enums.RoleEnum.values.firstWhereOrNull((e) => e.value == roleEnum) ??
      defaultValue;
}

String roleEnumExplodedListToJson(List<enums.RoleEnum>? roleEnum) {
  return roleEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> roleEnumListToJson(List<enums.RoleEnum>? roleEnum) {
  if (roleEnum == null) {
    return [];
  }

  return roleEnum.map((e) => e.value!).toList();
}

List<enums.RoleEnum> roleEnumListFromJson(
  List? roleEnum, [
  List<enums.RoleEnum>? defaultValue,
]) {
  if (roleEnum == null) {
    return defaultValue ?? [];
  }

  return roleEnum.map((e) => roleEnumFromJson(e.toString())).toList();
}

List<enums.RoleEnum>? roleEnumNullableListFromJson(
  List? roleEnum, [
  List<enums.RoleEnum>? defaultValue,
]) {
  if (roleEnum == null) {
    return defaultValue;
  }

  return roleEnum.map((e) => roleEnumFromJson(e.toString())).toList();
}

String? status69fEnumNullableToJson(enums.Status69fEnum? status69fEnum) {
  return status69fEnum?.value;
}

String? status69fEnumToJson(enums.Status69fEnum status69fEnum) {
  return status69fEnum.value;
}

enums.Status69fEnum status69fEnumFromJson(
  Object? status69fEnum, [
  enums.Status69fEnum? defaultValue,
]) {
  return enums.Status69fEnum.values.firstWhereOrNull(
        (e) => e.value == status69fEnum,
      ) ??
      defaultValue ??
      enums.Status69fEnum.swaggerGeneratedUnknown;
}

enums.Status69fEnum? status69fEnumNullableFromJson(
  Object? status69fEnum, [
  enums.Status69fEnum? defaultValue,
]) {
  if (status69fEnum == null) {
    return null;
  }
  return enums.Status69fEnum.values.firstWhereOrNull(
        (e) => e.value == status69fEnum,
      ) ??
      defaultValue;
}

String status69fEnumExplodedListToJson(
  List<enums.Status69fEnum>? status69fEnum,
) {
  return status69fEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> status69fEnumListToJson(List<enums.Status69fEnum>? status69fEnum) {
  if (status69fEnum == null) {
    return [];
  }

  return status69fEnum.map((e) => e.value!).toList();
}

List<enums.Status69fEnum> status69fEnumListFromJson(
  List? status69fEnum, [
  List<enums.Status69fEnum>? defaultValue,
]) {
  if (status69fEnum == null) {
    return defaultValue ?? [];
  }

  return status69fEnum.map((e) => status69fEnumFromJson(e.toString())).toList();
}

List<enums.Status69fEnum>? status69fEnumNullableListFromJson(
  List? status69fEnum, [
  List<enums.Status69fEnum>? defaultValue,
]) {
  if (status69fEnum == null) {
    return defaultValue;
  }

  return status69fEnum.map((e) => status69fEnumFromJson(e.toString())).toList();
}

String? vaccinationPrescriptionMyTypeEnumNullableToJson(
  enums.VaccinationPrescriptionMyTypeEnum? vaccinationPrescriptionMyTypeEnum,
) {
  return vaccinationPrescriptionMyTypeEnum?.value;
}

String? vaccinationPrescriptionMyTypeEnumToJson(
  enums.VaccinationPrescriptionMyTypeEnum vaccinationPrescriptionMyTypeEnum,
) {
  return vaccinationPrescriptionMyTypeEnum.value;
}

enums.VaccinationPrescriptionMyTypeEnum
vaccinationPrescriptionMyTypeEnumFromJson(
  Object? vaccinationPrescriptionMyTypeEnum, [
  enums.VaccinationPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.VaccinationPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == vaccinationPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.VaccinationPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.VaccinationPrescriptionMyTypeEnum?
vaccinationPrescriptionMyTypeEnumNullableFromJson(
  Object? vaccinationPrescriptionMyTypeEnum, [
  enums.VaccinationPrescriptionMyTypeEnum? defaultValue,
]) {
  if (vaccinationPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.VaccinationPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == vaccinationPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String vaccinationPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.VaccinationPrescriptionMyTypeEnum>?
  vaccinationPrescriptionMyTypeEnum,
) {
  return vaccinationPrescriptionMyTypeEnum?.map((e) => e.value!).join(',') ??
      '';
}

List<String> vaccinationPrescriptionMyTypeEnumListToJson(
  List<enums.VaccinationPrescriptionMyTypeEnum>?
  vaccinationPrescriptionMyTypeEnum,
) {
  if (vaccinationPrescriptionMyTypeEnum == null) {
    return [];
  }

  return vaccinationPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.VaccinationPrescriptionMyTypeEnum>
vaccinationPrescriptionMyTypeEnumListFromJson(
  List? vaccinationPrescriptionMyTypeEnum, [
  List<enums.VaccinationPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (vaccinationPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return vaccinationPrescriptionMyTypeEnum
      .map((e) => vaccinationPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.VaccinationPrescriptionMyTypeEnum>?
vaccinationPrescriptionMyTypeEnumNullableListFromJson(
  List? vaccinationPrescriptionMyTypeEnum, [
  List<enums.VaccinationPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (vaccinationPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return vaccinationPrescriptionMyTypeEnum
      .map((e) => vaccinationPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? woundHealingPrescriptionMyTypeEnumNullableToJson(
  enums.WoundHealingPrescriptionMyTypeEnum? woundHealingPrescriptionMyTypeEnum,
) {
  return woundHealingPrescriptionMyTypeEnum?.value;
}

String? woundHealingPrescriptionMyTypeEnumToJson(
  enums.WoundHealingPrescriptionMyTypeEnum woundHealingPrescriptionMyTypeEnum,
) {
  return woundHealingPrescriptionMyTypeEnum.value;
}

enums.WoundHealingPrescriptionMyTypeEnum
woundHealingPrescriptionMyTypeEnumFromJson(
  Object? woundHealingPrescriptionMyTypeEnum, [
  enums.WoundHealingPrescriptionMyTypeEnum? defaultValue,
]) {
  return enums.WoundHealingPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == woundHealingPrescriptionMyTypeEnum,
      ) ??
      defaultValue ??
      enums.WoundHealingPrescriptionMyTypeEnum.swaggerGeneratedUnknown;
}

enums.WoundHealingPrescriptionMyTypeEnum?
woundHealingPrescriptionMyTypeEnumNullableFromJson(
  Object? woundHealingPrescriptionMyTypeEnum, [
  enums.WoundHealingPrescriptionMyTypeEnum? defaultValue,
]) {
  if (woundHealingPrescriptionMyTypeEnum == null) {
    return null;
  }
  return enums.WoundHealingPrescriptionMyTypeEnum.values.firstWhereOrNull(
        (e) => e.value == woundHealingPrescriptionMyTypeEnum,
      ) ??
      defaultValue;
}

String woundHealingPrescriptionMyTypeEnumExplodedListToJson(
  List<enums.WoundHealingPrescriptionMyTypeEnum>?
  woundHealingPrescriptionMyTypeEnum,
) {
  return woundHealingPrescriptionMyTypeEnum?.map((e) => e.value!).join(',') ??
      '';
}

List<String> woundHealingPrescriptionMyTypeEnumListToJson(
  List<enums.WoundHealingPrescriptionMyTypeEnum>?
  woundHealingPrescriptionMyTypeEnum,
) {
  if (woundHealingPrescriptionMyTypeEnum == null) {
    return [];
  }

  return woundHealingPrescriptionMyTypeEnum.map((e) => e.value!).toList();
}

List<enums.WoundHealingPrescriptionMyTypeEnum>
woundHealingPrescriptionMyTypeEnumListFromJson(
  List? woundHealingPrescriptionMyTypeEnum, [
  List<enums.WoundHealingPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (woundHealingPrescriptionMyTypeEnum == null) {
    return defaultValue ?? [];
  }

  return woundHealingPrescriptionMyTypeEnum
      .map((e) => woundHealingPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

List<enums.WoundHealingPrescriptionMyTypeEnum>?
woundHealingPrescriptionMyTypeEnumNullableListFromJson(
  List? woundHealingPrescriptionMyTypeEnum, [
  List<enums.WoundHealingPrescriptionMyTypeEnum>? defaultValue,
]) {
  if (woundHealingPrescriptionMyTypeEnum == null) {
    return defaultValue;
  }

  return woundHealingPrescriptionMyTypeEnum
      .map((e) => woundHealingPrescriptionMyTypeEnumFromJson(e.toString()))
      .toList();
}

String? apiSchemaGetFormatNullableToJson(
  enums.ApiSchemaGetFormat? apiSchemaGetFormat,
) {
  return apiSchemaGetFormat?.value;
}

String? apiSchemaGetFormatToJson(enums.ApiSchemaGetFormat apiSchemaGetFormat) {
  return apiSchemaGetFormat.value;
}

enums.ApiSchemaGetFormat apiSchemaGetFormatFromJson(
  Object? apiSchemaGetFormat, [
  enums.ApiSchemaGetFormat? defaultValue,
]) {
  return enums.ApiSchemaGetFormat.values.firstWhereOrNull(
        (e) => e.value == apiSchemaGetFormat,
      ) ??
      defaultValue ??
      enums.ApiSchemaGetFormat.swaggerGeneratedUnknown;
}

enums.ApiSchemaGetFormat? apiSchemaGetFormatNullableFromJson(
  Object? apiSchemaGetFormat, [
  enums.ApiSchemaGetFormat? defaultValue,
]) {
  if (apiSchemaGetFormat == null) {
    return null;
  }
  return enums.ApiSchemaGetFormat.values.firstWhereOrNull(
        (e) => e.value == apiSchemaGetFormat,
      ) ??
      defaultValue;
}

String apiSchemaGetFormatExplodedListToJson(
  List<enums.ApiSchemaGetFormat>? apiSchemaGetFormat,
) {
  return apiSchemaGetFormat?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiSchemaGetFormatListToJson(
  List<enums.ApiSchemaGetFormat>? apiSchemaGetFormat,
) {
  if (apiSchemaGetFormat == null) {
    return [];
  }

  return apiSchemaGetFormat.map((e) => e.value!).toList();
}

List<enums.ApiSchemaGetFormat> apiSchemaGetFormatListFromJson(
  List? apiSchemaGetFormat, [
  List<enums.ApiSchemaGetFormat>? defaultValue,
]) {
  if (apiSchemaGetFormat == null) {
    return defaultValue ?? [];
  }

  return apiSchemaGetFormat
      .map((e) => apiSchemaGetFormatFromJson(e.toString()))
      .toList();
}

List<enums.ApiSchemaGetFormat>? apiSchemaGetFormatNullableListFromJson(
  List? apiSchemaGetFormat, [
  List<enums.ApiSchemaGetFormat>? defaultValue,
]) {
  if (apiSchemaGetFormat == null) {
    return defaultValue;
  }

  return apiSchemaGetFormat
      .map((e) => apiSchemaGetFormatFromJson(e.toString()))
      .toList();
}

String? apiSchemaGetLangNullableToJson(
  enums.ApiSchemaGetLang? apiSchemaGetLang,
) {
  return apiSchemaGetLang?.value;
}

String? apiSchemaGetLangToJson(enums.ApiSchemaGetLang apiSchemaGetLang) {
  return apiSchemaGetLang.value;
}

enums.ApiSchemaGetLang apiSchemaGetLangFromJson(
  Object? apiSchemaGetLang, [
  enums.ApiSchemaGetLang? defaultValue,
]) {
  return enums.ApiSchemaGetLang.values.firstWhereOrNull(
        (e) => e.value == apiSchemaGetLang,
      ) ??
      defaultValue ??
      enums.ApiSchemaGetLang.swaggerGeneratedUnknown;
}

enums.ApiSchemaGetLang? apiSchemaGetLangNullableFromJson(
  Object? apiSchemaGetLang, [
  enums.ApiSchemaGetLang? defaultValue,
]) {
  if (apiSchemaGetLang == null) {
    return null;
  }
  return enums.ApiSchemaGetLang.values.firstWhereOrNull(
        (e) => e.value == apiSchemaGetLang,
      ) ??
      defaultValue;
}

String apiSchemaGetLangExplodedListToJson(
  List<enums.ApiSchemaGetLang>? apiSchemaGetLang,
) {
  return apiSchemaGetLang?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiSchemaGetLangListToJson(
  List<enums.ApiSchemaGetLang>? apiSchemaGetLang,
) {
  if (apiSchemaGetLang == null) {
    return [];
  }

  return apiSchemaGetLang.map((e) => e.value!).toList();
}

List<enums.ApiSchemaGetLang> apiSchemaGetLangListFromJson(
  List? apiSchemaGetLang, [
  List<enums.ApiSchemaGetLang>? defaultValue,
]) {
  if (apiSchemaGetLang == null) {
    return defaultValue ?? [];
  }

  return apiSchemaGetLang
      .map((e) => apiSchemaGetLangFromJson(e.toString()))
      .toList();
}

List<enums.ApiSchemaGetLang>? apiSchemaGetLangNullableListFromJson(
  List? apiSchemaGetLang, [
  List<enums.ApiSchemaGetLang>? defaultValue,
]) {
  if (apiSchemaGetLang == null) {
    return defaultValue;
  }

  return apiSchemaGetLang
      .map((e) => apiSchemaGetLangFromJson(e.toString()))
      .toList();
}

String? apiV1AnimalsIdHistoryGetCreatedAtRangeNullableToJson(
  enums.ApiV1AnimalsIdHistoryGetCreatedAtRange?
  apiV1AnimalsIdHistoryGetCreatedAtRange,
) {
  return apiV1AnimalsIdHistoryGetCreatedAtRange?.value;
}

String? apiV1AnimalsIdHistoryGetCreatedAtRangeToJson(
  enums.ApiV1AnimalsIdHistoryGetCreatedAtRange
  apiV1AnimalsIdHistoryGetCreatedAtRange,
) {
  return apiV1AnimalsIdHistoryGetCreatedAtRange.value;
}

enums.ApiV1AnimalsIdHistoryGetCreatedAtRange
apiV1AnimalsIdHistoryGetCreatedAtRangeFromJson(
  Object? apiV1AnimalsIdHistoryGetCreatedAtRange, [
  enums.ApiV1AnimalsIdHistoryGetCreatedAtRange? defaultValue,
]) {
  return enums.ApiV1AnimalsIdHistoryGetCreatedAtRange.values.firstWhereOrNull(
        (e) => e.value == apiV1AnimalsIdHistoryGetCreatedAtRange,
      ) ??
      defaultValue ??
      enums.ApiV1AnimalsIdHistoryGetCreatedAtRange.swaggerGeneratedUnknown;
}

enums.ApiV1AnimalsIdHistoryGetCreatedAtRange?
apiV1AnimalsIdHistoryGetCreatedAtRangeNullableFromJson(
  Object? apiV1AnimalsIdHistoryGetCreatedAtRange, [
  enums.ApiV1AnimalsIdHistoryGetCreatedAtRange? defaultValue,
]) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return null;
  }
  return enums.ApiV1AnimalsIdHistoryGetCreatedAtRange.values.firstWhereOrNull(
        (e) => e.value == apiV1AnimalsIdHistoryGetCreatedAtRange,
      ) ??
      defaultValue;
}

String apiV1AnimalsIdHistoryGetCreatedAtRangeExplodedListToJson(
  List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>?
  apiV1AnimalsIdHistoryGetCreatedAtRange,
) {
  return apiV1AnimalsIdHistoryGetCreatedAtRange
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> apiV1AnimalsIdHistoryGetCreatedAtRangeListToJson(
  List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>?
  apiV1AnimalsIdHistoryGetCreatedAtRange,
) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return [];
  }

  return apiV1AnimalsIdHistoryGetCreatedAtRange.map((e) => e.value!).toList();
}

List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>
apiV1AnimalsIdHistoryGetCreatedAtRangeListFromJson(
  List? apiV1AnimalsIdHistoryGetCreatedAtRange, [
  List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>? defaultValue,
]) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return defaultValue ?? [];
  }

  return apiV1AnimalsIdHistoryGetCreatedAtRange
      .map((e) => apiV1AnimalsIdHistoryGetCreatedAtRangeFromJson(e.toString()))
      .toList();
}

List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>?
apiV1AnimalsIdHistoryGetCreatedAtRangeNullableListFromJson(
  List? apiV1AnimalsIdHistoryGetCreatedAtRange, [
  List<enums.ApiV1AnimalsIdHistoryGetCreatedAtRange>? defaultValue,
]) {
  if (apiV1AnimalsIdHistoryGetCreatedAtRange == null) {
    return defaultValue;
  }

  return apiV1AnimalsIdHistoryGetCreatedAtRange
      .map((e) => apiV1AnimalsIdHistoryGetCreatedAtRangeFromJson(e.toString()))
      .toList();
}

int? apiV1AnimalsSpeciesGetLevelNullableToJson(
  enums.ApiV1AnimalsSpeciesGetLevel? apiV1AnimalsSpeciesGetLevel,
) {
  return apiV1AnimalsSpeciesGetLevel?.value;
}

int? apiV1AnimalsSpeciesGetLevelToJson(
  enums.ApiV1AnimalsSpeciesGetLevel apiV1AnimalsSpeciesGetLevel,
) {
  return apiV1AnimalsSpeciesGetLevel.value;
}

enums.ApiV1AnimalsSpeciesGetLevel apiV1AnimalsSpeciesGetLevelFromJson(
  Object? apiV1AnimalsSpeciesGetLevel, [
  enums.ApiV1AnimalsSpeciesGetLevel? defaultValue,
]) {
  return enums.ApiV1AnimalsSpeciesGetLevel.values.firstWhereOrNull(
        (e) => e.value == apiV1AnimalsSpeciesGetLevel,
      ) ??
      defaultValue ??
      enums.ApiV1AnimalsSpeciesGetLevel.swaggerGeneratedUnknown;
}

enums.ApiV1AnimalsSpeciesGetLevel? apiV1AnimalsSpeciesGetLevelNullableFromJson(
  Object? apiV1AnimalsSpeciesGetLevel, [
  enums.ApiV1AnimalsSpeciesGetLevel? defaultValue,
]) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return null;
  }
  return enums.ApiV1AnimalsSpeciesGetLevel.values.firstWhereOrNull(
        (e) => e.value == apiV1AnimalsSpeciesGetLevel,
      ) ??
      defaultValue;
}

String apiV1AnimalsSpeciesGetLevelExplodedListToJson(
  List<enums.ApiV1AnimalsSpeciesGetLevel>? apiV1AnimalsSpeciesGetLevel,
) {
  return apiV1AnimalsSpeciesGetLevel?.map((e) => e.value!).join(',') ?? '';
}

List<int> apiV1AnimalsSpeciesGetLevelListToJson(
  List<enums.ApiV1AnimalsSpeciesGetLevel>? apiV1AnimalsSpeciesGetLevel,
) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return [];
  }

  return apiV1AnimalsSpeciesGetLevel.map((e) => e.value!).toList();
}

List<enums.ApiV1AnimalsSpeciesGetLevel> apiV1AnimalsSpeciesGetLevelListFromJson(
  List? apiV1AnimalsSpeciesGetLevel, [
  List<enums.ApiV1AnimalsSpeciesGetLevel>? defaultValue,
]) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return defaultValue ?? [];
  }

  return apiV1AnimalsSpeciesGetLevel
      .map((e) => apiV1AnimalsSpeciesGetLevelFromJson(e))
      .toList();
}

List<enums.ApiV1AnimalsSpeciesGetLevel>?
apiV1AnimalsSpeciesGetLevelNullableListFromJson(
  List? apiV1AnimalsSpeciesGetLevel, [
  List<enums.ApiV1AnimalsSpeciesGetLevel>? defaultValue,
]) {
  if (apiV1AnimalsSpeciesGetLevel == null) {
    return defaultValue;
  }

  return apiV1AnimalsSpeciesGetLevel
      .map((e) => apiV1AnimalsSpeciesGetLevelFromJson(e))
      .toList();
}

String? apiV1AnimalsStatsGetFormatNullableToJson(
  enums.ApiV1AnimalsStatsGetFormat? apiV1AnimalsStatsGetFormat,
) {
  return apiV1AnimalsStatsGetFormat?.value;
}

String? apiV1AnimalsStatsGetFormatToJson(
  enums.ApiV1AnimalsStatsGetFormat apiV1AnimalsStatsGetFormat,
) {
  return apiV1AnimalsStatsGetFormat.value;
}

enums.ApiV1AnimalsStatsGetFormat apiV1AnimalsStatsGetFormatFromJson(
  Object? apiV1AnimalsStatsGetFormat, [
  enums.ApiV1AnimalsStatsGetFormat? defaultValue,
]) {
  return enums.ApiV1AnimalsStatsGetFormat.values.firstWhereOrNull(
        (e) => e.value == apiV1AnimalsStatsGetFormat,
      ) ??
      defaultValue ??
      enums.ApiV1AnimalsStatsGetFormat.swaggerGeneratedUnknown;
}

enums.ApiV1AnimalsStatsGetFormat? apiV1AnimalsStatsGetFormatNullableFromJson(
  Object? apiV1AnimalsStatsGetFormat, [
  enums.ApiV1AnimalsStatsGetFormat? defaultValue,
]) {
  if (apiV1AnimalsStatsGetFormat == null) {
    return null;
  }
  return enums.ApiV1AnimalsStatsGetFormat.values.firstWhereOrNull(
        (e) => e.value == apiV1AnimalsStatsGetFormat,
      ) ??
      defaultValue;
}

String apiV1AnimalsStatsGetFormatExplodedListToJson(
  List<enums.ApiV1AnimalsStatsGetFormat>? apiV1AnimalsStatsGetFormat,
) {
  return apiV1AnimalsStatsGetFormat?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiV1AnimalsStatsGetFormatListToJson(
  List<enums.ApiV1AnimalsStatsGetFormat>? apiV1AnimalsStatsGetFormat,
) {
  if (apiV1AnimalsStatsGetFormat == null) {
    return [];
  }

  return apiV1AnimalsStatsGetFormat.map((e) => e.value!).toList();
}

List<enums.ApiV1AnimalsStatsGetFormat> apiV1AnimalsStatsGetFormatListFromJson(
  List? apiV1AnimalsStatsGetFormat, [
  List<enums.ApiV1AnimalsStatsGetFormat>? defaultValue,
]) {
  if (apiV1AnimalsStatsGetFormat == null) {
    return defaultValue ?? [];
  }

  return apiV1AnimalsStatsGetFormat
      .map((e) => apiV1AnimalsStatsGetFormatFromJson(e.toString()))
      .toList();
}

List<enums.ApiV1AnimalsStatsGetFormat>?
apiV1AnimalsStatsGetFormatNullableListFromJson(
  List? apiV1AnimalsStatsGetFormat, [
  List<enums.ApiV1AnimalsStatsGetFormat>? defaultValue,
]) {
  if (apiV1AnimalsStatsGetFormat == null) {
    return defaultValue;
  }

  return apiV1AnimalsStatsGetFormat
      .map((e) => apiV1AnimalsStatsGetFormatFromJson(e.toString()))
      .toList();
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

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
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
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

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

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
