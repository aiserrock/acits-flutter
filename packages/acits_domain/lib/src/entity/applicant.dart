import 'package:equatable/equatable.dart';

class Applicant extends Equatable {
  const Applicant({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.id,
    this.email,
    this.contactDetails,
  });

  /// `null` for a not-yet-persisted draft (create form).
  final int? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? email;
  final String? contactDetails;

  String get fullName => '$firstName $lastName';

  Applicant copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? contactDetails,
  }) => Applicant(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    contactDetails: contactDetails ?? this.contactDetails,
  );

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, email, contactDetails];
}
