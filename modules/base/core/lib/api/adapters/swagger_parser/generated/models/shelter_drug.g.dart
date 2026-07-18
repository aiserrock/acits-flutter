// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelter_drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelterDrug _$ShelterDrugFromJson(Map<String, dynamic> json) => ShelterDrug(
  drug: Drug.fromJson(json['drug'] as Map<String, dynamic>),
  drugResiduesCount: (json['drug_residues_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$ShelterDrugToJson(ShelterDrug instance) =>
    <String, dynamic>{
      'drug': instance.drug,
      'drug_residues_count': instance.drugResiduesCount,
    };
