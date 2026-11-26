// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_execution_today.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionExecutionToday _$PrescriptionExecutionTodayFromJson(
  Map<String, dynamic> json,
) {
  $checkKeys(json, disallowNullValues: const ['prescription']);
  return PrescriptionExecutionToday(
    id: PrescriptionExecutionToday._read_id(json['id']),
    prescription: json['prescription'] == null
        ? null
        : PrescriptionShort.fromJson(
            json['prescription'] as Map<String, dynamic>,
          ),
    executeAt: PrescriptionExecutionToday._read_executeAt(json['execute_at']),
    additionalProperties:
        PrescriptionExecutionToday._extras(json, 'additionalProperties') == null
        ? const {}
        : PrescriptionExecutionToday._readExtras(
            PrescriptionExecutionToday._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$PrescriptionExecutionTodayToJson(
  PrescriptionExecutionToday instance,
) => <String, dynamic>{
  'id': ?PrescriptionExecutionToday._write_id(instance.id),
  'prescription': ?instance.prescription?.toJson(),
  'execute_at': ?PrescriptionExecutionToday._write_executeAt(
    instance.executeAt,
  ),
};
