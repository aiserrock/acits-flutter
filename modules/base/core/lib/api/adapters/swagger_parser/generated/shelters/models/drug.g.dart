// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drug _$DrugFromJson(Map<String, dynamic> json) => Drug(
  id: Drug._read_id(json['id']),
  name: json['name'] as String?,
  usageInstruction: json['usage_instruction'] as String?,
  formOfDrug: Drug._read_formOfDrug(json['form_of_drug']),
  formOfDrugName: json['form_of_drug_name'] as String?,
  additionalProperties: Drug._extras(json, 'additionalProperties') == null
      ? const {}
      : Drug._readExtras(Drug._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
  'id': ?Drug._write_id(instance.id),
  'name': ?instance.name,
  'usage_instruction': ?instance.usageInstruction,
  'form_of_drug': ?Drug._write_formOfDrug(instance.formOfDrug),
  'form_of_drug_name': ?instance.formOfDrugName,
};
