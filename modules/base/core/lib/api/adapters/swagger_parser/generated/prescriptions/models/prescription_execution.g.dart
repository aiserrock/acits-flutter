// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionExecution _$PrescriptionExecutionFromJson(
  Map<String, dynamic> json,
) => PrescriptionExecution(
  id: PrescriptionExecution._read_id(json['id']),
  executeAt: PrescriptionExecution._read_executeAt(json['execute_at']),
  status: PrescriptionExecution._read_status(json['status']),
  additionalProperties:
      PrescriptionExecution._extras(json, 'additionalProperties') == null
      ? const {}
      : PrescriptionExecution._readExtras(
          PrescriptionExecution._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PrescriptionExecutionToJson(
  PrescriptionExecution instance,
) => <String, dynamic>{
  'id': ?PrescriptionExecution._write_id(instance.id),
  'execute_at': ?PrescriptionExecution._write_executeAt(instance.executeAt),
  'status': ?PrescriptionExecution._write_status(instance.status),
};
