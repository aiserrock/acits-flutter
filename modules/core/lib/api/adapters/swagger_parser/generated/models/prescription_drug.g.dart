// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionDrug _$PrescriptionDrugFromJson(Map<String, dynamic> json) =>
    PrescriptionDrug(
      drugId: (json['drug_id'] as num).toInt(),
      drugName: json['drug_name'] as String,
      usageInstruction: json['usage_instruction'] as String,
      formOfDrug: json['form_of_drug'] as String,
      drugDosage: (json['drug_dosage'] as num).toDouble(),
    );

Map<String, dynamic> _$PrescriptionDrugToJson(PrescriptionDrug instance) =>
    <String, dynamic>{
      'drug_id': instance.drugId,
      'drug_name': instance.drugName,
      'usage_instruction': instance.usageInstruction,
      'form_of_drug': instance.formOfDrug,
      'drug_dosage': instance.drugDosage,
    };
