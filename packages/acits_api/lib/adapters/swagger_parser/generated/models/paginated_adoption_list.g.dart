// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_adoption_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAdoptionList _$PaginatedAdoptionListFromJson(
  Map<String, dynamic> json,
) => PaginatedAdoptionList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Adoption.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedAdoptionListToJson(
  PaginatedAdoptionList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
