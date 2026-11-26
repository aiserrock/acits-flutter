// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parasites_prescription_extra_attr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParasitesPrescriptionExtraAttr _$ParasitesPrescriptionExtraAttrFromJson(
  Map<String, dynamic> json,
) => ParasitesPrescriptionExtraAttr(
  parasitesType: ParasitesPrescriptionExtraAttr._read_parasitesType(
    json['parasites_type'],
  ),
  reaction:
      ParasitesPrescriptionExtraAttr._presentValue(json, 'reaction') == null
      ? ""
      : ParasitesPrescriptionExtraAttr._read_reaction(
          ParasitesPrescriptionExtraAttr._presentValue(json, 'reaction')
              as Object,
        ),
  additionalProperties:
      ParasitesPrescriptionExtraAttr._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : ParasitesPrescriptionExtraAttr._readExtras(
          ParasitesPrescriptionExtraAttr._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$ParasitesPrescriptionExtraAttrToJson(
  ParasitesPrescriptionExtraAttr instance,
) => <String, dynamic>{
  'parasites_type': ?ParasitesPrescriptionExtraAttr._write_parasitesType(
    instance.parasitesType,
  ),
  'reaction': ParasitesPrescriptionExtraAttr._write_reaction(instance.reaction),
};
