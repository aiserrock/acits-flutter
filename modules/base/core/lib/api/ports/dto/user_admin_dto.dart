import 'package:json_annotation/json_annotation.dart';

part 'user_admin_dto.g.dart';

/// Admin-registration response (`UserShelterAdminSerializers`, read direction).
///
/// The app only needs proof of a successful create; `id` and the echoed
/// profile fields are modelled for completeness. `shelter` stays a raw JSON
/// map — the read side is not consumed field-by-field by the app.
@JsonSerializable()
class UserAdminDto {
  const UserAdminDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isOfferSigned,
    this.fathersName,
    this.phoneNumber,
    this.address,
    this.shelter,
  });

  factory UserAdminDto.fromJson(Map<String, dynamic> json) => _$UserAdminDtoFromJson(json);

  final int id;
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
  @JsonKey(name: 'is_offer_signed')
  final bool isOfferSigned;
  final Map<String, dynamic>? shelter;

  Map<String, dynamic> toJson() => _$UserAdminDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is UserAdminDto && other.id == id && other.email == email);

  @override
  int get hashCode => Object.hash(id, email);
}
