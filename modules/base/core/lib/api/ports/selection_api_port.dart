import 'dto/attribute_dto.dart';
import 'dto/selection_values_dto.dart';

/// Stable port for the config slice (selection values + attribute catalog).
///
/// Expressed in OUR DTOs — never the generated swagger_parser types. Both calls
/// are authed and scoped by [shelterId] (the `x-current-shelter` header).
abstract interface class SelectionApiPort {
  /// `GET /api/v1/values-for-selection/` — the choice groups used across the app
  /// (status names, prescription-type names, …), returned as a raw JSON map.
  Future<SelectionValuesDto> valuesForSelection({int? shelterId});

  /// `GET /api/v1/animals/attributes/` — the animal-attribute catalog.
  Future<List<AttributeDto>> animalAttributes({int? shelterId});
}
