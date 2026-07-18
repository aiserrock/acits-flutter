import 'package:core/api.dart';

// After scaffolding: add `{{name.pascalCase()}}ApiPort` + `{{name.pascalCase()}}Dto` to
// packages/acits_api (ports/ + ports/dto/) and its swagger_parser adapter, then
// replace the placeholders below. See CLAUDE.md → "Ritual: add an endpoint".

/// Thin wrapper over `{{name.pascalCase()}}ApiPort`: only calls, no logic/mapping.
/// Returns DTOs — the repository unwraps DTO → entity (DTOs stop there).
class {{name.pascalCase()}}RemoteDataSource {
  const {{name.pascalCase()}}RemoteDataSource(this._port);

  final {{name.pascalCase()}}ApiPort _port;

  Future<List<{{name.pascalCase()}}Dto>> list({int? shelterId}) => _port.list(shelterId: shelterId);

  Future<{{name.pascalCase()}}Dto> getById(int id, {int? shelterId}) => _port.getById(id, shelterId: shelterId);
}
