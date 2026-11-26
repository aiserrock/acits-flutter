// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_prescription_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedPrescriptionList _$PaginatedPrescriptionListFromJson(
  Map<String, dynamic> json,
) => PaginatedPrescriptionList(
  count: PaginatedPrescriptionList._read_count(json['count']),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Prescription.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalProperties:
      PaginatedPrescriptionList._extras(json, 'additionalProperties') == null
      ? const {}
      : PaginatedPrescriptionList._readExtras(
          PaginatedPrescriptionList._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$PaginatedPrescriptionListToJson(
  PaginatedPrescriptionList instance,
) => <String, dynamic>{
  'count': ?PaginatedPrescriptionList._write_count(instance.count),
  'next': ?instance.next,
  'previous': ?instance.previous,
  'results': ?instance.results?.map((e) => e.toJson()).toList(),
};
