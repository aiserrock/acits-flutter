/// Валидаторы форм модуля «Личный кабинет».
///
/// Перенесены из app `util/validator.dart` (только используемое подмножество —
/// смена пароля), чтобы модуль не тянул приложение.
abstract class Validator {
  static String? emptyValidator(String? value) => (value?.isNotEmpty ?? false) ? null : '';
}
