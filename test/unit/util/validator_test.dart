import 'package:acits_flutter/util/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validator.emptyValidator', () {
    test('returns error sentinel for null/empty', () {
      expect(Validator.emptyValidator(null), '');
      expect(Validator.emptyValidator(''), '');
    });

    test('returns null for non-empty', () {
      expect(Validator.emptyValidator('a'), isNull);
      expect(Validator.emptyValidator(' '), isNull);
    });
  });

  group('Validator.emailValidator', () {
    test('accepts valid emails', () {
      expect(Validator.emailValidator('user@example.com'), isNull);
      expect(Validator.emailValidator('a.b+c@sub.domain.ru'), isNull);
    });

    test('rejects invalid / null', () {
      expect(Validator.emailValidator(null), '');
      expect(Validator.emailValidator(''), '');
      expect(Validator.emailValidator('not-an-email'), '');
      expect(Validator.emailValidator('user@'), '');
      expect(Validator.emailValidator('@example.com'), '');
    });
  });

  group('Validator.emailOrEmptyValidator', () {
    test('accepts empty (optional field)', () {
      expect(Validator.emailOrEmptyValidator(null), isNull);
      expect(Validator.emailOrEmptyValidator(''), isNull);
    });

    test('validates a non-empty value as email', () {
      expect(Validator.emailOrEmptyValidator('user@example.com'), isNull);
      expect(Validator.emailOrEmptyValidator('garbage'), '');
    });
  });

  group('Validator.intValidator', () {
    test('accepts integers, rejects the rest', () {
      expect(Validator.intValidator('42'), isNull);
      expect(Validator.intValidator('-7'), isNull);
      expect(Validator.intValidator('4.2'), '');
      expect(Validator.intValidator('abc'), '');
      expect(Validator.intValidator(null), '');
    });
  });

  group('Validator.doubleValidator', () {
    test('accepts doubles and ints, rejects the rest', () {
      expect(Validator.doubleValidator('4.2'), isNull);
      expect(Validator.doubleValidator('42'), isNull);
      expect(Validator.doubleValidator('abc'), '');
      expect(Validator.doubleValidator(null), '');
    });
  });

  group('Validator.emptyValidatorMsg', () {
    test('returns the provided message for empty, null for non-empty', () {
      final validate = Validator.emptyValidatorMsg('required');
      expect(validate(''), 'required');
      expect(validate(null), 'required');
      expect(validate('x'), isNull);
    });
  });
}
