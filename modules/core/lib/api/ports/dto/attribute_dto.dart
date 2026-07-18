import 'package:json_annotation/json_annotation.dart';

part 'attribute_dto.g.dart';

/// A catalog animal-attribute definition (`/api/v1/animals/attributes/`).
///
/// OUR DTO — mirrors the standalone `AnimalAttribute` catalog entry (id + name +
/// is_required), distinct from [AnimalAttributeDto] which is the resolved value
/// embedded inside an animal.
@JsonSerializable()
class AttributeDto {
  const AttributeDto({required this.id, required this.name, this.isRequired});

  factory AttributeDto.fromJson(Map<String, dynamic> json) => _$AttributeDtoFromJson(json);

  final int id;
  final String name;
  @JsonKey(name: 'is_required')
  final bool? isRequired;

  Map<String, dynamic> toJson() => _$AttributeDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeDto && other.id == id && other.name == name && other.isRequired == isRequired;

  @override
  int get hashCode => Object.hash(id, name, isRequired);
}
