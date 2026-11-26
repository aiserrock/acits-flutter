// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_short_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionShortDto _$PrescriptionShortDtoFromJson(
  Map<String, dynamic> json,
) => PrescriptionShortDto(
  animal: AnimalShortDto.fromJson(json['animal'] as Map<String, dynamic>),
  drugs:
      (json['drugs'] as List<dynamic>?)
          ?.map((e) => PrescriptionDrugDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  id: (json['id'] as num?)?.toInt(),
  myType: json['my_type'] as String?,
  description: json['description'] as String?,
  createdBy: json['created_by'] as String?,
  updatedBy: json['updated_by'] as String?,
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => PrescriptionFileDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  extraTypeAttributes: json['extra_type_attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PrescriptionShortDtoToJson(
  PrescriptionShortDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'my_type': instance.myType,
  'extra_type_attributes': instance.extraTypeAttributes,
  'description': instance.description,
  'animal': instance.animal.toJson(),
  'drugs': instance.drugs.map((e) => e.toJson()).toList(),
  'created_by': instance.createdBy,
  'updated_by': instance.updatedBy,
  'files': instance.files?.map((e) => e.toJson()).toList(),
};
