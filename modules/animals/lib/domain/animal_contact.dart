import 'package:equatable/equatable.dart';

/// Куратор или заявитель в карточке животного. Общая форма — оба показываются
/// одинаковыми блоками (ФИО / телефон / email / доп.поле).
class AnimalContact extends Equatable {
  const AnimalContact({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.email,
    this.extra,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? email;

  /// Адрес (куратор) либо контактные детали (заявитель).
  final String? extra;

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, email, extra];
}
