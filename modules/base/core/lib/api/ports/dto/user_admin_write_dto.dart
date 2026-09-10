import 'package:json_annotation/json_annotation.dart';

import 'shelter_write_dto.dart';

part 'user_admin_write_dto.g.dart';

/// Admin-registration payload (`POST /api/v1/users/admin-register/`).
///
/// Registers a new shelter and its admin. Wire shape mirrors
/// `UserShelterAdminSerializers` (write direction).
@JsonSerializable(includeIfNull: false)
class UserAdminWriteDto {
  const UserAdminWriteDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.isOfferSigned,
    required this.shelter,
    this.fathersName,
    this.phoneNumber,
    this.address,
  });

  factory UserAdminWriteDto.fromJson(Map<String, dynamic> json) => _$UserAdminWriteDtoFromJson(json);

  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'fathers_name')
  final String? fathersName;
  final String email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  final String password;
  @JsonKey(name: 're_password')
  final String rePassword;
  @JsonKey(name: 'is_offer_signed')
  final bool isOfferSigned;
  final ShelterWriteDto shelter;

  Map<String, dynamic> toJson() => _$UserAdminWriteDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAdminWriteDto &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.fathersName == fathersName &&
          other.email == email &&
          other.phoneNumber == phoneNumber &&
          other.address == address &&
          other.password == password &&
          other.rePassword == rePassword &&
          other.isOfferSigned == isOfferSigned &&
          other.shelter == shelter);

  @override
  int get hashCode => Object.hash(
    firstName,
    lastName,
    fathersName,
    email,
    phoneNumber,
    address,
    password,
    rePassword,
    isOfferSigned,
    shelter,
  );
}
