// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_applicant_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedApplicantList _$PaginatedApplicantListFromJson(
  Map<String, dynamic> json,
) => PaginatedApplicantList(
  count: PaginatedApplicantList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Applicant.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedApplicantList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedApplicantList._readExtras(
          PaginatedApplicantList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedApplicantListToJson(
  PaginatedApplicantList instance,
) => <String, dynamic>{
  'count': ?PaginatedApplicantList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
