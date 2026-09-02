// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'prescription_file.g.dart';

/// PrescriptionFile serializer.
@JsonSerializable()
class PrescriptionFile {
  const PrescriptionFile({
    this.id,
    this.file,
    this.name,
    this.filename,
    this.createdAt,
  });
  
  factory PrescriptionFile.fromJson(Map<String, Object?> json) => _$PrescriptionFileFromJson(json);
  
  final int? id;
  final String? file;
  final String? name;
  final String? filename;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, Object?> toJson() => _$PrescriptionFileToJson(this);
}
