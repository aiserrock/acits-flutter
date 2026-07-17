/// Personal cabinet + calendar + animal comments feature module: the user
/// profile screen and its [PersonalService] (over the stable `ProfileApiPort`),
/// the change-password dialog, the calendar placeholder, and the animal
/// comments list/edit screens with their [CommentsService] (over the stable
/// `AnimalNotesApiPort`).
///
/// Public API barrel. DTOs stay in acits_api; domain entities, the services
/// (also used by the app shell / drawer, detail screen, and router), the port /
/// router contracts, cubits, widgets and screens are exported for the root app
/// to wire.
library;

export 'data/comments_service.dart';
export 'data/personal_service.dart';
export 'domain/animal_note.dart';
export 'domain/animal_note_file.dart';
export 'domain/comment_file_opener.dart';
export 'domain/personal_shelter_provider.dart';
export 'domain/router/personal_router_service.dart';
export 'domain/user_profile.dart';
export 'ui/calendar/calendar_screen.dart';
export 'ui/comments/comment_edit_screen.dart';
export 'ui/comments/comment_list.dart';
export 'ui/comments/cubit/comment_edit_cubit.dart';
export 'ui/comments/cubit/comment_edit_state.dart';
export 'ui/comments/cubit/comment_list_cubit.dart';
export 'ui/comments/cubit/comment_list_state.dart';
export 'ui/personal/change_pass_widget.dart';
export 'ui/personal/cubit/change_pass_cubit.dart';
export 'ui/personal/cubit/personal_cubit.dart';
export 'ui/personal/cubit/personal_state.dart';
export 'ui/personal/personal_screen.dart';
