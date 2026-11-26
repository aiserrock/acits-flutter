// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionDrug _$PrescriptionDrugFromJson(Map<String, dynamic> json) =>
    PrescriptionDrug(
      drugId: PrescriptionDrug._read_drugId(json['drug_id']),
      drugName: json['drug_name'] as String?,
      usageInstruction: json['usage_instruction'] as String?,
      formOfDrug: json['form_of_drug'] as String?,
      drugDosage: json['drug_dosage'] as num?,
      additionalProperties:
          PrescriptionDrug._extras(json, 'additionalProperties') == null
          ? const {}
          : PrescriptionDrug._readExtras(
              PrescriptionDrug._extras(json, 'additionalProperties'),
            ),
    );

Map<String, dynamic> _$PrescriptionDrugToJson(PrescriptionDrug instance) =>
    <String, dynamic>{
      'drug_id': ?PrescriptionDrug._write_drugId(instance.drugId),
      'drug_name': ?instance.drugName,
      'usage_instruction': ?instance.usageInstruction,
      'form_of_drug': ?instance.formOfDrug,
      'drug_dosage': ?instance.drugDosage,
    };
