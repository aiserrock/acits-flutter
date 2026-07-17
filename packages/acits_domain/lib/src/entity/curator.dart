import 'package:equatable/equatable.dart';

class Curator extends Equatable {
  const Curator({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,
    this.address,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? email;
  final String? address;

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, email, address];
}
