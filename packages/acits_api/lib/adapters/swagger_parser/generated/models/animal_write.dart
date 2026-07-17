// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_attribute_value.dart';
import 'animal_image_write.dart';
import 'status69f_enum.dart';

part 'animal_write.g.dart';

/// Animal write serializer.
@JsonSerializable()
class AnimalWrite {
  const AnimalWrite({
    required this.specId,
    required this.dateJoined,
    required this.placeOfCatch,
    required this.shelter,
    required this.animalAttributes,
    this.name,
    this.images,
    this.validImages,
    this.status,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.curatorId,
    this.applicantId,
    this.canBeShared,
  });
  
  factory AnimalWrite.fromJson(Map<String, Object?> json) => _$AnimalWriteFromJson(json);
  
  final String? name;
  final List<AnimalImageWrite>? images;
  @JsonKey(name: 'valid_images')
  final List<int>? validImages;
  @JsonKey(name: 'spec_id')
  final int specId;
  final Status69fEnum? status;
  @JsonKey(name: 'date_joined')
  final DateTime dateJoined;
  @JsonKey(name: 'birth_date')
  final DateTime? birthDate;
  @JsonKey(name: 'death_date')
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String placeOfCatch;
  @JsonKey(name: 'place_of_release')
  final String? placeOfRelease;
  @JsonKey(name: 'date_of_chipping')
  final DateTime? dateOfChipping;
  @JsonKey(name: 'chipping_code')
  final String? chippingCode;
  final String? height;
  final String? weight;
  final int shelter;
  @JsonKey(name: 'curator_id')
  final int? curatorId;
  @JsonKey(name: 'applicant_id')
  final int? applicantId;
  @JsonKey(name: 'animal_attributes')
  final List<AnimalAttributeValue> animalAttributes;
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;

  Map<String, Object?> toJson() => _$AnimalWriteToJson(this);
}
