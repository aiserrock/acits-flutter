/// Test-only re-export of the generated config/selection types.
///
/// The public `core` api barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The selection parity tests need the
/// generated animals client + attribute model to prove the adapter's mapping
/// matches the app's wire shape. This narrow barrel exposes exactly those.
library;

export '../adapters/swagger_parser/generated/clients/animals_client.dart';
export '../adapters/swagger_parser/generated/models/animal_attribute.dart';
