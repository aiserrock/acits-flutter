import 'package:util/util.dart';
import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthSessionApi extends Mock implements AuthSessionApi {}

void main() {
  late MockAuthSessionApi authService;
  const link = 'confirm-link';

  setUp(() {
    authService = MockAuthSessionApi();
  });

  EmailConfirmCubit build() => EmailConfirmCubit(authService: authService, confirmLink: link);

  group('EmailConfirmCubit', () {
    test('constructor triggers confirm -> emits [loading, content(null)] on success', () async {
      when(() => authService.confirmEmail(any())).thenAnswer((_) async {});
      final emitted = <DataState<void>>[];
      final cubit = build();
      final sub = cubit.stream.listen(emitted.add);

      // Начальное состояние — loading, затем content после await'а в конструкторе.
      expect(cubit.state, const DataLoading<void>());
      await Future<void>.delayed(Duration.zero);

      expect(emitted, const [DataContent<void>(null)]);
      expect(cubit.state, const DataContent<void>(null));
      verify(() => authService.confirmEmail(link)).called(1);
      await sub.cancel();
      await cubit.close();
    });

    test('ends in error state when confirmEmail throws', () async {
      when(() => authService.confirmEmail(any())).thenThrow(Exception('boom'));
      final cubit = build();
      // Исключение пробрасывается синхронно и ловится в конструкторе.
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataError<void>>());
      verify(() => authService.confirmEmail(link)).called(1);
      await cubit.close();
    });

    test('retry() re-runs confirmEmail and re-emits [loading, content(null)]', () async {
      when(() => authService.confirmEmail(any())).thenAnswer((_) async {});
      final cubit = build();
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state, const DataContent<void>(null));

      final emitted = <DataState<void>>[];
      final sub = cubit.stream.listen(emitted.add);
      await cubit.retry();
      await Future<void>.delayed(Duration.zero);

      expect(emitted, const [DataLoading<void>(), DataContent<void>(null)]);
      expect(cubit.state, const DataContent<void>(null));
      verify(() => authService.confirmEmail(link)).called(2);
      await sub.cancel();
      await cubit.close();
    });
  });
}
