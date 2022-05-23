const _emailPattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

class Validator {
  static String? emptyValidator(String? value) => (value?.isNotEmpty ?? false) ? null : '';

  static String? emailValidator(String? value) =>
      ((value != null) && RegExp(_emailPattern).hasMatch(value)) ? null : '';

  static String? emailOrEmptyValidator(String? value) =>
      ((value?.isEmpty ?? true) || RegExp(_emailPattern).hasMatch(value!)) ? null : '';

  static String? intValidator(String? value) =>
      value != null && int.tryParse(value) != null ? null : '';

  static String? doubleValidator(String? value) =>
      value != null && double.tryParse(value) != null ? null : '';
}
