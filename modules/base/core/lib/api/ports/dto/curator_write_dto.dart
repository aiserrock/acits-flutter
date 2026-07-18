import 'package:json_annotation/json_annotation.dart';

part 'curator_write_dto.g.dart';

/// Curator (write shape) for create/update.
///
/// OUR DTO — mirrors the `Curator` body the app historically posted. [id] is
/// present only on update; [shelter] scopes the record to the current shelter.
/// On the wire `shelter` is a string (as the chopper client sent it).
@JsonSerializable(includeIfNull: false)
class CuratorWriteDto {
  const CuratorWriteDto({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    this.id,
    this.shelter,
    this.email,
  });

  factory CuratorWriteDto.fromJson(Map<String, dynamic> json) => _$CuratorWriteDtoFromJson(json);

  final int? id;
  final String? shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String address;

  Map<String, dynamic> toJson() => _$CuratorWriteDtoToJson(this);
}
