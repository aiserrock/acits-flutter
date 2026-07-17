// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'status_transitions_item.g.dart';

/// Serializer for items from AnimalStatsResponseSerializer
@JsonSerializable()
class StatusTransitionsItem {
  const StatusTransitionsItem({
    required this.statusSequence,
    required this.count,
  });
  
  factory StatusTransitionsItem.fromJson(Map<String, Object?> json) => _$StatusTransitionsItemFromJson(json);
  
  @JsonKey(name: 'status_sequence')
  final List<dynamic> statusSequence;
  final int count;

  Map<String, Object?> toJson() => _$StatusTransitionsItemToJson(this);
}
