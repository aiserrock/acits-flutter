import 'package:json_annotation/json_annotation.dart';

part 'animal_short_dto.g.dart';

/// Compact animal reference embedded in a prescription execution.
///
/// OUR DTO — mirrors `AnimalShort` (a.k.a. `PrescriptionAnimal`) on the wire.
@JsonSerializable()
class AnimalShortDto {
  const AnimalShortDto({
    required this.id,
    required this.uuid,
    required this.specName,
    this.name,
    this.specParentName,
    this.avatar,
    this.defaultImageId,
  });

  factory AnimalShortDto.fromJson(Map<String, dynamic> json) => _$AnimalShortDtoFromJson(json);

  final int id;
  final String uuid;
  final String? name;
  @JsonKey(name: 'spec_name')
  final String specName;
  @JsonKey(name: 'spec_parent_name')
  final String? specParentName;
  final String? avatar;
  @JsonKey(name: 'default_image_id')
  final int? defaultImageId;

  Map<String, dynamic> toJson() => _$AnimalShortDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalShortDto &&
          other.id == id &&
          other.uuid == uuid &&
          other.name == name &&
          other.specName == specName &&
          other.specParentName == specParentName &&
          other.avatar == avatar &&
          other.defaultImageId == defaultImageId;

  @override
  int get hashCode => Object.hash(id, uuid, name, specName, specParentName, avatar, defaultImageId);
}
