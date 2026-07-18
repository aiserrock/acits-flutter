import 'package:json_annotation/json_annotation.dart';

import 'animal_short_dto.dart';
import 'prescription_drug_dto.dart';
import 'prescription_file_dto.dart';

part 'prescription_short_dto.g.dart';

/// Compact prescription embedded in a "today" execution.
///
/// OUR DTO — mirrors `PrescriptionShort`. Unlike [PrescriptionDto] it carries an
/// embedded [AnimalShortDto] (not a bare id). [myType] is the raw wire string.
@JsonSerializable(explicitToJson: true)
class PrescriptionShortDto {
  const PrescriptionShortDto({
    required this.animal,
    required this.drugs,
    this.id,
    this.myType,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.files,
    this.extraTypeAttributes,
  });

  factory PrescriptionShortDto.fromJson(Map<String, dynamic> json) => _$PrescriptionShortDtoFromJson(json);

  final int? id;
  @JsonKey(name: 'my_type')
  final String? myType;
  @JsonKey(name: 'extra_type_attributes')
  final Map<String, dynamic>? extraTypeAttributes;
  final String? description;
  final AnimalShortDto animal;
  @JsonKey(defaultValue: <PrescriptionDrugDto>[])
  final List<PrescriptionDrugDto> drugs;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  final List<PrescriptionFileDto>? files;

  Map<String, dynamic> toJson() => _$PrescriptionShortDtoToJson(this);
}
