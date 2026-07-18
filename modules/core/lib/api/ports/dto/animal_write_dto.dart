import 'package:json_annotation/json_annotation.dart';

import 'animal_attribute_dto.dart';
import 'animal_image_write_dto.dart';

part 'animal_write_dto.g.dart';

/// An animal (write shape) — the payload for create/update.
///
/// OUR DTO — mirrors `AnimalWrite` on the wire, generator-agnostic. [status] is
/// kept as the raw wire string (e.g. `IN_THE_SHELTER`) so callers pass a domain
/// value without touching the generated enum. Required fields (specId,
/// dateJoined, placeOfCatch, shelter, animalAttributes) match the generated
/// serializer; everything else is optional.
@JsonSerializable(explicitToJson: true)
class AnimalWriteDto {
  const AnimalWriteDto({
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

  factory AnimalWriteDto.fromJson(Map<String, dynamic> json) => _$AnimalWriteDtoFromJson(json);

  final String? name;

  /// New images to upload (base64). Existing images to keep go in [validImages].
  final List<AnimalImageWriteDto>? images;

  /// Ids of already-uploaded images to retain on update.
  @JsonKey(name: 'valid_images')
  final List<int>? validImages;
  @JsonKey(name: 'spec_id')
  final int specId;

  /// Raw wire status value (e.g. `IN_THE_SHELTER`); adapter maps it to the enum.
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
  final int shelter;
  @JsonKey(name: 'curator_id')
  final int? curatorId;
  @JsonKey(name: 'applicant_id')
  final int? applicantId;
  @JsonKey(name: 'animal_attributes')
  final List<AnimalAttributeDto> animalAttributes;
  @JsonKey(name: 'can_be_shared')
  final bool? canBeShared;

  Map<String, dynamic> toJson() => _$AnimalWriteDtoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnimalWriteDto &&
        other.name == name &&
        _listEquals(other.images, images) &&
        _listEquals(other.validImages, validImages) &&
        other.specId == specId &&
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
        other.shelter == shelter &&
        other.curatorId == curatorId &&
        other.applicantId == applicantId &&
        _listEquals(other.animalAttributes, animalAttributes) &&
        other.canBeShared == canBeShared;
  }

  @override
  int get hashCode => Object.hashAll([
    name,
    if (images != null) Object.hashAll(images!) else null,
    if (validImages != null) Object.hashAll(validImages!) else null,
    specId,
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
    shelter,
    curatorId,
    applicantId,
    Object.hashAll(animalAttributes),
    canBeShared,
  ]);
}

bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
