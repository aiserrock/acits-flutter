// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_prescription_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedPrescriptionList _$PaginatedPrescriptionListFromJson(
  Map<String, dynamic> json,
) => PaginatedPrescriptionList(
  count: (json['count'] as num?)?.toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Prescription.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedPrescriptionListToJson(
  PaginatedPrescriptionList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
