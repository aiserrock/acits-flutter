import 'package:core/api.dart';
import 'package:core/data.dart';
import 'package:core/domain.dart';

import 'package:applicants/data/mapper/mapper.dart';
import 'package:applicants/domain/domain.dart';
import 'package:applicants/util/util.dart';

/// Реализация [StaffRepository]. Здесь DTO заканчиваются: вызываем
/// [StaffApiPort], разворачиваем DTO → сущности мапперами, ловим исключения →
/// типизированный [Failure]. Наружу (в домен/UI) уходят только сущности в
/// [Result].
class StaffRepositoryImpl implements StaffRepository {
  const StaffRepositoryImpl(this._shelterProvider, this._port);

  final ApplicantsShelterProvider _shelterProvider;
  final StaffApiPort _port;

  @override
  Future<Result<Failure, List<Curator>>> listCurators({int limit = 25, int offset = 0, String? searchRequest}) {
    Log.debug('Fetch curators: limit=$limit offset=$offset search=$searchRequest');
    return _guard(() async {
      final dtos = await _port.listCurators(
        limit: limit,
        offset: offset,
        search: searchRequest,
        shelterId: _currentShelterId,
      );
      Log.info('Curators: ${dtos.length} items');
      return dtos.map((d) => CuratorMapper(d).toEntity()).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, Curator>> getCuratorById(int id) {
    Log.debug('Fetch curator: id=$id');
    return _guard(() async {
      final dto = await _port.getCurator(id, shelterId: _currentShelterId);
      Log.info('Curator: id=${dto.id}');
      return CuratorMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, Curator>> updateCurator(int id, Curator curator) {
    Log.debug('Update curator: id=$id');
    return _guard(() async {
      final body = curatorToWriteDto(curator, shelterId: _currentShelterId);
      final dto = await _port.updateCurator(id, body, shelterId: _currentShelterId);
      Log.info('Curator updated: id=${dto.id}');
      return CuratorMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, Curator>> createCurator(Curator curator) {
    Log.debug('Create curator');
    return _guard(() async {
      final body = curatorToWriteDto(curator, shelterId: _currentShelterId);
      final dto = await _port.createCurator(body, shelterId: _currentShelterId);
      Log.info('Curator created: id=${dto.id}');
      return CuratorMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, List<Applicant>>> listApplicants({int limit = 25, int offset = 0, String? searchRequest}) {
    Log.debug('Fetch applicants: limit=$limit offset=$offset search=$searchRequest');
    return _guard(() async {
      final dtos = await _port.listApplicants(
        limit: limit,
        offset: offset,
        search: searchRequest,
        shelterId: _currentShelterId,
      );
      Log.info('Applicants: ${dtos.length} items');
      return dtos.map((d) => ApplicantMapper(d).toEntity()).toList(growable: false);
    });
  }

  @override
  Future<Result<Failure, Applicant>> getApplicantById(int id) {
    Log.debug('Fetch applicant: id=$id');
    return _guard(() async {
      final dto = await _port.getApplicant(id, shelterId: _currentShelterId);
      Log.info('Applicant: id=${dto.id}');
      return ApplicantMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, Applicant>> updateApplicant(int id, Applicant applicant) {
    Log.debug('Update applicant: id=$id');
    return _guard(() async {
      final body = applicantToWriteDto(applicant, shelterId: _currentShelterId);
      final dto = await _port.updateApplicant(id, body, shelterId: _currentShelterId);
      Log.info('Applicant updated: id=${dto.id}');
      return ApplicantMapper(dto).toEntity();
    });
  }

  @override
  Future<Result<Failure, Applicant>> createApplicant(Applicant applicant) {
    Log.debug('Create applicant');
    return _guard(() async {
      final body = applicantToWriteDto(applicant, shelterId: _currentShelterId);
      final dto = await _port.createApplicant(body, shelterId: _currentShelterId);
      Log.info('Applicant created: id=${dto.id}');
      return ApplicantMapper(dto).toEntity();
    });
  }

  int? get _currentShelterId => _shelterProvider.shelterId;

  /// Логируем на этом уровне: выше остаётся только [Failure], а исходное
  /// исключение со стеком — единственное, по чему в crash-репорте видно, что
  /// именно упало.
  Future<Result<Failure, T>> _guard<T>(Future<T> Function() body) =>
      guard(body, onError: (e, s) => Log.error('StaffRepository request failed', e, s));
}
