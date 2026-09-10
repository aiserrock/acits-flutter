// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
  shelterId: (json['shelter_id'] as num?)?.toInt(),
  shelterName: json['shelter_name'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  action: json['action'] as String?,
  email: json['email'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
  'shelter_id': instance.shelterId,
  'shelter_name': instance.shelterName,
  'date': instance.date?.toIso8601String(),
  'action': instance.action,
  'email': instance.email,
  'message': instance.message,
};
