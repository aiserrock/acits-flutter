// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Approve _$ApproveFromJson(Map<String, dynamic> json) => Approve(
  status: json['status'] as String?,
  additionalProperties: Approve._extras(json, 'additionalProperties') == null
      ? const {}
      : Approve._readExtras(Approve._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$ApproveToJson(Approve instance) => <String, dynamic>{
  'status': ?instance.status,
};
