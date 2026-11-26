// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_curator_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedCuratorList _$PaginatedCuratorListFromJson(
  Map<String, dynamic> json,
) => PaginatedCuratorList(
  count: PaginatedCuratorList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Curator.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedCuratorList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedCuratorList._readExtras(
          PaginatedCuratorList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedCuratorListToJson(
  PaginatedCuratorList instance,
) => <String, dynamic>{
  'count': ?PaginatedCuratorList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
