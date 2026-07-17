// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'shelter_short_serializers.g.dart';

/// Short shelter serializer.
@JsonSerializable()
class ShelterShortSerializers {
  const ShelterShortSerializers({
    required this.id,
    required this.name,
  });
  
  factory ShelterShortSerializers.fromJson(Map<String, Object?> json) => _$ShelterShortSerializersFromJson(json);
  
  final int id;
  final String name;

  Map<String, Object?> toJson() => _$ShelterShortSerializersToJson(this);
}
