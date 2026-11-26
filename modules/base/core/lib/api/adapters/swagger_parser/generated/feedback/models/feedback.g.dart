// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
  shelterId: Feedback._read_shelterId(json['shelter_id']),
  shelterName: json['shelter_name'] as String?,
  date: Feedback._read_date(json['date']),
  action: json['action'] as String?,
  email: json['email'] as String?,
  message: json['message'] as String?,
  additionalProperties: Feedback._extras(json, 'additionalProperties') == null
      ? const {}
      : Feedback._readExtras(Feedback._extras(json, 'additionalProperties')),
);

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
  'shelter_id': ?Feedback._write_shelterId(instance.shelterId),
  'shelter_name': ?instance.shelterName,
  'date': ?Feedback._write_date(instance.date),
  'action': ?instance.action,
  'email': ?instance.email,
  'message': ?instance.message,
};
