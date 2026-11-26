// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'animal_image_write.g.dart';

/// Animal Image write serializer.
@JsonSerializable()
class AnimalImageWrite {
  const AnimalImageWrite({
    required this.name,
    required this.image,
    this.isPrimary,
  });
  
  factory AnimalImageWrite.fromJson(Map<String, Object?> json) => _$AnimalImageWriteFromJson(json);
  
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;
  final String name;
  final String image;

  Map<String, Object?> toJson() => _$AnimalImageWriteToJson(this);
}
