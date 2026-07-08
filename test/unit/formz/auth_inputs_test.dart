import 'package:acits_flutter/ui/screen/auth/model/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Name formz input', () {
    test('.pure() is pure and starts empty', () {
      const input = Name.pure();
      expect(input.isPure, isTrue);
      expect(input.value, '');
    });

    test('.dirty("") is not pure, invalid, emits empty error', () {
      const input = Name.dirty('');
      expect(input.isPure, isFalse);
      expect(input.isValid, isFalse);
      expect(input.validator(''), NameValidationError.empty);
      expect(input.error, NameValidationError.empty);
    });

    test('.dirty("x") is valid with no error', () {
      const input = Name.dirty('x');
      expect(input.isPure, isFalse);
      expect(input.isValid, isTrue);
      expect(input.validator('x'), isNull);
      expect(input.error, isNull);
    });
  });

  group('Password formz input', () {
    test('.pure() is pure and starts empty', () {
      const input = Password.pure();
      expect(input.isPure, isTrue);
      expect(input.value, '');
    });

    test('.dirty("") is not pure, invalid, emits empty error', () {
      const input = Password.dirty('');
      expect(input.isPure, isFalse);
      expect(input.isValid, isFalse);
      expect(input.validator(''), PasswordValidationError.empty);
      expect(input.error, PasswordValidationError.empty);
    });

    test('.dirty("x") is valid with no error', () {
      const input = Password.dirty('x');
      expect(input.isPure, isFalse);
      expect(input.isValid, isTrue);
      expect(input.validator('x'), isNull);
      expect(input.error, isNull);
    });
  });

  group('FocusTargetX', () {
    test('isPassword true only for password', () {
      expect(FocusTarget.password.isPassword, isTrue);
      expect(FocusTarget.name.isPassword, isFalse);
      expect(FocusTarget.another.isPassword, isFalse);
    });

    test('isName true only for name', () {
      expect(FocusTarget.name.isName, isTrue);
      expect(FocusTarget.password.isName, isFalse);
      expect(FocusTarget.another.isName, isFalse);
    });
  });
}
