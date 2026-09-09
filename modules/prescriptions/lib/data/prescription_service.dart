import 'package:prescriptions/domain/domain.dart';

/// Тонкая обёртка над [PrescriptionRepository] для generic-поиска модуля media:
/// `PagingFetchAdapter` отрывает метод как коллбэк
/// `Future<List<T>> Function({int limit, int offset, String? searchRequest})`
/// и не умеет разворачивать [Result].
///
/// Ошибку обёртка **бросает**, а не превращает в пустой список: `SearchBloc`
/// ловит её через `catchError` и показывает стаб с кнопкой «повторить». Пустой
/// список означал бы «ничего не найдено» — неверное утверждение при упавшем
/// запросе, и вдобавок навсегда останавливал бы подгрузку страниц
/// (`isReachedMax: 0 < pageLimit`).
class PrescriptionService {
  const PrescriptionService(this._repository);

  final PrescriptionRepository _repository;

  /// Каталог препаратов; при ошибке бросает [Failure].
  Future<List<Drug>> fetchDrugList({String? searchRequest, int limit = 25, int offset = 0}) async {
    final result = await _repository.listDrugs(searchRequest: searchRequest, limit: limit, offset: offset);
    return result.fold((failure) => throw failure, (items) => items);
  }
}
