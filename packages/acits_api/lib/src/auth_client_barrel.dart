/// Test-only re-export of the generated auth types.
///
/// The public `acits_api` barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The auth parity tests, however, need the
/// generated clients + models to build fixtures that prove the adapter's
/// mapping matches the app's chopper shape. This narrow barrel exposes exactly
/// those, without opening the whole generated surface to app code.
library;

export '../adapters/swagger_parser/generated/clients/shelters_client.dart';
export '../adapters/swagger_parser/generated/clients/token_client.dart';
export '../adapters/swagger_parser/generated/clients/users_client.dart';
export '../adapters/swagger_parser/generated/clients/users_registration_client.dart';
export '../adapters/swagger_parser/generated/models/paginated_shelter_short_serializers_list.dart';
export '../adapters/swagger_parser/generated/models/role_enum.dart';
export '../adapters/swagger_parser/generated/models/shelter_serializers.dart';
export '../adapters/swagger_parser/generated/models/shelter_short_serializers.dart';
export '../adapters/swagger_parser/generated/models/token_obtain_pair.dart';
export '../adapters/swagger_parser/generated/models/token_refresh.dart';
export '../adapters/swagger_parser/generated/models/user_current_shelter_serializers.dart';
export '../adapters/swagger_parser/generated/models/user_shelter_admin_serializers.dart';
export '../adapters/swagger_parser/generated/models/user_shelter_worker_serializers.dart';
