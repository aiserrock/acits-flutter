const _emailPattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

abstract class Validator {
  static String? emailValidator(String? value) =>
      ((value != null) && RegExp(_emailPattern).hasMatch(value)) ? null : '';

  static String? Function(String?) emptyValidatorMsg(String msg) {
    return (String? value) => (value?.isNotEmpty ?? false) ? null : msg;
  }
}
