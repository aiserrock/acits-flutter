// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'animal_attribute_value.g.dart';

/// AnimalAttributeValue serializer.
@JsonSerializable()
class AnimalAttributeValue {
  const AnimalAttributeValue({
    required this.attrId,
    required this.name,
    required this.value,
    required this.isRequired,
  });
  
  factory AnimalAttributeValue.fromJson(Map<String, Object?> json) => _$AnimalAttributeValueFromJson(json);
  
  @JsonKey(name: 'attr_id')
  final int attrId;
  final String name;
  final String value;
  @JsonKey(name: 'is_required')
  final bool isRequired;

  Map<String, Object?> toJson() => _$AnimalAttributeValueToJson(this);
}
