// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_history_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalHistorySnapshot _$AnimalHistorySnapshotFromJson(
  Map<String, dynamic> json,
) => AnimalHistorySnapshot(
  animal: AnimalHistorySnapshot._read_animal(json['animal']),
  createdAt: AnimalHistorySnapshot._read_createdAt(json['created_at']),
  status: AnimalHistorySnapshot._read_status(json['status']),
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  shelterName: json['shelter_name'] as String?,
  editor: json['editor'] as String?,
  additionalProperties:
      AnimalHistorySnapshot._extras(json, 'additionalProperties') == null
      ? const {}
      : AnimalHistorySnapshot._readExtras(
          AnimalHistorySnapshot._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$AnimalHistorySnapshotToJson(
  AnimalHistorySnapshot instance,
) => <String, dynamic>{
  'animal': ?AnimalHistorySnapshot._write_animal(instance.animal),
  'created_at': ?AnimalHistorySnapshot._write_createdAt(instance.createdAt),
  'status': ?AnimalHistorySnapshot._write_status(instance.status),
  'height': ?instance.height,
  'weight': ?instance.weight,
  'shelter_name': ?instance.shelterName,
  'editor': ?instance.editor,
};
