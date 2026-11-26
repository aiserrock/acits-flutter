// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelter_short_serializers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShelterShortSerializers _$ShelterShortSerializersFromJson(
  Map<String, dynamic> json,
) => ShelterShortSerializers(
  id: ShelterShortSerializers._read_id(json['id']),
  name: json['name'] as String?,
  additionalProperties:
      ShelterShortSerializers._extras(json, 'additionalProperties') == null
      ? const {}
      : ShelterShortSerializers._readExtras(
          ShelterShortSerializers._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$ShelterShortSerializersToJson(
  ShelterShortSerializers instance,
) => <String, dynamic>{
  'id': ?ShelterShortSerializers._write_id(instance.id),
  'name': ?instance.name,
};
