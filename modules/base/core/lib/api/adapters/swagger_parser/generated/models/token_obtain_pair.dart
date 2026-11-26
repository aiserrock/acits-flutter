// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'token_obtain_pair.g.dart';

@JsonSerializable()
class TokenObtainPair {
  const TokenObtainPair({
    this.username,
    this.password,
    this.access,
    this.refresh,
  });
  
  factory TokenObtainPair.fromJson(Map<String, Object?> json) => _$TokenObtainPairFromJson(json);
  
  final String? username;
  final String? password;
  final String? access;
  final String? refresh;

  Map<String, Object?> toJson() => _$TokenObtainPairToJson(this);
}
