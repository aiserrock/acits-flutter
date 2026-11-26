// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'values_for_selection_item.dart';

part 'values_for_selection.g.dart';

@JsonSerializable()
class ValuesForSelection {
  const ValuesForSelection({
    this.choicesName,
  });
  
  factory ValuesForSelection.fromJson(Map<String, Object?> json) => _$ValuesForSelectionFromJson(json);
  
  @JsonKey(name: 'choices_name')
  final List<ValuesForSelectionItem>? choicesName;

  Map<String, Object?> toJson() => _$ValuesForSelectionToJson(this);
}
