// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'prescription_short.dart';

part 'prescription_execution_today.g.dart';

/// PrescriptionExecution 'by day' serializer.
@JsonSerializable()
class PrescriptionExecutionToday {
  const PrescriptionExecutionToday({
    this.id,
    this.prescription,
    this.executeAt,
  });
  
  factory PrescriptionExecutionToday.fromJson(Map<String, Object?> json) => _$PrescriptionExecutionTodayFromJson(json);
  
  final int? id;
  final PrescriptionShort? prescription;
  @JsonKey(name: 'execute_at')
  final DateTime? executeAt;

  Map<String, Object?> toJson() => _$PrescriptionExecutionTodayToJson(this);
}
