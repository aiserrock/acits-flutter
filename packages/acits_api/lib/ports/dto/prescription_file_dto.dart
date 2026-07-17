import 'package:json_annotation/json_annotation.dart';

part 'prescription_file_dto.g.dart';

/// A file attached to a prescription.
///
/// OUR DTO — mirrors `PrescriptionFile`. [file] carries the URL (read) or the
/// base64 data URI (write).
@JsonSerializable()
class PrescriptionFileDto {
  const PrescriptionFileDto({required this.file, this.id, this.name, this.filename, this.createdAt});

  factory PrescriptionFileDto.fromJson(Map<String, dynamic> json) => _$PrescriptionFileDtoFromJson(json);

  final int? id;
  final String file;
  final String? name;
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$PrescriptionFileDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionFileDto &&
          other.id == id &&
          other.file == file &&
          other.name == name &&
          other.filename == filename &&
          other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(id, file, name, filename, createdAt);
}
