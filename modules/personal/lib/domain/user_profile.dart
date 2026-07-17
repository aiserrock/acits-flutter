import 'package:equatable/equatable.dart';

/// Доменная сущность профиля текущего пользователя (`/users/me/`).
///
/// Плоская и wire-независимая. Помимо редактируемых полей (имя/отчество/
/// фамилия/телефон/email) несёт серверные read-only поля (username/fullName/
/// dateJoined/isVerified/…), т.к. PUT ждёт целую запись — сервис восстанавливает
/// их в write-DTO без изменений.
class UserProfile extends Equatable {
  const UserProfile({
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

  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final DateTime dateJoined;
  final bool isVerified;
  final String? fathersName;
  final String? phoneNumber;
  final String? address;
  final bool? isOfferSigned;

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? fathersName,
    String? phoneNumber,
    String? email,
  }) => UserProfile(
    id: id,
    username: username,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    fullName: fullName,
    email: email ?? this.email,
    dateJoined: dateJoined,
    isVerified: isVerified,
    fathersName: fathersName ?? this.fathersName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    address: address,
    isOfferSigned: isOfferSigned,
  );

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    fullName,
    email,
    dateJoined,
    isVerified,
    fathersName,
    phoneNumber,
    address,
    isOfferSigned,
  ];
}
