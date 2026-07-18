/// Personal cabinet + calendar + animal comments feature module: the user
/// profile screen and its [PersonalService] (over the stable `ProfileApiPort`),
/// the change-password dialog, the calendar placeholder, and the animal
/// comments list/edit screens with their [CommentsService] (over the stable
/// `AnimalNotesApiPort`).
///
/// Public API barrel. DTOs stay in core (api ports); domain entities, the services
/// (also used by the app shell / drawer, detail screen, and router), the port /
/// router contracts, cubits, widgets and screens are exported for the root app
/// to wire.
library;

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
