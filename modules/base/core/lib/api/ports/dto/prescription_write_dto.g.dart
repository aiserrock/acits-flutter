// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_write_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionWriteDto _$PrescriptionWriteDtoFromJson(
  Map<String, dynamic> json,
) => PrescriptionWriteDto(
  animal: (json['animal'] as num).toInt(),
  myType: json['my_type'] as String,
  drugs: (json['drugs'] as List<dynamic>)
      .map((e) => PrescriptionDrugDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  executions: (json['executions'] as List<dynamic>)
      .map((e) => PrescriptionExecutionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: (json['id'] as num?)?.toInt(),
  duration: json['duration'] as String?,
  description: json['description'] as String?,
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFileDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  extraTypeAttributes: json['extra_type_attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PrescriptionWriteDtoToJson(
  PrescriptionWriteDto instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'animal': instance.animal,
  'my_type': instance.myType,
  'duration': ?instance.duration,
  'description': ?instance.description,
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'executions': instance.executions.map((e) => e.toJson()).toList(),
  'files': ?instance.files?.map((e) => e.toJson()).toList(),
  'extra_type_attributes': ?instance.extraTypeAttributes,
};
