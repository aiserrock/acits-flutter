import 'package:json_annotation/json_annotation.dart';

part 'user_worker_dto.g.dart';

/// Worker-registration response (`UserShelterWorkerSerializers`, read
/// direction). The app only needs proof of a successful create.
@JsonSerializable()
class UserWorkerDto {
  const UserWorkerDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isOfferSigned,
    this.fathersName,
    this.phoneNumber,
    this.address,
    this.shelter,
    this.role,
  });

  factory UserWorkerDto.fromJson(Map<String, dynamic> json) => _$UserWorkerDtoFromJson(json);

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
  final int? shelter;

  /// Raw wire role value (`WORKER`, `GUEST`).
  final String? role;
  @JsonKey(name: 'is_offer_signed')
  final bool isOfferSigned;

  Map<String, dynamic> toJson() => _$UserWorkerDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is UserWorkerDto && other.email == email && other.role == role);

  @override
  int get hashCode => Object.hash(email, role);
}
