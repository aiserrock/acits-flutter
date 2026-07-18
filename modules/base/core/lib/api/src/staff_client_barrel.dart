/// Test-only re-export of the generated staff types.
///
/// The public `core` api barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The staff parity tests need the
/// generated clients + models to build fixtures that prove the adapter's
/// mapping matches the app's wire shape. This narrow barrel exposes exactly
/// those, without opening the whole generated surface to app code.
library;

export '../adapters/swagger_parser/generated/clients/applicants_client.dart';
export '../adapters/swagger_parser/generated/clients/curators_client.dart';
export '../adapters/swagger_parser/generated/models/applicant.dart';
export '../adapters/swagger_parser/generated/models/curator.dart';
export '../adapters/swagger_parser/generated/models/paginated_applicant_list.dart';
export '../adapters/swagger_parser/generated/models/paginated_curator_list.dart';
