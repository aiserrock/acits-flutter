// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugDto _$DrugDtoFromJson(Map<String, dynamic> json) => DrugDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  formOfDrug: (json['form_of_drug'] as num).toInt(),
  formOfDrugName: json['form_of_drug_name'] as String,
  usageInstruction: json['usage_instruction'] as String?,
  drugResiduesCount: (json['drug_residues_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$DrugDtoToJson(DrugDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'usage_instruction': instance.usageInstruction,
  'form_of_drug': instance.formOfDrug,
  'form_of_drug_name': instance.formOfDrugName,
  'drug_residues_count': instance.drugResiduesCount,
};
