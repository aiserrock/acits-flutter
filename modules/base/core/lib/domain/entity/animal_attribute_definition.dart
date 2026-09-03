import 'package:equatable/equatable.dart';

/// A catalog animal-attribute definition: what attributes a shelter's animals
/// can carry, and which of them are mandatory.
///
/// Domain view of the attribute catalog — distinct from an attribute *value*
/// resolved on a specific animal.
class AnimalAttributeDefinition extends Equatable {
  const AnimalAttributeDefinition({required this.id, required this.name, this.isRequired = false});

  final int id;
  final String name;
  final bool isRequired;

  @override
  List<Object?> get props => [id, name, isRequired];
}
