import 'package:acits_core/acits_core.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;

void main() {
  group('Failure', () {
    test('ServerFailure equal for same code/note', () {
      expect(const ServerFailure(500, 'oops'), const ServerFailure(500, 'oops'));
      expect(const ServerFailure(500, 'oops').hashCode, const ServerFailure(500, 'oops').hashCode);
    });

    test('ServerFailure differs on code', () {
      expect(const ServerFailure(500), isNot(const ServerFailure(404)));
    });

    test('ServerFailure differs on note', () {
      expect(const ServerFailure(500, 'a'), isNot(const ServerFailure(500, 'b')));
    });

    test('note defaults to null', () {
      expect(const ServerFailure(500).note, isNull);
    });

    test('subtype relationships', () {
      expect(const NoInternet(), isA<NetworkFailure>());
      expect(const Timeout(), isA<NetworkFailure>());
      expect(const ServerFailure(500), isA<NetworkFailure>());
      expect(const NoInternet(), isA<Failure>());
      expect(const AuthFailure(), isA<Failure>());
      expect(const ParseFailure(), isA<Failure>());
      expect(const UnknownFailure(), isA<Failure>());
      expect(const AuthFailure(), isNot(isA<NetworkFailure>()));
    });
  });
}
