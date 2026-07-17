// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'applicant_file.g.dart';

/// ApplicantFile serializer.
@JsonSerializable()
class ApplicantFile {
  const ApplicantFile({
    required this.id,
    required this.file,
    required this.name,
    required this.filename,
    required this.createdAt,
  });
  
  factory ApplicantFile.fromJson(Map<String, Object?> json) => _$ApplicantFileFromJson(json);
  
  final int id;
  final String file;
  final String name;
  final String filename;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Map<String, Object?> toJson() => _$ApplicantFileToJson(this);
}
