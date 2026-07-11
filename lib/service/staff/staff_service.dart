import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/export.dart';

/// Сервис сотрудников (заявителей и пр.)
@singleton
class StaffService {
  StaffService(this._authService, this._client);

  final AuthService _authService;
  final Openapi _client;

  /// Список кураторов
  Future<List<Curator>> fetchCurators({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    Log.debug('Fetch curators: limit=$limit offset=$offset search=$searchRequest');
    final result = await _client.apiV1CuratorsGet(
      limit: limit,
      offset: offset,
      search: searchRequest,
      xCurrentShelter: _currentShelterInt,
    );

    final data = result.body?.results;

    if (data != null) {
      Log.info('Curators: ${data.length} items');
      return data;
    } else {
      Log.warning('Fetch curators failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Получить куратора по Id
  Future<Curator?> fetchCuratorById({required int id}) async {
    Log.debug('Fetch curator: id=$id');
    final result = await _client.apiV1CuratorsIdGet(id: id, xCurrentShelter: _currentShelterInt);

    final data = result.body;

    if (data != null) {
      Log.info('Curator: id=${data.id}');
      return data;
    } else {
      Log.warning('Fetch curator failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Редактировать куратора
  Future<Curator?> updateCurator({required int id, required Curator curator}) async {
    Log.debug('Update curator: id=$id');
    final result = await _client.apiV1CuratorsIdPut(
      id: id,
      body: curator.copyWith(shelter: _currentShelterStr),
      xCurrentShelter: _currentShelterInt,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Curator updated: id=${data.id}');
      return data;
    } else {
      Log.warning('Update curator failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Создать куратора
  Future<Curator?> createCurator({required Curator curator}) async {
    Log.debug('Create curator');
    final result = await _client.apiV1CuratorsPost(
      body: curator.copyWith(shelter: _currentShelterStr),
      xCurrentShelter: _currentShelterInt,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Curator created: id=${data.id}');
      return data;
    } else {
      Log.warning('Create curator failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Список заявителей
  Future<List<Applicant>> fetchApplicants({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    Log.debug('Fetch applicants: limit=$limit offset=$offset search=$searchRequest');
    final result = await _client.apiV1ApplicantsGet(
      limit: limit,
      offset: offset,
      search: searchRequest,
      xCurrentShelter: _currentShelterInt,
    );

    final data = result.body?.results;

    if (data != null) {
      Log.info('Applicants: ${data.length} items');
      return data;
    } else {
      Log.warning('Fetch applicants failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Получить заявителя по Id
  Future<Applicant?> fetchApplicantById({required int id}) async {
    Log.debug('Fetch applicant: id=$id');
    final result = await _client.apiV1ApplicantsIdGet(id: id, xCurrentShelter: _currentShelterInt);

    final data = result.body;

    if (data != null) {
      Log.info('Applicant: id=${data.id}');
      return data;
    } else {
      Log.warning('Fetch applicant failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Редактировать заявителя
  Future<Applicant?> updateApplicant({required int id, required Applicant applicant}) async {
    Log.debug('Update applicant: id=$id');
    final result = await _client.apiV1ApplicantsIdPut(
      id: id,
      body: applicant.copyWith(shelter: _currentShelterInt),
      xCurrentShelter: _currentShelterInt,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Applicant updated: id=${data.id}');
      return data;
    } else {
      Log.warning('Update applicant failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  /// Создать заявителя
  Future<Applicant?> createApplicant({required Applicant applicant}) async {
    Log.debug('Create applicant');
    final result = await _client.apiV1ApplicantsPost(
      body: applicant.copyWith(shelter: _currentShelterInt),
      xCurrentShelter: _currentShelterInt,
    );

    final data = result.body;

    if (data != null) {
      Log.info('Applicant created: id=${data.id}');
      return data;
    } else {
      Log.warning('Create applicant failed: ${result.error}');
      throw MessagedException(error: result.error);
    }
  }

  int? get _currentShelterInt => _authService.currentShelterId;

  String? get _currentShelterStr => _currentShelterInt?.toString();
}
