// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_history_snapshot_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalHistorySnapshotList _$PaginatedAnimalHistorySnapshotListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalHistorySnapshotList(
  count: PaginatedAnimalHistorySnapshotList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalHistorySnapshot.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedAnimalHistorySnapshotList._extras(
            json,
            'additionalProperties',
          ) ==
          null
      ? const {}
      : PaginatedAnimalHistorySnapshotList._readExtras(
          PaginatedAnimalHistorySnapshotList._extras(
            json,
            'additionalProperties',
          ),
        ),
);

Map<String, dynamic> _$PaginatedAnimalHistorySnapshotListToJson(
  PaginatedAnimalHistorySnapshotList instance,
) => <String, dynamic>{
  'count': ?PaginatedAnimalHistorySnapshotList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
