// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'animal_short.g.dart';

/// PrescriptionAnimal serializer.
@JsonSerializable()
class AnimalShort {
  const AnimalShort({
    this.id,
    this.uuid,
    this.name,
    this.specName,
    this.specParentName,
    this.avatar,
    this.defaultImageId,
  });
  
  factory AnimalShort.fromJson(Map<String, Object?> json) => _$AnimalShortFromJson(json);
  
  final int? id;
  final String? uuid;
  final String? name;
  @JsonKey(name: 'spec_name')
  final String? specName;
  @JsonKey(name: 'spec_parent_name')
  final String? specParentName;

  /// Method returning small image url of animal's avatar.
  final String? avatar;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;

  Map<String, Object?> toJson() => _$AnimalShortToJson(this);
}
