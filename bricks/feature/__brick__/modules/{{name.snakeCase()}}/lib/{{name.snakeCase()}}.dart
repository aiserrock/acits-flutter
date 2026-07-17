/// {{name.pascalCase()}} feature module.
///
/// Public API barrel. DTOs are contained in the data layer (acits_api ports);
/// the domain, router contract, and screen entrypoint are exported for the root
/// app to wire.
library;

export 'domain/{{name.snakeCase()}}.dart';
export 'domain/{{name.snakeCase()}}_repository.dart';
export 'domain/router/{{name.snakeCase()}}_router_service.dart';
export 'data/repository/{{name.snakeCase()}}_repository_impl.dart';
export 'data/data_source/{{name.snakeCase()}}_remote_data_source.dart';
export 'ui/{{screen.snakeCase()}}/view/{{screen.snakeCase()}}_page.dart';
