// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'animal_attribute_value.dart';
import 'animal_image_read.dart';
import 'applicant.dart';
import 'curator.dart';
import 'species.dart';
import 'status69f_enum.dart';

part 'animal_read.g.dart';

/// Animal read serializer.
@JsonSerializable()
class AnimalRead {
  const AnimalRead({
    this.id,
    this.uuid,
    this.url,
    this.name,
    this.images,
    this.spec,
    this.status,
    this.dateJoined,
    this.birthDate,
    this.deathDate,
    this.deathReason,
    this.defaultImageId,
    this.placeOfCatch,
    this.placeOfRelease,
    this.dateOfChipping,
    this.chippingCode,
    this.height,
    this.weight,
    this.hasDocuments,
    this.shelter,
    this.curator,
    this.applicant,
    this.animalAttributes,
    this.deletedAt,
    this.adoption,
    this.release,
    this.overstay,
    this.canBeShared,
  });
  
  factory AnimalRead.fromJson(Map<String, Object?> json) => _$AnimalReadFromJson(json);
  
  final int? id;
  final String? uuid;
  final String? url;
  final String? name;
  final List<AnimalImageRead>? images;
  final Species? spec;
  final Status69fEnum? status;
  @JsonKey(name: 'date_joined')
  final DateTime? dateJoined;
  @JsonKey(name: 'birth_date')
  final DateTime? birthDate;
  @JsonKey(name: 'death_date')
  final DateTime? deathDate;
  @JsonKey(name: 'death_reason')
  final String? deathReason;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;
  @JsonKey(name: 'place_of_catch')
  final String? placeOfCatch;
  @JsonKey(name: 'place_of_release')
  final String? placeOfRelease;
  @JsonKey(name: 'date_of_chipping')
  final DateTime? dateOfChipping;
  @JsonKey(name: 'chipping_code')
  final String? chippingCode;
  final String? height;
  final String? weight;
  @JsonKey(name: 'has_documents')
  final bool? hasDocuments;
  final int? shelter;
  final Curator? curator;
  final Applicant? applicant;
  @JsonKey(name: 'animal_attributes')
  final List<AnimalAttributeValue>? animalAttributes;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  final String? adoption;
  final String? release;
  final String? overstay;
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;

  Map<String, Object?> toJson() => _$AnimalReadToJson(this);
}
