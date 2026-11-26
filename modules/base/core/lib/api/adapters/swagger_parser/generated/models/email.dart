// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'email.g.dart';

/// A serializer for only one email field inside. Used for password reset.
@JsonSerializable()
class Email {
  const Email({
    this.email,
  });
  
  factory Email.fromJson(Map<String, Object?> json) => _$EmailFromJson(json);
  
  final String? email;

  Map<String, Object?> toJson() => _$EmailToJson(this);
}
