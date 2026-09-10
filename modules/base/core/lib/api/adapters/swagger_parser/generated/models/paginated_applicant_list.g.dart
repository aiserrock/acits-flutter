// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_applicant_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedApplicantList _$PaginatedApplicantListFromJson(
  Map<String, dynamic> json,
) => PaginatedApplicantList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Applicant.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedApplicantListToJson(
  PaginatedApplicantList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
