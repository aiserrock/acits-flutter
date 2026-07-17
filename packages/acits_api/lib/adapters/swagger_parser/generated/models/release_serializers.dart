// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'release_serializers.g.dart';

/// Release serializer.
@JsonSerializable()
class ReleaseSerializers {
  const ReleaseSerializers({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.place,
    this.date,
    this.veterinarianName,
    this.veterinarianSurname,
    this.veterinarianPatronymic,
  });
  
  factory ReleaseSerializers.fromJson(Map<String, Object?> json) => _$ReleaseSerializersFromJson(json);
  
  final int id;
  final String? place;
  final DateTime? date;
  @JsonKey(name: 'veterinarian_name')
  final String? veterinarianName;
  @JsonKey(name: 'veterinarian_surname')
  final String? veterinarianSurname;
  @JsonKey(name: 'veterinarian_patronymic')
  final String? veterinarianPatronymic;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Map<String, Object?> toJson() => _$ReleaseSerializersToJson(this);
}
