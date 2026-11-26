import 'package:json_annotation/json_annotation.dart';

part 'animal_attribute_dto.g.dart';

/// A resolved attribute value embedded in an animal (`animal_attributes[]`).
///
/// OUR DTO — mirrors `AnimalAttributeValue` on the wire (the shape nested
/// inside `AnimalRead`, not the standalone `AnimalAttribute` catalog entry).
@JsonSerializable()
class AnimalAttributeDto {
  const AnimalAttributeDto({required this.attrId, required this.name, required this.value, required this.isRequired});

  factory AnimalAttributeDto.fromJson(Map<String, dynamic> json) => _$AnimalAttributeDtoFromJson(json);

  @JsonKey(name: 'attr_id')
  final int attrId;
  final String name;
  final String value;
  @JsonKey(name: 'is_required')
  final bool isRequired;

  Map<String, dynamic> toJson() => _$AnimalAttributeDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalAttributeDto &&
          other.attrId == attrId &&
          other.name == name &&
          other.value == value &&
          other.isRequired == isRequired;

  @override
  int get hashCode => Object.hash(attrId, name, value, isRequired);
}
