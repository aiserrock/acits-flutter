/// Test-only re-export of the generated auth types.
///
/// The public `core` api barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The auth parity tests, however, need the
/// generated clients + models to build fixtures that prove the adapter's
/// mapping matches the app's chopper shape. This narrow barrel exposes exactly
/// those, without opening the whole generated surface to app code.
library;

export '../adapters/swagger_parser/generated/exports.dart';
