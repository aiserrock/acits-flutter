/// Auth feature module: login / registration / email confirmation / splash /
/// onboarding / pick-shelter.
///
/// Public API barrel. Session state stays in the app behind [AuthSessionApi];
/// UI screens and the navigation/port contracts are exported for the root app
/// to wire.
library;

export 'domain/domain.dart';
export 'presentation/presentation.dart';
