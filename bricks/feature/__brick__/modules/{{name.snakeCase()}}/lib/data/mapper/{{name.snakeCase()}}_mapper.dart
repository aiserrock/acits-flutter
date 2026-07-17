import 'package:acits_api/acits_api.dart';
import 'package:acits_domain/acits_domain.dart' show Transformable;

import 'package:{{name.snakeCase()}}/domain/domain.dart';

/// DTO → [{{name.pascalCase()}}]. A separate mapper class (Transformable), not a
/// method on the DTO: the domain does not know about DTOs.
class {{name.pascalCase()}}Mapper implements Transformable<{{name.pascalCase()}}> {
  const {{name.pascalCase()}}Mapper(this._dto);

  final {{name.pascalCase()}}Dto _dto;

  @override
  {{name.pascalCase()}} toEntity() => {{name.pascalCase()}}(id: _dto.id, name: _dto.name ?? '');
}
