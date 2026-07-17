import 'package:equatable/equatable.dart';

/// Feature-local entity for {{name.pascalCase()}}. Plain immutable domain type —
/// no JSON, no DTO knowledge (mapping lives in data/mapper). Shared entities go
/// in acits_domain instead.
class {{name.pascalCase()}} extends Equatable {
  const {{name.pascalCase()}}({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
