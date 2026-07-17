import 'package:json_annotation/json_annotation.dart';

import 'animal_attribute_dto.dart';
import 'animal_image_dto.dart';
import 'applicant_dto.dart';
import 'curator_dto.dart';
import 'species_dto.dart';

part 'animal_dto.g.dart';

/// An animal (read shape) — the root DTO of the animals reference slice.
///
/// OUR DTO — mirrors `AnimalRead` on the wire, generator-agnostic. `status` is
/// kept as the raw wire string (e.g. `IN_THE_SHELTER`) so unknown backend
/// values round-trip without loss; callers map it to a domain enum upstream.
/// Nullability follows the app's authoritative model: `spec`/`curator`/
/// `applicant`/`hasDocuments` are nullable because real payloads omit them.
@JsonSerializable(explicitToJson: true)
class AnimalDto {
  const AnimalDto({
    required this.id,
    required this.uuid,
    required this.url,
    required this.images,
    required this.dateJoined,
    required this.placeOfCatch,
    required this.shelter,
    required this.animalAttributes,
    this.name,
    this.spec,
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
    this.hasDocuments,
    this.curator,
    this.applicant,
    this.deletedAt,
    this.adoption,
    this.release,
    this.overstay,
    this.canBeShared,
  });

  factory AnimalDto.fromJson(Map<String, dynamic> json) => _$AnimalDtoFromJson(json);

  final int id;
  final String uuid;
  final String url;
  final String? name;
  @JsonKey(defaultValue: <AnimalImageDto>[])
  final List<AnimalImageDto> images;
  final SpeciesDto? spec;

  /// Raw wire status value (e.g. `IN_THE_SHELTER`, `HOSPITAL`, `RELEASED`).
  final String? status;
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
  @JsonKey(name: 'has_documents')
  final bool? hasDocuments;
  final int shelter;
  final CuratorDto? curator;
  final ApplicantDto? applicant;
  @JsonKey(name: 'animal_attributes', defaultValue: <AnimalAttributeDto>[])
  final List<AnimalAttributeDto> animalAttributes;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  /// URI of the related adoption record, if any.
  final String? adoption;

  /// URI of the related release record, if any.
  final String? release;

  /// URI of the related overstay record, if any.
  final String? overstay;
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;

  Map<String, dynamic> toJson() => _$AnimalDtoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnimalDto &&
        other.id == id &&
        other.uuid == uuid &&
        other.url == url &&
        other.name == name &&
        _listEquals(other.images, images) &&
        other.spec == spec &&
        other.status == status &&
        other.dateJoined == dateJoined &&
        other.birthDate == birthDate &&
        other.deathDate == deathDate &&
        other.deathReason == deathReason &&
        other.defaultImageId == defaultImageId &&
        other.placeOfCatch == placeOfCatch &&
        other.placeOfRelease == placeOfRelease &&
        other.dateOfChipping == dateOfChipping &&
        other.chippingCode == chippingCode &&
        other.height == height &&
        other.weight == weight &&
        other.hasDocuments == hasDocuments &&
        other.shelter == shelter &&
        other.curator == curator &&
        other.applicant == applicant &&
        _listEquals(other.animalAttributes, animalAttributes) &&
        other.deletedAt == deletedAt &&
        other.adoption == adoption &&
        other.release == release &&
        other.overstay == overstay &&
        other.canBeShared == canBeShared;
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    uuid,
    url,
    name,
    Object.hashAll(images),
    spec,
    status,
    dateJoined,
    birthDate,
    deathDate,
    deathReason,
    defaultImageId,
    placeOfCatch,
    placeOfRelease,
    dateOfChipping,
    chippingCode,
    height,
    weight,
    hasDocuments,
    shelter,
    curator,
    applicant,
    Object.hashAll(animalAttributes),
    deletedAt,
    adoption,
    release,
    overstay,
    canBeShared,
  ]);
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
