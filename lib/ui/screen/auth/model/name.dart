import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

enum NameValidationError { empty }

@immutable
class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    return value.isEmpty ? NameValidationError.empty : null;
  }
}
