import 'package:json_annotation/json_annotation.dart';

import 'prescription_drug_dto.dart';
import 'prescription_execution_dto.dart';
import 'prescription_file_dto.dart';

part 'prescription_dto.g.dart';

/// A prescription (read shape) — flat over the polymorphic backend `oneOf`.
///
/// OUR DTO. On the wire `Prescription` is a `oneOf` of 9 subtypes discriminated
/// by `my_type`; all subtypes carry the same field set and differ only by
/// `my_type` + `extra_type_attributes`. We model it as ONE flat DTO with
/// [myType] kept as the raw wire string so unknown/absent discriminators never
/// crash deserialization (the generated sealed type throws on those).
@JsonSerializable(explicitToJson: true)
class PrescriptionDto {
  const PrescriptionDto({
    required this.animal,
    required this.drugs,
    required this.executions,
    this.id,
    this.url,
    this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.files,
    this.extraTypeAttributes,
  });

  factory PrescriptionDto.fromJson(Map<String, dynamic> json) => _$PrescriptionDtoFromJson(json);

  final int? id;
  final String? url;

  /// Animal id the prescription belongs to.
  final int animal;

  /// Raw wire discriminator (e.g. `COURSE_OF_TREATMENT`). Nullable/tolerant.
  @JsonKey(name: 'my_type')
  final String? myType;

  /// Raw wire duration (e.g. `EVERY_WEEK`, `CUSTOM`). Kept as string.
  final String? duration;
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(defaultValue: <PrescriptionDrugDto>[])
  final List<PrescriptionDrugDto> drugs;
  @JsonKey(defaultValue: <PrescriptionExecutionDto>[])
  final List<PrescriptionExecutionDto> executions;
  final List<PrescriptionFileDto>? files;

  /// Type-specific attributes (shape depends on [myType]).
  @JsonKey(name: 'extra_type_attributes')
  final Map<String, dynamic>? extraTypeAttributes;

  Map<String, dynamic> toJson() => _$PrescriptionDtoToJson(this);
}
