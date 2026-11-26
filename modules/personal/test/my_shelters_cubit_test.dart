import 'package:core/domain.dart' show Shelter;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';
import 'package:util/util.dart';

class MockMySheltersSource extends Mock implements MySheltersSource {}

const _a = Shelter(id: 1, name: 'Alpha');
const _b = Shelter(id: 2, name: 'Beta');

void main() {
  late MockMySheltersSource source;

  setUp(() {
    source = MockMySheltersSource();
    when(() => source.currentShelterId).thenReturn(1);
  });

  test('starts in loading', () async {
    final cubit = MySheltersCubit(source);
    expect(cubit.state, isA<DataLoading<List<Shelter>>>());
    await cubit.close();
  });

  test('load emits content with the shelters', () async {
    when(() => source.load()).thenAnswer((_) async => const Ok([_a, _b]));

    final cubit = MySheltersCubit(source);
    await cubit.load();

    expect(cubit.state.valueOrNull, [_a, _b]);
    expect(cubit.currentShelterId, 1);
    await cubit.close();
  });

  test('load emits empty content for an empty list', () async {
    when(() => source.load()).thenAnswer((_) async => const Ok(<Shelter>[]));

    final cubit = MySheltersCubit(source);
    await cubit.load();

    expect(cubit.state, isA<DataContent<List<Shelter>>>());
    expect(cubit.state.valueOrNull, isEmpty);
    await cubit.close();
  });

  test('load emits the Failure on error', () async {
    when(() => source.load()).thenAnswer((_) async => const Err(NoInternet()));

    final cubit = MySheltersCubit(source);
    await cubit.load();

    expect(cubit.state, isA<DataError<List<Shelter>>>());
    expect((cubit.state as DataError<List<Shelter>>).error, isA<NoInternet>());
    await cubit.close();
  });

  test('load after a failure goes through loading and recovers', () async {
    var calls = 0;
    when(() => source.load()).thenAnswer((_) async => ++calls == 1 ? const Err(NoInternet()) : const Ok([_a]));

    final cubit = MySheltersCubit(source);
    await cubit.load();
    expect(cubit.state.hasError, isTrue);

    final states = <DataState<List<Shelter>>>[];
    final sub = cubit.stream.listen(states.add);
    await cubit.load();
    await sub.cancel();

    expect(states.first, isA<DataLoading<List<Shelter>>>());
    expect(cubit.state.valueOrNull, [_a]);
    verify(() => source.load()).called(2);
    await cubit.close();
  });

  test('refresh keeps the current content until the new list arrives', () async {
    when(() => source.load()).thenAnswer((_) async => const Ok([_a]));
    final cubit = MySheltersCubit(source);
    await cubit.load();

    when(() => source.load()).thenAnswer((_) async => const Ok([_a, _b]));
    final states = <DataState<List<Shelter>>>[];
    final sub = cubit.stream.listen(states.add);
    await cubit.refresh();
    await sub.cancel();

    expect(states.any((s) => s.isLoading), isFalse);
    expect(cubit.state.valueOrNull, [_a, _b]);
    await cubit.close();
  });
}
