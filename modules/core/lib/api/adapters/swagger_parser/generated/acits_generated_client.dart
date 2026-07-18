// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'clients/schema_client.dart';
import 'clients/token_client.dart';
import 'clients/adopters_client.dart';
import 'clients/animal_sitter_client.dart';
import 'clients/animals_client.dart';
import 'clients/adoptions_client.dart';
import 'clients/overstay_client.dart';
import 'clients/releases_client.dart';
import 'clients/applicants_client.dart';
import 'clients/shelters_client.dart';
import 'clients/curators_client.dart';
import 'clients/feedback_client.dart';
import 'clients/prescriptions_client.dart';
import 'clients/administrator_shelter_management_client.dart';
import 'clients/users_registration_client.dart';
import 'clients/users_client.dart';
import 'clients/values_for_selection_client.dart';

/// Acits API `v1.0.0`.
///
/// Animal shelter manager.
class AcitsGeneratedClient {
  AcitsGeneratedClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  SchemaClient? _schema;
  TokenClient? _token;
  AdoptersClient? _adopters;
  AnimalSitterClient? _animalSitter;
  AnimalsClient? _animals;
  AdoptionsClient? _adoptions;
  OverstayClient? _overstay;
  ReleasesClient? _releases;
  ApplicantsClient? _applicants;
  SheltersClient? _shelters;
  CuratorsClient? _curators;
  FeedbackClient? _feedback;
  PrescriptionsClient? _prescriptions;
  AdministratorShelterManagementClient? _administratorShelterManagement;
  UsersRegistrationClient? _usersRegistration;
  UsersClient? _users;
  ValuesForSelectionClient? _valuesForSelection;

  SchemaClient get schema => _schema ??= SchemaClient(_dio, baseUrl: _baseUrl);

  TokenClient get token => _token ??= TokenClient(_dio, baseUrl: _baseUrl);

  AdoptersClient get adopters => _adopters ??= AdoptersClient(_dio, baseUrl: _baseUrl);

  AnimalSitterClient get animalSitter => _animalSitter ??= AnimalSitterClient(_dio, baseUrl: _baseUrl);

  AnimalsClient get animals => _animals ??= AnimalsClient(_dio, baseUrl: _baseUrl);

  AdoptionsClient get adoptions => _adoptions ??= AdoptionsClient(_dio, baseUrl: _baseUrl);

  OverstayClient get overstay => _overstay ??= OverstayClient(_dio, baseUrl: _baseUrl);

  ReleasesClient get releases => _releases ??= ReleasesClient(_dio, baseUrl: _baseUrl);

  ApplicantsClient get applicants => _applicants ??= ApplicantsClient(_dio, baseUrl: _baseUrl);

  SheltersClient get shelters => _shelters ??= SheltersClient(_dio, baseUrl: _baseUrl);

  CuratorsClient get curators => _curators ??= CuratorsClient(_dio, baseUrl: _baseUrl);

  FeedbackClient get feedback => _feedback ??= FeedbackClient(_dio, baseUrl: _baseUrl);

  PrescriptionsClient get prescriptions => _prescriptions ??= PrescriptionsClient(_dio, baseUrl: _baseUrl);

  AdministratorShelterManagementClient get administratorShelterManagement => _administratorShelterManagement ??= AdministratorShelterManagementClient(_dio, baseUrl: _baseUrl);

  UsersRegistrationClient get usersRegistration => _usersRegistration ??= UsersRegistrationClient(_dio, baseUrl: _baseUrl);

  UsersClient get users => _users ??= UsersClient(_dio, baseUrl: _baseUrl);

  ValuesForSelectionClient get valuesForSelection => _valuesForSelection ??= ValuesForSelectionClient(_dio, baseUrl: _baseUrl);
}
