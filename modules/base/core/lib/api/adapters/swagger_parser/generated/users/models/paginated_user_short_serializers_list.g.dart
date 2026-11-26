// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_user_short_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedUserShortSerializersList _$PaginatedUserShortSerializersListFromJson(
  Map<String, dynamic> json,
) => PaginatedUserShortSerializersList(
  count: PaginatedUserShortSerializersList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => UserShortSerializers.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedUserShortSerializersList._extras(json, 'additionalProperties') ==
          null
      ? const {}
      : PaginatedUserShortSerializersList._readExtras(
          PaginatedUserShortSerializersList._extras(
            json,
            'additionalProperties',
          ),
        ),
);

Map<String, dynamic> _$PaginatedUserShortSerializersListToJson(
  PaginatedUserShortSerializersList instance,
) => <String, dynamic>{
  'count': ?PaginatedUserShortSerializersList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
