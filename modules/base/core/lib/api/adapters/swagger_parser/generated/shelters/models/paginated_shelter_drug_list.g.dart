// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_shelter_drug_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedShelterDrugList _$PaginatedShelterDrugListFromJson(
  Map<String, dynamic> json,
) => PaginatedShelterDrugList(
  count: PaginatedShelterDrugList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => ShelterDrug.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedShelterDrugList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedShelterDrugList._readExtras(
          PaginatedShelterDrugList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedShelterDrugListToJson(
  PaginatedShelterDrugList instance,
) => <String, dynamic>{
  'count': ?PaginatedShelterDrugList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
