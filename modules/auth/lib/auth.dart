/// Auth feature module: login / registration / email confirmation / splash /
/// onboarding / pick-shelter.
///
/// Public API barrel. Session state stays in the app behind [AuthSessionApi];
/// UI screens and the navigation/port contracts are exported for the root app
/// to wire.
library;

export 'domain/auth_ports.dart' show AuthDebugHook, AuthDeepLinkHandler, AuthConfigInitializer;
export 'domain/auth_router_service.dart';
export 'domain/auth_session_api.dart';
export 'domain/registration_input.dart';
export 'domain/splash_navigator.dart';
export 'ui/login/view/login_screen.dart';
export 'ui/onboarding/bloc/onboarding_bloc.dart';
export 'ui/onboarding/model/onboarding_data.dart';
export 'ui/onboarding/onboarding_screen.dart';
export 'ui/pick_shelter/pick_shelter_screen.dart';
export 'ui/registration/email_confirmation_screen.dart';
export 'ui/registration/registration_screen.dart';
export 'ui/splash/splash_screen.dart';
