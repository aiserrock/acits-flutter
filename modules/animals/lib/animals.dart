/// Animals feature module (reference slice): list / detail / edit.
///
/// Public API barrel. DTOs are contained in the data layer (acits_api ports);
/// UI and the router contract are exported for the root app to wire.
library;

export 'data/data_source/animal_remote_data_source.dart';
export 'data/repository/animal_repository_impl.dart';
export 'domain/animal.dart';
export 'domain/animal_contact.dart';
export 'domain/animal_edit_input.dart';
export 'domain/animal_image.dart';
export 'domain/animal_list_item.dart';
export 'domain/animal_repository.dart';
export 'domain/animal_species.dart';
export 'domain/animal_status.dart';
export 'domain/port/animal_permissions.dart';
export 'domain/port/animal_status_labels.dart';
export 'domain/port/current_shelter_provider.dart';
export 'domain/router/animals_router_service.dart';
export 'ui/animals_list/view/animals_page.dart';
