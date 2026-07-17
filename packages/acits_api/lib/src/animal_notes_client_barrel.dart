/// Test-only re-export of the generated animal-notes types.
///
/// The public `acits_api` barrel hides the generated swagger_parser models —
/// only the adapter reaches into them. The notes parity tests need the
/// generated client + models to build fixtures that prove the adapter's
/// mapping matches the app's wire shape. This narrow barrel exposes exactly
/// those, without opening the whole generated surface to app code.
library;

export '../adapters/swagger_parser/generated/clients/animals_client.dart';
export '../adapters/swagger_parser/generated/models/animal_note.dart';
export '../adapters/swagger_parser/generated/models/paginated_animal_note_list.dart';
