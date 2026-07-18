import 'package:core/domain.dart' show Shelter;

/// Порт доступа к текущему приюту и списку всех приютов для generic-поиска.
///
/// Модуль не знает про `AuthService` приложения; корень мостит этот порт к
/// `AuthService` (текущий приют для скоупинга поиска животных, полный список
/// приютов для их поиска/выбора). Паттерн из animals `CurrentShelterProvider`.
abstract interface class MediaShelterProvider {
  /// Id текущего выбранного приюта (или null, если не выбран).
  int? get currentShelterId;

  /// Постранично загрузить список всех приютов (поиск/выбор приюта).
  Future<List<Shelter>> getAllShelterList({int limit, int offset, String? searchRequest});
}
