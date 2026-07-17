const _emailPattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

abstract class Validator {
  static String? emptyValidator(String? value) => (value?.isNotEmpty ?? false) ? null : '';

  static String? emailOrEmptyValidator(String? value) =>
      ((value?.isEmpty ?? true) || RegExp(_emailPattern).hasMatch(value!)) ? null : '';
}
