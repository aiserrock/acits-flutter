import 'package:json_annotation/json_annotation.dart';

import 'image_thumbnails_dto.dart';

part 'animal_image_dto.g.dart';

/// A single animal image (read shape).
///
/// OUR DTO — mirrors `AnimalImageRead` on the wire.
@JsonSerializable(explicitToJson: true)
class AnimalImageDto {
  const AnimalImageDto({required this.id, required this.filename, required this.image, this.isPrimary});

  factory AnimalImageDto.fromJson(Map<String, dynamic> json) => _$AnimalImageDtoFromJson(json);

  final int id;
  final String filename;
  final ImageThumbnailsDto image;
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;

  Map<String, dynamic> toJson() => _$AnimalImageDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalImageDto &&
          other.id == id &&
          other.filename == filename &&
          other.image == image &&
          other.isPrimary == isPrimary;

  @override
  int get hashCode => Object.hash(id, filename, image, isPrimary);
}
