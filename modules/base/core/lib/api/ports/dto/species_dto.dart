import 'package:json_annotation/json_annotation.dart';

part 'species_dto.g.dart';

/// Species (breed/category) attached to an animal.
///
/// OUR DTO — mirrors `Species` on the wire. `level` is kept as the raw wire
/// int (1/2/3) so unknown backend values never crash deserialization.
@JsonSerializable()
class SpeciesDto {
  const SpeciesDto({
    required this.id,
    required this.name,
    required this.level,
    this.parentId,
    this.parentName,
    this.categoryName,
  });

  factory SpeciesDto.fromJson(Map<String, dynamic> json) => _$SpeciesDtoFromJson(json);

  final int id;
  final String name;

  /// Depth of the species in the taxonomy tree (1 = one, 2 = two, 3 = three).
  final int level;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'parent_name')
  final String? parentName;
  @JsonKey(name: 'category_name')
  final String? categoryName;

  Map<String, dynamic> toJson() => _$SpeciesDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeciesDto &&
          other.id == id &&
          other.name == name &&
          other.level == level &&
          other.parentId == parentId &&
          other.parentName == parentName &&
          other.categoryName == categoryName;

  @override
  int get hashCode => Object.hash(id, name, level, parentId, parentName, categoryName);
}
