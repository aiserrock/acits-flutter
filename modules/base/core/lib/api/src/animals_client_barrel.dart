/// Test-only re-export of the generated animals types.
///
/// The public `core` api barrel deliberately hides the generated
/// swagger_parser code — only the adapter reaches into it. The parity spike,
/// however, needs the generated `AnimalsClient` / `AnimalRead` /
/// `PaginatedAnimalReadList` to build fixtures that prove the adapter's mapping
/// matches the app's chopper shape. This narrow barrel exposes exactly those,
/// without opening the whole generated surface to app code.
library;

export '../adapters/swagger_parser/generated/exports.dart';
