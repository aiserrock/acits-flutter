import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('Ok construction', () {
      const result = Ok<String, int>(42);
      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
      expect(result.valueOrNull, 42);
      expect(result.failureOrNull, isNull);
    });

    test('Err construction', () {
      const result = Err<String, int>('boom');
      expect(result.isOk, isFalse);
      expect(result.isErr, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.failureOrNull, 'boom');
    });

    test('fold picks onOk branch for Ok', () {
      const Result<String, int> result = Ok(10);
      final folded = result.fold((f) => 'err:$f', (v) => 'ok:$v');
      expect(folded, 'ok:10');
    });

    test('fold picks onErr branch for Err', () {
      const Result<String, int> result = Err('bad');
      final folded = result.fold((f) => 'err:$f', (v) => 'ok:$v');
      expect(folded, 'err:bad');
    });

    test('map transforms Ok value', () {
      const Result<String, int> result = Ok(5);
      final mapped = result.map((v) => v * 2);
      expect(mapped, isA<Ok<String, int>>());
      expect(mapped.valueOrNull, 10);
    });

    test('map leaves Err untouched', () {
      const Result<String, int> result = Err('fail');
      final mapped = result.map((v) => v * 2);
      expect(mapped, isA<Err<String, int>>());
      expect(mapped.failureOrNull, 'fail');
    });

    test('mapErr transforms Err failure', () {
      const Result<String, int> result = Err('fail');
      final mapped = result.mapErr((f) => f.length);
      expect(mapped, isA<Err<int, int>>());
      expect(mapped.failureOrNull, 4);
    });

    test('mapErr leaves Ok untouched', () {
      const Result<String, int> result = Ok(7);
      final mapped = result.mapErr((f) => f.length);
      expect(mapped, isA<Ok<int, int>>());
      expect(mapped.valueOrNull, 7);
    });
  });
}
