// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'level_enum.dart';

part 'species.g.dart';

/// Species serializer.
@JsonSerializable()
class Species {
  const Species({
    this.id,
    this.name,
    this.level,
    this.parentId,
    this.parentName,
    this.categoryName,
  });
  
  factory Species.fromJson(Map<String, Object?> json) => _$SpeciesFromJson(json);
  
  final int? id;
  final String? name;

  /// Level of species.
  ///
  /// * `1` - One.
  /// * `2` - Two.
  /// * `3` - Three.
  final LevelEnum? level;

  /// Id of parent species
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'parent_name')
  final String? parentName;
  @JsonKey(name: 'category_name')
  final String? categoryName;

  Map<String, Object?> toJson() => _$SpeciesToJson(this);
}
