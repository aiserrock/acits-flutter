// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
  email: json['email'] as String?,
  additionalProperties: Email._extras(json, 'additionalProperties') == null
      ? const {}
      : Email._readExtras(Email._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
  'email': ?instance.email,
};
