// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentPrescription _$AppointmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => AppointmentPrescription(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  animal: (json['animal'] as num).toInt(),
  myType: AppointmentPrescriptionMyTypeEnum.fromJson(json['my_type'] as String),
  createdBy: json['created_by'] as String,
  updatedBy: json['updated_by'] as String,
  drugs: (json['drugs'] as List<dynamic>)
      .map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>)
      .map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AppointmentPrescriptionToJson(
  AppointmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': instance.myType,
  'duration': instance.duration,
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};
