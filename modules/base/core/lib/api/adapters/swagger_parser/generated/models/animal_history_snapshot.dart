// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'status69f_enum.dart';

part 'animal_history_snapshot.g.dart';

/// AnimalHistorySnapshot serializer.
@JsonSerializable()
class AnimalHistorySnapshot {
  const AnimalHistorySnapshot({
    this.animal,
    this.createdAt,
    this.status,
    this.height,
    this.weight,
    this.shelterName,
    this.editor,
  });
  
  factory AnimalHistorySnapshot.fromJson(Map<String, Object?> json) => _$AnimalHistorySnapshotFromJson(json);
  
  final int? animal;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final Status69fEnum? status;
  final String? height;
  final String? weight;
  @JsonKey(name: 'shelter_name')
  final String? shelterName;
  final String? editor;

  Map<String, Object?> toJson() => _$AnimalHistorySnapshotToJson(this);
}
