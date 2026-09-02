// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'prescription_execution_status_enum.dart';

part 'prescription_execution.g.dart';

/// PrescriptionExecution serializer.
@JsonSerializable()
class PrescriptionExecution {
  const PrescriptionExecution({
    this.id,
    this.executeAt,
    this.status,
  });
  
  factory PrescriptionExecution.fromJson(Map<String, Object?> json) => _$PrescriptionExecutionFromJson(json);
  
  final int? id;
  @JsonKey(name: 'execute_at')
  final DateTime? executeAt;
  final PrescriptionExecutionStatusEnum? status;

  Map<String, Object?> toJson() => _$PrescriptionExecutionToJson(this);
}
