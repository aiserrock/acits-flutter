import 'package:json_annotation/json_annotation.dart';

part 'animal_image_write_dto.g.dart';

/// A single image to upload with an animal (write shape).
///
/// OUR DTO — mirrors `AnimalImageWrite` on the wire. [image] is the base64
/// payload (data URI or raw base64) the backend expects for new uploads.
@JsonSerializable()
class AnimalImageWriteDto {
  const AnimalImageWriteDto({required this.name, required this.image, this.isPrimary});

  factory AnimalImageWriteDto.fromJson(Map<String, dynamic> json) => _$AnimalImageWriteDtoFromJson(json);

  final String name;

  /// Base64-encoded image payload.
  final String image;
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;

  Map<String, dynamic> toJson() => _$AnimalImageWriteDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalImageWriteDto && other.name == name && other.image == image && other.isPrimary == isPrimary;

  @override
  int get hashCode => Object.hash(name, image, isPrimary);
}
