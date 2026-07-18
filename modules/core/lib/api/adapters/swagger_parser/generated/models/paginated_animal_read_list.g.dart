// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_animal_read_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAnimalReadList _$PaginatedAnimalReadListFromJson(
  Map<String, dynamic> json,
) => PaginatedAnimalReadList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => AnimalRead.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedAnimalReadListToJson(
  PaginatedAnimalReadList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
