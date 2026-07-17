/// API layer: stable ports (`abstract interface <Feature>ApiPort`) + our DTOs.
///
/// The generator (`swagger_parser`) lives under `adapters/` and is the only
/// place generated code exists. Swapping generators = rewrite one adapter.
///
/// Public surface = ports + DTOs + the current adapter binding. The generated
/// code under `adapters/swagger_parser/generated/` is intentionally NOT
/// exported — only the adapter reaches into it.
library;

export 'adapters/swagger_parser/animal_api_adapter.dart';
export 'ports/animal_api_port.dart';
export 'ports/dto/dto.dart';
