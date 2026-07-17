import 'package:acits_api/acits_api.dart';
import 'package:acits_domain/acits_domain.dart';
import 'package:dio/dio.dart';

import 'package:applicants/domain/domain.dart';
import 'package:applicants/util/util.dart';

/// Сервис сотрудников (заявители + кураторы).
///
/// Прикладной сервис поверх стабильного [StaffApiPort]: вызывает порт,
/// разворачивает DTO → доменные сущности [Applicant]/[Curator], ошибки Dio →
/// [MessagedException] (внешний контракт для UI сохранён). Порт скрывает
/// генератор клиента.
class StaffService {
  StaffService(this._shelterProvider, this._port);

  final ApplicantsShelterProvider _shelterProvider;
  final StaffApiPort _port;

  /// Список кураторов
  Future<List<Curator>> fetchCurators({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    Log.debug('Fetch curators: limit=$limit offset=$offset search=$searchRequest');
    try {
      final dtos = await _port.listCurators(
        limit: limit,
        offset: offset,
        search: searchRequest,
        shelterId: _currentShelterInt,
      );
      Log.info('Curators: ${dtos.length} items');
      return dtos.map(_mapCurator).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch curators failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Получить куратора по Id
  Future<Curator?> fetchCuratorById({required int id}) async {
    Log.debug('Fetch curator: id=$id');
    try {
      final dto = await _port.getCurator(id, shelterId: _currentShelterInt);
      Log.info('Curator: id=${dto.id}');
      return _mapCurator(dto);
    } on DioException catch (e) {
      Log.warning('Fetch curator failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Редактировать куратора
  Future<Curator?> updateCurator({required int id, required Curator curator}) async {
    Log.debug('Update curator: id=$id');
    try {
      final dto = await _port.updateCurator(
        id,
        _curatorWrite(curator),
        shelterId: _currentShelterInt,
      );
      Log.info('Curator updated: id=${dto.id}');
      return _mapCurator(dto);
    } on DioException catch (e) {
      Log.warning('Update curator failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Создать куратора
  Future<Curator?> createCurator({required Curator curator}) async {
    Log.debug('Create curator');
    try {
      final dto = await _port.createCurator(_curatorWrite(curator), shelterId: _currentShelterInt);
      Log.info('Curator created: id=${dto.id}');
      return _mapCurator(dto);
    } on DioException catch (e) {
      Log.warning('Create curator failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Список заявителей
  Future<List<Applicant>> fetchApplicants({
    int limit = 25,
    int offset = 0,
    String? searchRequest,
  }) async {
    Log.debug('Fetch applicants: limit=$limit offset=$offset search=$searchRequest');
    try {
      final dtos = await _port.listApplicants(
        limit: limit,
        offset: offset,
        search: searchRequest,
        shelterId: _currentShelterInt,
      );
      Log.info('Applicants: ${dtos.length} items');
      return dtos.map(_mapApplicant).toList(growable: false);
    } on DioException catch (e) {
      Log.warning('Fetch applicants failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Получить заявителя по Id
  Future<Applicant?> fetchApplicantById({required int id}) async {
    Log.debug('Fetch applicant: id=$id');
    try {
      final dto = await _port.getApplicant(id, shelterId: _currentShelterInt);
      Log.info('Applicant: id=${dto.id}');
      return _mapApplicant(dto);
    } on DioException catch (e) {
      Log.warning('Fetch applicant failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Редактировать заявителя
  Future<Applicant?> updateApplicant({required int id, required Applicant applicant}) async {
    Log.debug('Update applicant: id=$id');
    try {
      final dto = await _port.updateApplicant(
        id,
        _applicantWrite(applicant),
        shelterId: _currentShelterInt,
      );
      Log.info('Applicant updated: id=${dto.id}');
      return _mapApplicant(dto);
    } on DioException catch (e) {
      Log.warning('Update applicant failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  /// Создать заявителя
  Future<Applicant?> createApplicant({required Applicant applicant}) async {
    Log.debug('Create applicant');
    try {
      final dto = await _port.createApplicant(
        _applicantWrite(applicant),
        shelterId: _currentShelterInt,
      );
      Log.info('Applicant created: id=${dto.id}');
      return _mapApplicant(dto);
    } on DioException catch (e) {
      Log.warning('Create applicant failed: ${_errorText(e)}');
      throw MessagedException(error: _errorText(e));
    }
  }

  // ── DTO → сущность ─────────────────────────────────────────────────────────

  Applicant _mapApplicant(ApplicantDto d) => Applicant(
    id: d.id,
    firstName: d.firstName,
    lastName: d.lastName,
    phoneNumber: d.phoneNumber,
    email: d.email,
    contactDetails: d.contactDetails,
  );

  Curator _mapCurator(CuratorDto d) => Curator(
    id: d.id,
    firstName: d.firstName,
    lastName: d.lastName,
    phoneNumber: d.phoneNumber,
    email: d.email,
    address: d.address,
  );

  // ── сущность → write-DTO (shelter скоупим текущим приютом, как прежде) ───────

  ApplicantWriteDto _applicantWrite(Applicant a) => ApplicantWriteDto(
    id: a.id,
    shelter: _currentShelterInt,
    firstName: a.firstName,
    lastName: a.lastName,
    phoneNumber: a.phoneNumber,
    email: a.email,
    contactDetails: a.contactDetails,
  );

  CuratorWriteDto _curatorWrite(Curator c) => CuratorWriteDto(
    id: c.id,
    shelter: _currentShelterStr,
    firstName: c.firstName,
    lastName: c.lastName,
    phoneNumber: c.phoneNumber,
    email: c.email,
    address: c.address ?? '',
  );

  int? get _currentShelterInt => _shelterProvider.shelterId;

  String? get _currentShelterStr => _currentShelterInt?.toString();

  String _errorText(DioException e) => e.response?.data?.toString() ?? e.message ?? e.toString();
}
