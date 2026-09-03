import 'package:core/domain.dart';

import 'package:applicants/domain/domain.dart';

/// Тонкая обёртка над [StaffRepository] для generic-поиска модуля media:
/// `PagingFetchAdapter` отрывает метод как коллбэк
/// `Future<List<T>> Function({int limit, int offset, String? searchRequest})`
/// и не умеет разворачивать [Result] — обёртка делает это за него (ошибка →
/// пустой список, как уже делает поиск животных через `result.fold`).
class StaffService {
  const StaffService(this._repository);

  final StaffRepository _repository;

  /// Список заявителей; при ошибке — пустой список.
  Future<List<Applicant>> fetchApplicants({int limit = 25, int offset = 0, String? searchRequest}) async {
    final result = await _repository.listApplicants(limit: limit, offset: offset, searchRequest: searchRequest);
    return result.fold((_) => <Applicant>[], (items) => items);
  }

  /// Список кураторов; при ошибке — пустой список.
  Future<List<Curator>> fetchCurators({int limit = 25, int offset = 0, String? searchRequest}) async {
    final result = await _repository.listCurators(limit: limit, offset: offset, searchRequest: searchRequest);
    return result.fold((_) => <Curator>[], (items) => items);
  }
}
