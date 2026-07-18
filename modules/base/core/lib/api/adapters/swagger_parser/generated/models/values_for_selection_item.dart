// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'values_for_selection_item.g.dart';

@JsonSerializable()
class ValuesForSelectionItem {
  const ValuesForSelectionItem({
    required this.displayName,
    required this.value,
  });
  
  factory ValuesForSelectionItem.fromJson(Map<String, Object?> json) => _$ValuesForSelectionItemFromJson(json);
  
  @JsonKey(name: 'display_name')
  final String displayName;
  final String value;

  Map<String, Object?> toJson() => _$ValuesForSelectionItemToJson(this);
}
