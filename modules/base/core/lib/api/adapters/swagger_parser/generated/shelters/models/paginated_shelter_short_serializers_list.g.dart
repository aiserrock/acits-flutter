// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_shelter_short_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedShelterShortSerializersList
_$PaginatedShelterShortSerializersListFromJson(Map<String, dynamic> json) =>
    PaginatedShelterShortSerializersList(
      count: PaginatedShelterShortSerializersList._read_count(json['count']),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map(
            (e) => ShelterShortSerializers.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      additionalProperties:
          PaginatedShelterShortSerializersList._extras(
                json,
                'additionalProperties',
              ) ==
              null
          ? const {}
          : PaginatedShelterShortSerializersList._readExtras(
              PaginatedShelterShortSerializersList._extras(
                json,
                'additionalProperties',
              ),
            ),
    );

Map<String, dynamic> _$PaginatedShelterShortSerializersListToJson(
  PaginatedShelterShortSerializersList instance,
) => <String, dynamic>{
  'count': ?PaginatedShelterShortSerializersList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
