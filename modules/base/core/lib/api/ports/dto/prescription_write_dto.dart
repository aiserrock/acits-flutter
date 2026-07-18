import 'package:json_annotation/json_annotation.dart';

import 'prescription_drug_dto.dart';
import 'prescription_execution_dto.dart';
import 'prescription_file_dto.dart';

part 'prescription_write_dto.g.dart';

/// A prescription (write shape) for create/update.
///
/// OUR DTO. Sent as flat JSON — the backend routes on [myType]. [id] is present
/// only on update. Mirrors the payload the app historically posted by hand
/// (the generated `Prescription` write type could not express the `oneOf`).
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class PrescriptionWriteDto {
  const PrescriptionWriteDto({
    required this.animal,
    required this.myType,
    required this.drugs,
    required this.executions,
    this.id,
    this.duration,
    this.description,
    this.files,
    this.extraTypeAttributes,
  });

  factory PrescriptionWriteDto.fromJson(Map<String, dynamic> json) => _$PrescriptionWriteDtoFromJson(json);

  final int? id;
  final int animal;
  @JsonKey(name: 'my_type')
  final String myType;
  final String? duration;
  final String? description;
  final List<PrescriptionDrugDto> drugs;
  final List<PrescriptionExecutionDto> executions;
  final List<PrescriptionFileDto>? files;
  @JsonKey(name: 'extra_type_attributes')
  final Map<String, dynamic>? extraTypeAttributes;

  Map<String, dynamic> toJson() => _$PrescriptionWriteDtoToJson(this);
}
