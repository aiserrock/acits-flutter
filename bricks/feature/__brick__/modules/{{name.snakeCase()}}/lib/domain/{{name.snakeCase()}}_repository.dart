import 'package:acits_core/acits_core.dart';

import '{{name.snakeCase()}}.dart';

/// Repository contract for {{name.pascalCase()}} (feature-local). Everything in
/// domain types and Result<Failure, T> — DTOs never reach here (they stop in
/// the data layer).
abstract interface class {{name.pascalCase()}}Repository {
  Future<Result<Failure, List<{{name.pascalCase()}}>>> list({int? shelterId});

  Future<Result<Failure, {{name.pascalCase()}}>> getById(int id, {int? shelterId});
}
