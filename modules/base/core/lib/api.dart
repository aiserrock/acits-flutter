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

// The generated retrofit [AnimalsClient] is exposed narrowly so the app's DI
// can construct it over the shared base Dio and hand it to
// [AnimalApiAdapter]. Only the client type leaks — generated models stay private.
export 'api/adapters/swagger_parser/generated/clients/animals_client.dart' show AnimalsClient;

// The generated retrofit [PrescriptionsClient] is exposed narrowly so root DI
// can construct it over the authed acitsApi Dio and hand it to
// [PrescriptionApiAdapter] (drugs + today-executions paths). Only the client
// type leaks — generated models stay private.
export 'api/adapters/swagger_parser/generated/clients/prescriptions_client.dart' show PrescriptionsClient;

// The generated retrofit auth clients are exposed narrowly so root DI can
// construct them over the guest/authed Dios and hand them to [AuthApiAdapter].
// Only the client types leak — generated models stay private.
export 'api/adapters/swagger_parser/generated/clients/shelters_client.dart' show SheltersClient;
export 'api/adapters/swagger_parser/generated/clients/token_client.dart' show TokenClient;
export 'api/adapters/swagger_parser/generated/clients/users_client.dart' show UsersClient;
export 'api/adapters/swagger_parser/generated/clients/users_registration_client.dart' show UsersRegistrationClient;

// The generated retrofit staff clients are exposed narrowly so root DI can
// construct them over the authed acitsApi Dio and hand them to [StaffApiAdapter].
// Only the client types leak — generated models stay private.
export 'api/adapters/swagger_parser/generated/clients/applicants_client.dart' show ApplicantsClient;
export 'api/adapters/swagger_parser/generated/clients/curators_client.dart' show CuratorsClient;
