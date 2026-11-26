// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelter_drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelterDrug _$ShelterDrugFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['drug']);
  return ShelterDrug(
    drug: json['drug'] == null
        ? null
        : Drug.fromJson(json['drug'] as Map<String, dynamic>),
    drugResiduesCount: ShelterDrug._read_drugResiduesCount(
      json['drug_residues_count'],
    ),
    additionalProperties:
        ShelterDrug._extras(json, 'additionalProperties') == null
        ? const {}
        : ShelterDrug._readExtras(
            ShelterDrug._extras(json, 'additionalProperties'),
          ),
  );
}

Map<String, dynamic> _$ShelterDrugToJson(ShelterDrug instance) =>
    <String, dynamic>{
      'drug': ?instance.drug?.toJson(),
      'drug_residues_count': ?ShelterDrug._write_drugResiduesCount(
        instance.drugResiduesCount,
      ),
    };
