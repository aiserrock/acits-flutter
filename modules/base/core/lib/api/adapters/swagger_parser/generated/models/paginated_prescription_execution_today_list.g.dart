// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_prescription_execution_today_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedPrescriptionExecutionTodayList
_$PaginatedPrescriptionExecutionTodayListFromJson(Map<String, dynamic> json) =>
    PaginatedPrescriptionExecutionTodayList(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map(
            (e) =>
                PrescriptionExecutionToday.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$PaginatedPrescriptionExecutionTodayListToJson(
  PaginatedPrescriptionExecutionTodayList instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
