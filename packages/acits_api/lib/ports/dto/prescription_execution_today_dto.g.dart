// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_execution_today_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionExecutionTodayDto _$PrescriptionExecutionTodayDtoFromJson(Map<String, dynamic> json) =>
    PrescriptionExecutionTodayDto(
      prescription: PrescriptionShortDto.fromJson(json['prescription'] as Map<String, dynamic>),
      executeAt: DateTime.parse(json['execute_at'] as String),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrescriptionExecutionTodayDtoToJson(PrescriptionExecutionTodayDto instance) => <String, dynamic>{
  'id': instance.id,
  'prescription': instance.prescription.toJson(),
  'execute_at': instance.executeAt.toIso8601String(),
};
