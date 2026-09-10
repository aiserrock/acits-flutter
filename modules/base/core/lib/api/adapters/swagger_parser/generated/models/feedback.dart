// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

/// Feedback serializer.
@JsonSerializable()
class Feedback {
  const Feedback({
    this.shelterId,
    this.shelterName,
    this.date,
    this.action,
    this.email,
    this.message,
  });
  
  factory Feedback.fromJson(Map<String, Object?> json) => _$FeedbackFromJson(json);
  
  @JsonKey(name: 'shelter_id')
  final int? shelterId;
  @JsonKey(name: 'shelter_name')
  final String? shelterName;
  final DateTime? date;
  final String? action;
  final String? email;
  final String? message;

  Map<String, Object?> toJson() => _$FeedbackToJson(this);
}
