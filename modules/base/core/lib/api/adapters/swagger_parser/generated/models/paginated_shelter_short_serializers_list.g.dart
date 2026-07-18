// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_shelter_short_serializers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedShelterShortSerializersList
_$PaginatedShelterShortSerializersListFromJson(Map<String, dynamic> json) =>
    PaginatedShelterShortSerializersList(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map(
            (e) => ShelterShortSerializers.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$PaginatedShelterShortSerializersListToJson(
  PaginatedShelterShortSerializersList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
