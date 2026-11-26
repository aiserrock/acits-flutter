// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_transitions_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusTransitionsItem _$StatusTransitionsItemFromJson(
  Map<String, dynamic> json,
) => StatusTransitionsItem(
  statusSequence: json['status_sequence'] as List<dynamic>?,
  count: StatusTransitionsItem._read_count(json['count']),
  additionalProperties:
      StatusTransitionsItem._extras(json, 'additionalProperties') == null
      ? const {}
      : StatusTransitionsItem._readExtras(
          StatusTransitionsItem._extras(json, 'additionalProperties'),
        ),
);

Map<String, dynamic> _$StatusTransitionsItemToJson(
  StatusTransitionsItem instance,
) => <String, dynamic>{
  'status_sequence': ?instance.statusSequence,
  'count': ?StatusTransitionsItem._write_count(instance.count),
};
