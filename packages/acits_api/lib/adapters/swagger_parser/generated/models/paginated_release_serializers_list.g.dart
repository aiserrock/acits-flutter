// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_release_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedReleaseSerializersList _$PaginatedReleaseSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedReleaseSerializersList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => ReleaseSerializers.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedReleaseSerializersListToJson(
  PaginatedReleaseSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
