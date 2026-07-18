/// Test-only re-export of the generated profile types.
///
/// The public `core` api barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The profile parity tests need the
/// generated client + model to build fixtures that prove the adapter's mapping
/// matches the app's wire shape. This narrow barrel exposes exactly those.
library;

export '../adapters/swagger_parser/generated/clients/users_client.dart';
export '../adapters/swagger_parser/generated/models/user_serializers.dart';
