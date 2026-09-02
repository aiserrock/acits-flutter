// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_transitions_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusTransitionsItem _$StatusTransitionsItemFromJson(
  Map<String, dynamic> json,
) => StatusTransitionsItem(
  statusSequence: json['status_sequence'] as List<dynamic>?,
  count: (json['count'] as num?)?.toInt(),
);

Map<String, dynamic> _$StatusTransitionsItemToJson(
  StatusTransitionsItem instance,
) => <String, dynamic>{
  'status_sequence': instance.statusSequence,
  'count': instance.count,
};
