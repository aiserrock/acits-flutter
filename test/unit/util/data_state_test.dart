import 'package:acits_flutter/util/data_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DataState variants', () {
    test('loading', () {
      const state = DataState<int>.loading();
      expect(state.isLoading, isTrue);
      expect(state.isContent, isFalse);
      expect(state.hasError, isFalse);
      expect(state.valueOrNull, isNull);
    });

    test('content', () {
      const state = DataState<int>.content(7);
      expect(state.isContent, isTrue);
      expect(state.isLoading, isFalse);
      expect(state.hasError, isFalse);
      expect(state.valueOrNull, 7);
    });

    test('error', () {
      final err = Exception('boom');
      final state = DataState<int>.error(err);
      expect(state.hasError, isTrue);
      expect(state.isContent, isFalse);
      expect(state.isLoading, isFalse);
      expect(state.valueOrNull, isNull);
      expect((state as DataError<int>).error, err);
    });
  });

  group('equality (Equatable)', () {
    test('same variant + payload are equal', () {
      expect(const DataContent(1), const DataContent(1));
      expect(const DataLoading<int>(), const DataLoading<int>());
    });

    test('different payload not equal', () {
      expect(const DataContent(1) == const DataContent(2), isFalse);
    });

    test('different variant not equal', () {
      const DataState<int> loading = DataLoading<int>();
      const DataState<int> content = DataContent(1);
      expect(loading, isNot(equals(content)));
    });
  });
}
