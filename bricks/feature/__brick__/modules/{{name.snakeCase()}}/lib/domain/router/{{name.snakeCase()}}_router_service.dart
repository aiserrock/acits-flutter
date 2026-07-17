import 'package:acits_domain/acits_domain.dart';

/// Navigation contract for the {{name.pascalCase()}} feature. The implementation
/// (which knows the app's go_router paths) lives in the root navigation layer
/// and is injected into the module — so the module depends neither on go_router
/// nor on app routes.
abstract interface class {{name.pascalCase()}}RouterService implements RouterService {
  /// Open the detail screen for [id].
  void openDetail(int id);
}
