// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'animal_attribute.g.dart';

/// AnimalAttribute serializer.
@JsonSerializable()
class AnimalAttribute {
  const AnimalAttribute({
    required this.id,
    required this.name,
    this.isRequired,
  });
  
  factory AnimalAttribute.fromJson(Map<String, Object?> json) => _$AnimalAttributeFromJson(json);
  
  final int id;
  final String name;
  @JsonKey(name: 'is_required')
  final bool? isRequired;

  Map<String, Object?> toJson() => _$AnimalAttributeToJson(this);
}
