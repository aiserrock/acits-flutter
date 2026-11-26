import 'package:core/domain.dart';

import 'package:applicants/domain/domain.dart';

/// Тонкая обёртка над [StaffRepository] для generic-поиска модуля media:
/// `PagingFetchAdapter` отрывает метод как коллбэк
/// `Future<List<T>> Function({int limit, int offset, String? searchRequest})`
/// и не умеет разворачивать [Result].
///
/// Ошибку обёртка **бросает**, а не превращает в пустой список: `SearchBloc`
/// ловит её через `catchError` и показывает стаб с кнопкой «повторить». Пустой
/// список означал бы «ничего не найдено» — неверное утверждение при упавшем
/// запросе, и вдобавок навсегда останавливал бы подгрузку страниц
/// (`isReachedMax: 0 < pageLimit`).
class StaffService {
  const StaffService(this._repository);

  final StaffRepository _repository;

  /// Список заявителей; при ошибке бросает [Failure].
  Future<List<Applicant>> fetchApplicants({int limit = 25, int offset = 0, String? searchRequest}) async {
    final result = await _repository.listApplicants(limit: limit, offset: offset, searchRequest: searchRequest);
    return result.fold((failure) => throw failure, (items) => items);
  }

  /// Список кураторов; при ошибке бросает [Failure].
  Future<List<Curator>> fetchCurators({int limit = 25, int offset = 0, String? searchRequest}) async {
    final result = await _repository.listCurators(limit: limit, offset: offset, searchRequest: searchRequest);
    return result.fold((failure) => throw failure, (items) => items);
  }
}
