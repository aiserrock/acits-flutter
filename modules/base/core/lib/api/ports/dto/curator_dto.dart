import 'package:json_annotation/json_annotation.dart';

part 'curator_dto.g.dart';

/// Person curating an animal.
///
/// OUR DTO — mirrors `Curator` on the wire.
@JsonSerializable()
class CuratorDto {
  const CuratorDto({
    required this.id,
    this.url,
    this.shelter,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  factory CuratorDto.fromJson(Map<String, dynamic> json) => _$CuratorDtoFromJson(json);

  final int id;
  // NOTE: these mirror the wire `Curator`, whose OpenAPI schema over-declares
  // them `required` + non-null. The backend actually serves them as `null`
  // (e.g. blank audit fields), so we keep them nullable here. See
  // preprocess_openapi.dart `_relaxOverstatedNonNull` and the backend PR.
  final String? url;
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$CuratorDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CuratorDto &&
          other.id == id &&
          other.url == url &&
          other.shelter == shelter &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.email == email &&
          other.phoneNumber == phoneNumber &&
          other.address == address &&
          other.createdBy == createdBy &&
          other.updatedBy == updatedBy &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode => Object.hash(
    id,
    url,
    shelter,
    firstName,
    lastName,
    email,
    phoneNumber,
    address,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  );
}
