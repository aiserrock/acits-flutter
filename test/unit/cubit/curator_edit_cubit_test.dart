import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/ui/screen/curator/cubit/curator_edit_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStaffService extends Mock implements StaffService {}

void main() {
  late MockStaffService service;

  setUpAll(() {
    registerFallbackValue(const Curator(firstName: '', lastName: '', phoneNumber: '', address: ''));
  });

  setUp(() {
    service = MockStaffService();
    getIt.registerSingleton<StaffService>(service);
  });

  tearDown(() {
    getIt.reset();
  });

  group('CuratorEditCubit — create mode (curatorId == null)', () {
    test('initial state is DataContent with empty Curator, isEdit is false', () {
      final cubit = CuratorEditCubit();
      expect(cubit.isEdit, isFalse);
      expect(cubit.state, isA<DataContent<Curator>>());
      expect(cubit.state.valueOrNull, isA<Curator>());
      verifyNever(() => service.fetchCuratorById(id: any(named: 'id')));
      cubit.close();
    });

    blocTest<CuratorEditCubit, DataState<Curator>>(
      'submit calls createCurator and emits [loading, content(result)]',
      build: () {
        when(() => service.createCurator(curator: any(named: 'curator'))).thenAnswer(
          (_) async =>
              const Curator(id: 42, firstName: 'Anna', lastName: '', phoneNumber: '', address: ''),
        );
        return CuratorEditCubit();
      },
      act: (cubit) => cubit.submit(
        const Curator(firstName: 'Anna', lastName: '', phoneNumber: '', address: ''),
      ),
      expect: () => [
        isA<DataLoading<Curator>>(),
        isA<DataContent<Curator>>()
            .having((s) => s.data.id, 'id', 42)
            .having((s) => s.data.firstName, 'firstName', 'Anna'),
      ],
      verify: (_) {
        verify(() => service.createCurator(curator: any(named: 'curator'))).called(1);
        verifyNever(
          () => service.updateCurator(
            id: any(named: 'id'),
            curator: any(named: 'curator'),
          ),
        );
      },
    );

    blocTest<CuratorEditCubit, DataState<Curator>>(
      'submit emits [loading, error] when createCurator throws',
      build: () {
        when(
          () => service.createCurator(curator: any(named: 'curator')),
        ).thenThrow(Exception('boom'));
        return CuratorEditCubit();
      },
      act: (cubit) => cubit.submit(
        const Curator(firstName: 'Anna', lastName: '', phoneNumber: '', address: ''),
      ),
      expect: () => [isA<DataLoading<Curator>>(), isA<DataError<Curator>>()],
    );
  });

  group('CuratorEditCubit — edit mode (curatorId != null)', () {
    // `_init` is fired from the constructor and emits synchronously before a
    // `blocTest` listener can attach, so edit-mode flows are asserted on the
    // settled cubit state with `test` + await instead of on the stream.

    test('_init fetches curator by id and lands on content(curator)', () async {
      when(() => service.fetchCuratorById(id: any(named: 'id'))).thenAnswer(
        (_) async =>
            const Curator(id: 7, firstName: 'Bob', lastName: '', phoneNumber: '', address: ''),
      );

      final cubit = CuratorEditCubit(curatorId: 7);
      expect(cubit.isEdit, isTrue);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataContent<Curator>>());
      expect(cubit.state.valueOrNull?.id, 7);
      expect(cubit.state.valueOrNull?.firstName, 'Bob');
      verify(() => service.fetchCuratorById(id: 7)).called(1);
      await cubit.close();
    });

    test('_init lands on error when fetchCuratorById throws', () async {
      when(() => service.fetchCuratorById(id: any(named: 'id'))).thenThrow(Exception('not found'));

      final cubit = CuratorEditCubit(curatorId: 7);
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<DataError<Curator>>());
      verify(() => service.fetchCuratorById(id: 7)).called(1);
      await cubit.close();
    });

    test('submit calls updateCurator and lands on content(result)', () async {
      when(() => service.fetchCuratorById(id: any(named: 'id'))).thenAnswer(
        (_) async =>
            const Curator(id: 7, firstName: 'Bob', lastName: '', phoneNumber: '', address: ''),
      );
      when(
        () => service.updateCurator(
          id: any(named: 'id'),
          curator: any(named: 'curator'),
        ),
      ).thenAnswer(
        (_) async =>
            const Curator(id: 7, firstName: 'Bobby', lastName: '', phoneNumber: '', address: ''),
      );

      final cubit = CuratorEditCubit(curatorId: 7);
      await Future<void>.delayed(Duration.zero);

      final result = await cubit.submit(
        const Curator(id: 7, firstName: 'Bobby', lastName: '', phoneNumber: '', address: ''),
      );

      expect(result?.firstName, 'Bobby');
      expect(cubit.state, isA<DataContent<Curator>>());
      expect(cubit.state.valueOrNull?.firstName, 'Bobby');
      verify(() => service.updateCurator(id: 7, curator: any(named: 'curator'))).called(1);
      verifyNever(() => service.createCurator(curator: any(named: 'curator')));
      await cubit.close();
    });
  });
}
