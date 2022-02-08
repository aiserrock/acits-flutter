import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';

/// Сервис сотрудников (заявителей и пр.)
@singleton
class StaffService {
  StaffService(
    this._authService,
    this._client,
  );

  final AuthService _authService;
  final Openapi _client;

  /// Список кураторов
  Future<List<Curator>> fetchCurators({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    final result = await _client.apiV1CuratorsGet(
      limit: limit,
      offset: offset,
      search: searchRequest,
      xCurrentShelter: _currentShelter,
    );

    final data = result.body?.results;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Получить куратора по Id
  Future<Curator?> fetchCuratorById({
    required int id,
  }) async {
    final result = await _client.apiV1CuratorsIdGet(
      id: id,
      xCurrentShelter: _currentShelter,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Редактировать куратора
  Future<Curator?> updateCurator({
    required int id,
    required Curator curator,
  }) async {
    final result = await _client.apiV1CuratorsIdPut(
      id: id,
      body: curator.copyWith(shelter: _currentShelter),
      xCurrentShelter: _currentShelter,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Создать куратора
  Future<Curator?> createCurator({
    required Curator curator,
  }) async {
    final result = await _client.apiV1CuratorsPost(
      body: curator.copyWith(shelter: _currentShelter),
      xCurrentShelter: _currentShelter,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Список заявителей
  Future<List<Applicant>> fetchApplicants({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    final result = await _client.apiV1ApplicantsGet(
      limit: limit,
      offset: offset,
      search: searchRequest,
      xCurrentShelter: _currentShelter,
    );

    final data = result.body?.results;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Получить заявителя по Id
  Future<Applicant?> fetchApplicantById({
    required int id,
  }) async {
    final result = await _client.apiV1ApplicantsIdGet(
      id: id,
      xCurrentShelter: _currentShelter,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Редактировать заявителя
  Future<Applicant?> updateApplicant({
    required int id,
    required Applicant applicant,
  }) async {
    final result = await _client.apiV1ApplicantsIdPut(
      id: id,
      body: applicant.copyWith(
        shelter: int.tryParse(_currentShelter ?? ''),
      ),
      xCurrentShelter: _currentShelter,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  /// Создать заявителя
  Future<Applicant?> createApplicant({
    required Applicant applicant,
  }) async {
    final result = await _client.apiV1ApplicantsPost(
      body: applicant.copyWith(
        shelter: int.tryParse(_currentShelter ?? ''),
      ),
      xCurrentShelter: _currentShelter,
    );

    final data = result.body;

    if (data != null) {
      return data;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  String? get _currentShelter => _authService.currentShelterId;
}
