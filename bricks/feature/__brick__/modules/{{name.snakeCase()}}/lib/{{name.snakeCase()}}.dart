/// {{name.pascalCase()}} feature module.
///
/// Public API barrel. DTOs are contained in the data layer (core/api ports);
/// the domain, router contract, and screen entrypoint are exported for the root
/// app to wire.
library;

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
