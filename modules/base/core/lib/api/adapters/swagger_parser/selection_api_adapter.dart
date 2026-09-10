import 'package:dio/dio.dart';

import '../../ports/dto/attribute_dto.dart';
import '../../ports/dto/selection_values_dto.dart';
import '../../ports/selection_api_port.dart';
import 'generated/clients/animals_client.dart';
import 'generated/models/animal_attribute.dart';

/// The ONLY place generated swagger_parser code is touched for the config slice.
///
/// `values-for-selection` is read through the raw [Dio]: the app consumes the
/// whole decoded body by arbitrary key (not just the typed `choices_name`), so
/// the generated model would drop the very groups the app reads. Attributes map
/// cleanly onto the typed [AnimalsClient]. Swapping generators = replace this
/// file with a new adapter implementing [SelectionApiPort].
class SelectionApiAdapter implements SelectionApiPort {
  const SelectionApiAdapter(this._dio, this._animals);

  final Dio _dio;
  final AnimalsClient _animals;

  Options _shelterHeader(int? shelterId) =>
      Options(headers: shelterId == null ? null : {'x-current-shelter': shelterId});

  @override
  Future<SelectionValuesDto> valuesForSelection({int? shelterId}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/values-for-selection/',
      options: _shelterHeader(shelterId),
    );
    return SelectionValuesDto(response.data ?? const <String, dynamic>{});
  }

  @override
  Future<List<AttributeDto>> animalAttributes({int? shelterId}) async {
    final result = await _animals.v1AnimalsAttributesList(xCurrentShelter: shelterId);
    return result.map(_mapAttribute).toList(growable: false);
  }

  AttributeDto _mapAttribute(AnimalAttribute a) =>
      AttributeDto(id: a.id ?? 0, name: a.name ?? '', isRequired: a.isRequired);
}
