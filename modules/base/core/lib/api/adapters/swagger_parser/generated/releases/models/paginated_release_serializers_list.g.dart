// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_release_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedReleaseSerializersList _$PaginatedReleaseSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedReleaseSerializersList(
  count: PaginatedReleaseSerializersList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => ReleaseSerializers.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedReleaseSerializersList._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : PaginatedReleaseSerializersList._readExtras(
          PaginatedReleaseSerializersList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedReleaseSerializersListToJson(
  PaginatedReleaseSerializersList instance,
) => <String, dynamic>{
  'count': ?PaginatedReleaseSerializersList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
