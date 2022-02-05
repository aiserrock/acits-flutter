class Validator {
  static String? emptyValidator(String? value) => (value?.isNotEmpty ?? false) ? null : '';
}
