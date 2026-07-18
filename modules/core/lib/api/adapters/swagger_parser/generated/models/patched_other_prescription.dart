// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'duration_enum.dart';
import 'other_prescription_my_type_enum.dart';
import 'patched_prescription.dart';
import 'prescription_drug.dart';
import 'prescription_execution.dart';
import 'prescription_file.dart';

part 'patched_other_prescription.g.dart';

/// Prescription serializer.
@JsonSerializable()
class PatchedOtherPrescription {
  const PatchedOtherPrescription({
    this.id,
    this.url,
    this.animal,
    this.myType,
    this.duration,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.drugs,
    this.executions,
    this.files,
  });
  
  factory PatchedOtherPrescription.fromJson(Map<String, Object?> json) => _$PatchedOtherPrescriptionFromJson(json);
  
  final int? id;
  final String? url;
  final int? animal;
  @JsonKey(name: 'my_type')
  final OtherPrescriptionMyTypeEnum? myType;
  final DurationEnum? duration;
  final String? description;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  final List<PrescriptionDrug>? drugs;
  final List<PrescriptionExecution>? executions;
  final List<PrescriptionFile>? files;

  Map<String, Object?> toJson() => _$PatchedOtherPrescriptionToJson(this);
}
