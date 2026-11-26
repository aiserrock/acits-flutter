/// API layer: stable ports (`abstract interface <Feature>ApiPort`) + our DTOs.
///
/// The generator (`swagger_parser`) lives under `api/adapters/` and is the only
/// place generated code exists. Swapping generators = rewrite one adapter.
///
/// Public surface = ports + DTOs + the current adapter binding. The generated
/// code under `api/adapters/swagger_parser/generated/` is intentionally NOT
/// exported — only the adapter reaches into it.
library;

export 'api/adapters/swagger_parser/animal_api_adapter.dart';
export 'api/adapters/swagger_parser/animal_notes_api_adapter.dart';
export 'api/adapters/swagger_parser/auth_api_adapter.dart';
export 'api/adapters/swagger_parser/prescription_api_adapter.dart';
export 'api/adapters/swagger_parser/profile_api_adapter.dart';
export 'api/adapters/swagger_parser/selection_api_adapter.dart';
export 'api/adapters/swagger_parser/staff_api_adapter.dart';
export 'api/ports/animal_api_port.dart';
export 'api/ports/animal_notes_api_port.dart';
export 'api/ports/auth_api_port.dart';
export 'api/ports/prescription_api_port.dart';
export 'api/ports/profile_api_port.dart';
export 'api/ports/selection_api_port.dart';
export 'api/ports/staff_api_port.dart';
export 'api/ports/dto/dto.dart';

// The generated retrofit clients are exposed narrowly so root DI can construct
// them over the shared / guest / authed Dios and hand them to the adapters
// ([AnimalApiAdapter], [PrescriptionApiAdapter], [AuthApiAdapter],
// [StaffApiAdapter], ...). Only the client types leak — generated models stay
// private.
export 'api/adapters/swagger_parser/generated/exports.dart'
    show
        AnimalsClient,
        ApplicantsClient,
        CuratorsClient,
        PrescriptionsClient,
        SheltersClient,
        TokenClient,
        UsersClient,
        UsersRegistrationClient;
