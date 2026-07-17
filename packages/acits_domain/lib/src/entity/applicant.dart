import 'package:equatable/equatable.dart';

class Applicant extends Equatable {
  const Applicant({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,
    this.contactDetails,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? email;
  final String? contactDetails;

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, email, contactDetails];
}
