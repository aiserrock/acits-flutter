// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'shelter_short_serializers.dart';

part 'paginated_shelter_short_serializers_list.g.dart';

@JsonSerializable()
class PaginatedShelterShortSerializersList {
  const PaginatedShelterShortSerializersList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  
  factory PaginatedShelterShortSerializersList.fromJson(Map<String, Object?> json) => _$PaginatedShelterShortSerializersListFromJson(json);
  
  final int? count;
  final String? next;
  final String? previous;
  final List<ShelterShortSerializers>? results;

  Map<String, Object?> toJson() => _$PaginatedShelterShortSerializersListToJson(this);
}
