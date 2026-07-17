import 'package:json_annotation/json_annotation.dart';

part 'shelter_write_dto.g.dart';

/// Shelter payload nested in admin registration (`ShelterSerializers` on the
/// wire). Only the fields the app fills at registration are modelled as
/// required (name/country/city); the rest are optional passthrough.
@JsonSerializable(includeIfNull: false)
class ShelterWriteDto {
  const ShelterWriteDto({required this.name, required this.country, required this.city, this.region});

  factory ShelterWriteDto.fromJson(Map<String, dynamic> json) => _$ShelterWriteDtoFromJson(json);

  final String name;
  final String country;
  final String city;
  final String? region;

  Map<String, dynamic> toJson() => _$ShelterWriteDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShelterWriteDto &&
          other.name == name &&
          other.country == country &&
          other.city == city &&
          other.region == region);

  @override
  int get hashCode => Object.hash(name, country, city, region);
}
