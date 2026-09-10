import 'package:equatable/equatable.dart';

class Curator extends Equatable {
  const Curator({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.id,
    this.email,
    this.address,
  });

  /// `null` for a not-yet-persisted draft (create form).
  final int? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? email;
  final String? address;

  String get fullName => '$firstName $lastName';

  Curator copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? address,
  }) => Curator(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    address: address ?? this.address,
  );

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, email, address];
}
