// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parasites_treatment_prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParasitesTreatmentPrescription _$ParasitesTreatmentPrescriptionFromJson(
  Map<String, dynamic> json,
) => ParasitesTreatmentPrescription(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  animal: (json['animal'] as num?)?.toInt(),
  myType: json['my_type'] == null
      ? null
      : ParasitesTreatmentPrescriptionMyTypeEnum.fromJson(
          json['my_type'] as String,
        ),
  extraTypeAttributes: json['extra_type_attributes'] == null
      ? null
      : ParasitesPrescriptionExtraAttr.fromJson(
          json['extra_type_attributes'] as Map<String, dynamic>,
        ),
  duration: json['duration'] == null
      ? null
      : DurationEnum.fromJson(json['duration'] as String),
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  drugs: (json['drugs'] as List<dynamic>?)
      ?.map((e) => PrescriptionDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>?)
      ?.map((e) => PrescriptionExecution.fromJson(e as Map<String, dynamic>))
      .toList(),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFile.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ParasitesTreatmentPrescriptionToJson(
  ParasitesTreatmentPrescription instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'animal': instance.animal,
  'my_type': instance.myType,
  'extra_type_attributes': instance.extraTypeAttributes,
  'duration': instance.duration,
  'description': instance.description,
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'drugs': instance.drugs,
  'executions': instance.executions,
  'files': instance.files,
};
