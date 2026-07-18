// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parasites_prescription_extra_attr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParasitesPrescriptionExtraAttr _$ParasitesPrescriptionExtraAttrFromJson(
  Map<String, dynamic> json,
) => ParasitesPrescriptionExtraAttr(
  reaction: json['reaction'] as String? ?? '',
  parasitesType: json['parasites_type'] == null
      ? null
      : ParasitesTypeEnum.fromJson(json['parasites_type'] as String),
);

Map<String, dynamic> _$ParasitesPrescriptionExtraAttrToJson(
  ParasitesPrescriptionExtraAttr instance,
) => <String, dynamic>{
  'parasites_type': instance.parasitesType,
  'reaction': instance.reaction,
};
