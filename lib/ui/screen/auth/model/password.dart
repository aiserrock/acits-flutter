import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
}

@immutable
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    return value.isEmpty ? PasswordValidationError.empty : null;
  }
}
