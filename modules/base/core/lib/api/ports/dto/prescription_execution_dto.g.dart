// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_execution_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionExecutionDto _$PrescriptionExecutionDtoFromJson(
  Map<String, dynamic> json,
) => PrescriptionExecutionDto(
  executeAt: DateTime.parse(json['execute_at'] as String),
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$PrescriptionExecutionDtoToJson(
  PrescriptionExecutionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'execute_at': instance.executeAt.toIso8601String(),
  'status': instance.status,
};
