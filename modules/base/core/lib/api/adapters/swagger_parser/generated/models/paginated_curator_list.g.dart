// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_curator_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedCuratorList _$PaginatedCuratorListFromJson(
  Map<String, dynamic> json,
) => PaginatedCuratorList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Curator.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedCuratorListToJson(
  PaginatedCuratorList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
