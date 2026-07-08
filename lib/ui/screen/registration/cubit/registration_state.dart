import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:equatable/equatable.dart';

/// Роль пользователя при регистрации кастомера
enum CustomerRole { guest, employer }

/// Состояние экрана регистрации.
///
/// Держит выбранный таб ([tabIndex]), согласие на обработку персональных
/// данных ([agreedToPolicy]), флаг отправки формы ([submitting]), роль
/// кастомера ([role]) и выбранный приют ([shelter]).
/// UI-контроллеры ([TabController]/[TextEditingController]/[GlobalKey])
/// остаются во [StatefulWidget] экрана.
class RegistrationState extends Equatable {
  const RegistrationState({
    this.tabIndex = 0,
    this.agreedToPolicy = false,
    this.submitting = false,
    this.role = CustomerRole.employer,
    this.shelter,
  });

  /// Индекс активного таба (0 — организация, 1 — кастомер).
  final int tabIndex;

  /// Согласие на обработку персональных данных.
  final bool agreedToPolicy;

  /// Идёт ли отправка формы регистрации.
  final bool submitting;

  /// Роль кастомера.
  final CustomerRole role;

  /// Выбранный пользователем приют.
  final ShelterShortSerializers? shelter;

  RegistrationState copyWith({
    int? tabIndex,
    bool? agreedToPolicy,
    bool? submitting,
    CustomerRole? role,
    ShelterShortSerializers? shelter,
  }) {
    return RegistrationState(
      tabIndex: tabIndex ?? this.tabIndex,
      agreedToPolicy: agreedToPolicy ?? this.agreedToPolicy,
      submitting: submitting ?? this.submitting,
      role: role ?? this.role,
      shelter: shelter ?? this.shelter,
    );
  }

  @override
  List<Object?> get props => [tabIndex, agreedToPolicy, submitting, role, shelter];
}
