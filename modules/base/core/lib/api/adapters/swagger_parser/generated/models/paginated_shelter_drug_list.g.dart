// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_shelter_drug_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedShelterDrugList _$PaginatedShelterDrugListFromJson(
  Map<String, dynamic> json,
) => PaginatedShelterDrugList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => ShelterDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedShelterDrugListToJson(
  PaginatedShelterDrugList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
