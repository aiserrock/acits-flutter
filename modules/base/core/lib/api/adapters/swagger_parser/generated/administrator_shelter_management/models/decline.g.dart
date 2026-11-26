// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Decline _$DeclineFromJson(Map<String, dynamic> json) => Decline(
  status: json['status'] as String?,
  additionalProperties: Decline._extras(json, 'additionalProperties') == null
      ? const {}
      : Decline._readExtras(Decline._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$DeclineToJson(Decline instance) => <String, dynamic>{
  'status': ?instance.status,
};
