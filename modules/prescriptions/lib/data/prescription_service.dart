import 'package:prescriptions/domain/domain.dart';

/// Тонкая обёртка над [PrescriptionRepository] для generic-поиска модуля media:
/// `PagingFetchAdapter` отрывает метод как коллбэк
/// `Future<List<T>> Function({int limit, int offset, String? searchRequest})`
/// и не умеет разворачивать [Result] — обёртка делает это за него (ошибка →
/// пустой список, как уже делает поиск животных через `result.fold`).
class PrescriptionService {
  const PrescriptionService(this._repository);

  final PrescriptionRepository _repository;

  /// Каталог препаратов; при ошибке — пустой список.
  Future<List<Drug>> fetchDrugList({String? searchRequest, int limit = 25, int offset = 0}) async {
    final result = await _repository.listDrugs(searchRequest: searchRequest, limit: limit, offset: offset);
    return result.fold((_) => <Drug>[], (items) => items);
  }
}
