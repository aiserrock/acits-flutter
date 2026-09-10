// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_history_snapshot_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalHistorySnapshotList _$PaginatedAnimalHistorySnapshotListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalHistorySnapshotList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalHistorySnapshot.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedAnimalHistorySnapshotListToJson(
  PaginatedAnimalHistorySnapshotList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
