import 'package:util/util.dart';
// `Timeout` есть и в util (Failure), и в flutter_test — берём доменный под
// префиксом, чтобы не ломать матчеры теста.
import 'package:util/util.dart' as failures show Timeout;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';

class MockCommentsRepository extends Mock implements CommentsRepository {}

AnimalNote _note(int id, {DateTime? createdAt}) =>
    AnimalNote(id: id, animal: 501, content: 'c$id', createdAt: createdAt ?? DateTime.utc(2024, 5, id));

void main() {
  late MockCommentsRepository repository;

  setUp(() {
    repository = MockCommentsRepository();
  });

  test('init loads notes sorted newest-first', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => Ok([_note(1), _note(3), _note(2)]));

    final cubit = CommentListCubit(repository: repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final data = cubit.state.data.valueOrNull;
    expect(data, hasLength(3));
    // Отсортировано по createdAt по убыванию.
    expect(data!.map((n) => n.id).toList(), [3, 2, 1]);
    await cubit.close();
  });

  test('init emits error when the repository returns a Failure', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => const Err(NoInternet()));

    final cubit = CommentListCubit(repository: repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.data, isA<DataError<List<AnimalNote>>>());
    expect((cubit.state.data as DataError<List<AnimalNote>>).error, isA<NoInternet>());
    await cubit.close();
  });

  test('deleteComment removes the note from the list on success', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => Ok([_note(1), _note(2)]));
    when(() => repository.delete(any())).thenAnswer((_) async => const Ok(null));

    final cubit = CommentListCubit(repository: repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final ok = await cubit.deleteComment(_note(2));

    expect(ok, isTrue);
    expect(cubit.state.data.valueOrNull!.map((n) => n.id), [1]);
    verify(() => repository.delete(2)).called(1);
    await cubit.close();
  });

  test('deleteComment keeps the list and reports false on a Failure', () async {
    when(
      () => repository.listByAnimal(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => Ok([_note(1), _note(2)]));
    when(() => repository.delete(any())).thenAnswer((_) async => const Err(ServerFailure(500)));

    final cubit = CommentListCubit(repository: repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final ok = await cubit.deleteComment(_note(2));

    expect(ok, isFalse);
    expect(cubit.state.data.valueOrNull!.map((n) => n.id), [2, 1]);
    await cubit.close();
  });

  test('loadNextPage appends the next page at the current offset', () async {
    when(
      () => repository.listByAnimal(any(), limit: any(named: 'limit'), offset: 0),
    ).thenAnswer((_) async => Ok([_note(2), _note(1)]));
    when(
      () => repository.listByAnimal(any(), limit: any(named: 'limit'), offset: 2),
    ).thenAnswer((_) async => Ok([_note(4), _note(3)]));

    final cubit = CommentListCubit(repository: repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    await cubit.loadNextPage();

    expect(cubit.state.data.valueOrNull!.map((n) => n.id), [4, 3, 2, 1]);
    expect(cubit.state.page, isA<DataContent<Object?>>());
    verify(() => repository.listByAnimal(501, limit: any(named: 'limit'), offset: 2)).called(1);
    await cubit.close();
  });

  test('loadNextPage puts the Failure on the page state, keeping the list', () async {
    when(
      () => repository.listByAnimal(any(), limit: any(named: 'limit'), offset: 0),
    ).thenAnswer((_) async => Ok([_note(2), _note(1)]));
    when(
      () => repository.listByAnimal(any(), limit: any(named: 'limit'), offset: 2),
    ).thenAnswer((_) async => const Err(failures.Timeout()));

    final cubit = CommentListCubit(repository: repository, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    await cubit.loadNextPage();

    expect(cubit.state.data.valueOrNull!.map((n) => n.id), [2, 1]);
    expect(cubit.state.page, isA<DataError<Object?>>());
    expect((cubit.state.page as DataError<Object?>).error, isA<failures.Timeout>());
    await cubit.close();
  });
}
