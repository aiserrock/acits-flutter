import 'package:json_annotation/json_annotation.dart';

part 'shelter_short_dto.g.dart';

/// Short shelter shape (`id`/`name`) — used by shelter lists.
@JsonSerializable()
class ShelterShortDto {
  const ShelterShortDto({required this.id, required this.name});

  factory ShelterShortDto.fromJson(Map<String, dynamic> json) => _$ShelterShortDtoFromJson(json);

  final int id;
  final String name;

  Map<String, dynamic> toJson() => _$ShelterShortDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ShelterShortDto && other.id == id && other.name == name);

  @override
  int get hashCode => Object.hash(id, name);
}
