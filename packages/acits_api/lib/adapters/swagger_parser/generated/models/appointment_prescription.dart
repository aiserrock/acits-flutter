// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'appointment_prescription_my_type_enum.dart';
import 'duration_enum.dart';
import 'prescription.dart';
import 'prescription_drug.dart';
import 'prescription_execution.dart';
import 'prescription_file.dart';

part 'appointment_prescription.g.dart';

/// Prescription serializer.
@JsonSerializable()
class AppointmentPrescription {
  const AppointmentPrescription({
    required this.id,
    required this.url,
    required this.animal,
    required this.myType,
    required this.createdBy,
    required this.updatedBy,
    required this.drugs,
    required this.executions,
    this.duration,
    this.description,
    this.files,
  });
  
  factory AppointmentPrescription.fromJson(Map<String, Object?> json) => _$AppointmentPrescriptionFromJson(json);
  
  final int id;
  final String url;
  final int animal;
  @JsonKey(name: 'my_type')
  final AppointmentPrescriptionMyTypeEnum myType;
  final DurationEnum? duration;
  final String? description;
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'updated_by')
  final String updatedBy;
  final List<PrescriptionDrug> drugs;
  final List<PrescriptionExecution> executions;
  final List<PrescriptionFile>? files;

  Map<String, Object?> toJson() => _$AppointmentPrescriptionToJson(this);
}
