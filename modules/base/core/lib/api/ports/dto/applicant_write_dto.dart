import 'package:json_annotation/json_annotation.dart';

part 'applicant_write_dto.g.dart';

/// Applicant (write shape) for create/update.
///
/// OUR DTO — mirrors the `Applicant` body the app historically posted. [id] is
/// present only on update (the chopper PUT body carried it); [shelter] scopes
/// the record to the current shelter, matching the prior behaviour.
@JsonSerializable(includeIfNull: false)
class ApplicantWriteDto {
  const ApplicantWriteDto({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.id,
    this.shelter,
    this.email,
    this.contactDetails,
  });

  factory ApplicantWriteDto.fromJson(Map<String, dynamic> json) => _$ApplicantWriteDtoFromJson(json);

  final int? id;
  final int? shelter;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'contact_details')
  final String? contactDetails;

  Map<String, dynamic> toJson() => _$ApplicantWriteDtoToJson(this);
}
