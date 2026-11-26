// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_drug_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionDrugDto _$PrescriptionDrugDtoFromJson(Map<String, dynamic> json) =>
    PrescriptionDrugDto(
      drugId: (json['drug_id'] as num).toInt(),
      drugName: json['drug_name'] as String,
      drugDosage: (json['drug_dosage'] as num).toDouble(),
      usageInstruction: json['usage_instruction'] as String?,
      formOfDrug: json['form_of_drug'] as String?,
    );

Map<String, dynamic> _$PrescriptionDrugDtoToJson(
  PrescriptionDrugDto instance,
) => <String, dynamic>{
  'drug_id': instance.drugId,
  'drug_name': instance.drugName,
  'drug_dosage': instance.drugDosage,
  'usage_instruction': instance.usageInstruction,
  'form_of_drug': instance.formOfDrug,
};
