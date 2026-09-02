// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drug _$DrugFromJson(Map<String, dynamic> json) => Drug(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  usageInstruction: json['usage_instruction'] as String?,
  formOfDrug: (json['form_of_drug'] as num?)?.toInt(),
  formOfDrugName: json['form_of_drug_name'] as String?,
);

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'usage_instruction': instance.usageInstruction,
  'form_of_drug': instance.formOfDrug,
  'form_of_drug_name': instance.formOfDrugName,
};
