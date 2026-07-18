// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_execution_today.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionExecutionToday _$PrescriptionExecutionTodayFromJson(
  Map<String, dynamic> json,
) => PrescriptionExecutionToday(
  id: (json['id'] as num).toInt(),
  prescription: PrescriptionShort.fromJson(
    json['prescription'] as Map<String, dynamic>,
  ),
  executeAt: DateTime.parse(json['execute_at'] as String),
);

Map<String, dynamic> _$PrescriptionExecutionTodayToJson(
  PrescriptionExecutionToday instance,
) => <String, dynamic>{
  'id': instance.id,
  'prescription': instance.prescription,
  'execute_at': instance.executeAt.toIso8601String(),
};
