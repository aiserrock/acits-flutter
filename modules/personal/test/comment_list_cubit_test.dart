import 'package:util/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';

class MockCommentsService extends Mock implements CommentsService {}

AnimalNote _note(int id, {DateTime? createdAt}) =>
    AnimalNote(id: id, animal: 501, content: 'c$id', createdAt: createdAt ?? DateTime.utc(2024, 5, id));

void main() {
  late MockCommentsService service;

  setUp(() {
    service = MockCommentsService();
  });

  test('init loads notes sorted newest-first', () async {
    when(
      () => service.fetchAnimalNotes(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => [_note(1), _note(3), _note(2)]);

    final cubit = CommentListCubit(service: service, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final data = cubit.state.data.valueOrNull;
    expect(data, hasLength(3));
    // Отсортировано по createdAt по убыванию.
    expect(data!.map((n) => n.id).toList(), [3, 2, 1]);
  });

  test('init emits error when the service throws', () async {
    when(
      () => service.fetchAnimalNotes(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenThrow(Exception('boom'));

    final cubit = CommentListCubit(service: service, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.data, isA<DataError>());
  });

  test('deleteComment removes the note from the list on success', () async {
    when(
      () => service.fetchAnimalNotes(
        any(),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => [_note(1), _note(2)]);
    when(() => service.deleteAnimalNote(id: any(named: 'id'))).thenAnswer((_) async => true);

    final cubit = CommentListCubit(service: service, animalId: 501);
    await Future<void>.delayed(Duration.zero);

    final ok = await cubit.deleteComment(_note(2));

    expect(ok, isTrue);
    expect(cubit.state.data.valueOrNull!.map((n) => n.id), [1]);
    verify(() => service.deleteAnimalNote(id: 2)).called(1);
  });
}
