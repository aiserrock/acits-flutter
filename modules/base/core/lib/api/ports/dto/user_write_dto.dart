import 'package:json_annotation/json_annotation.dart';

part 'user_write_dto.g.dart';

/// The self-profile update body (`PUT /api/v1/users/me/`).
///
/// OUR DTO — mirrors the `UserSerializers` body the app posts back. The endpoint
/// expects the whole record; server-only fields (username/full_name/date_joined/
/// is_verified) are read-only and echoed unchanged. Editable fields are the
/// name group, phone and email.
@JsonSerializable(includeIfNull: false)
class UserWriteDto {
  const UserWriteDto({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.dateJoined,
    required this.isVerified,
    this.fathersName,
    this.phoneNumber,
    this.address,
    this.isOfferSigned,
  });

  factory UserWriteDto.fromJson(Map<String, dynamic> json) => _$UserWriteDtoFromJson(json);

  final int id;
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  @JsonKey(name: 'date_joined')
  final DateTime dateJoined;
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @JsonKey(name: 'is_offer_signed')
  final bool? isOfferSigned;

  Map<String, dynamic> toJson() => _$UserWriteDtoToJson(this);
}
