import 'dto/animal_dto.dart';

/// Stable port for reading animals — expressed entirely in OUR DTOs.
///
/// This is the contract the app depends on. It never mentions the generated
/// swagger_parser types; swapping the underlying generator (retrofit →
/// openapi-generator → …) means writing a new adapter that implements this
/// interface, with zero changes to ports, DTOs, repositories, or features.
abstract interface class AnimalApiPort {
  /// Lists animals, optionally scoped to a shelter and/or filtered by a free
  /// text [search], with [limit]/[offset] pagination. Returns the unwrapped
  /// `results` list (pagination envelope is handled by the adapter).
  Future<List<AnimalDto>> list({int? shelterId, String? search, int? limit, int? offset});

  /// Fetches a single animal by its numeric [id].
  Future<AnimalDto> getById(int id);
}
