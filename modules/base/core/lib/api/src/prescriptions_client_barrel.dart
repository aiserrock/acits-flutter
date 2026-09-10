/// Test-only re-export of the generated prescriptions/drugs types.
///
/// The public `core` api barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The prescription parity tests need the
/// generated clients + models to build fixtures that prove the adapter's
/// mapping matches the app's wire shape. This narrow barrel exposes exactly
/// those, without opening the whole generated surface to app code.
library;

export '../adapters/swagger_parser/generated/clients/prescriptions_client.dart';
export '../adapters/swagger_parser/generated/clients/shelters_client.dart';
export '../adapters/swagger_parser/generated/models/paginated_prescription_execution_today_list.dart';
export '../adapters/swagger_parser/generated/models/paginated_shelter_drug_list.dart';
export '../adapters/swagger_parser/generated/models/prescription_execution_today.dart';
export '../adapters/swagger_parser/generated/models/shelter_drug.dart';
