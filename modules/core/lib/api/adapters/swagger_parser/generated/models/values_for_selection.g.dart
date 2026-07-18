// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'values_for_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValuesForSelection _$ValuesForSelectionFromJson(Map<String, dynamic> json) =>
    ValuesForSelection(
      choicesName: (json['choices_name'] as List<dynamic>)
          .map(
            (e) => ValuesForSelectionItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ValuesForSelectionToJson(ValuesForSelection instance) =>
    <String, dynamic>{'choices_name': instance.choicesName};
