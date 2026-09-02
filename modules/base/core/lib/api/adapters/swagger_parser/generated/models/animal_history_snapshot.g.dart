// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_history_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalHistorySnapshot _$AnimalHistorySnapshotFromJson(
  Map<String, dynamic> json,
) => AnimalHistorySnapshot(
  animal: (json['animal'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  status: json['status'] == null
      ? null
      : Status69fEnum.fromJson(json['status'] as String),
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  shelterName: json['shelter_name'] as String?,
  editor: json['editor'] as String?,
);

Map<String, dynamic> _$AnimalHistorySnapshotToJson(
  AnimalHistorySnapshot instance,
) => <String, dynamic>{
  'animal': instance.animal,
  'created_at': instance.createdAt?.toIso8601String(),
  'status': instance.status,
  'height': instance.height,
  'weight': instance.weight,
  'shelter_name': instance.shelterName,
  'editor': instance.editor,
};
