// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionExecution _$PrescriptionExecutionFromJson(
  Map<String, dynamic> json,
) => PrescriptionExecution(
  id: (json['id'] as num).toInt(),
  executeAt: DateTime.parse(json['execute_at'] as String),
  status: PrescriptionExecutionStatusEnum.fromJson(json['status'] as String),
);

Map<String, dynamic> _$PrescriptionExecutionToJson(
  PrescriptionExecution instance,
) => <String, dynamic>{
  'id': instance.id,
  'execute_at': instance.executeAt.toIso8601String(),
  'status': instance.status,
};
