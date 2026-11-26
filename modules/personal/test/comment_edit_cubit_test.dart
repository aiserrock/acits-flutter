import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal/personal.dart';
import 'package:util/util.dart';

class MockCommentsRepository extends Mock implements CommentsRepository {}

/// Выбранный файл без платформы: отдаёт заданные байты или падает при чтении.
final class _FakeFile extends PlatformFile {
  _FakeFile(this.name, {this.content});

  @override
  final String name;

  final List<int>? content;

  @override
  Uri get uri => Uri.parse('content://fake/$name');

  @override
  Never get xFile => throw UnimplementedError();

  @override
  int? lengthSync() => content?.length;

  @override
  Future<int?> length() async => content?.length;

  @override
  Future<Uint8List> readAsBytes() async {
    final bytes = content;
    if (bytes == null) throw StateError('unreadable');
    return Uint8List.fromList(bytes);
  }

  @override
  Stream<Uint8List> readAsByteStream() => Stream.fromFuture(readAsBytes());
}

void main() {
  late MockCommentsRepository repository;

  setUpAll(() => registerFallbackValue(<AnimalNoteFileInput>[]));

  setUp(() {
    repository = MockCommentsRepository();
    when(
      () => repository.create(
        animalId: any(named: 'animalId'),
        text: any(named: 'text'),
        files: any(named: 'files'),
      ),
    ).thenAnswer((_) async => Ok(AnimalNote(id: 1, animal: 501, content: 'c', createdAt: DateTime.utc(2024))));
  });

  List<AnimalNoteFileInput> sentFiles() =>
      verify(
            () => repository.create(
              animalId: 501,
              text: 'text',
              files: captureAny(named: 'files'),
            ),
          ).captured.single
          as List<AnimalNoteFileInput>;

  test('submit sends the bytes, name and extension of the attached file', () async {
    final cubit = CommentEditCubit(repository: repository, animalId: 501);
    cubit.attachFile(_FakeFile('report.pdf', content: [1, 2, 3]));

    final note = await cubit.submit('text');

    expect(note, isNotNull);
    final file = sentFiles().single;
    expect(file.name, 'report.pdf');
    expect(file.extension, 'pdf');
    expect(file.bytes, [1, 2, 3]);
    await cubit.close();
  });

  test('submit drops an attached file that cannot be read and still sends the comment', () async {
    final cubit = CommentEditCubit(repository: repository, animalId: 501);
    cubit.attachFile(_FakeFile('broken.docx'));

    final note = await cubit.submit('text');

    expect(note, isNotNull);
    expect(sentFiles(), isEmpty);
    await cubit.close();
  });

  test('submit without an attachment sends no files', () async {
    final cubit = CommentEditCubit(repository: repository, animalId: 501);

    await cubit.submit('text');

    expect(sentFiles(), isEmpty);
    await cubit.close();
  });
}
