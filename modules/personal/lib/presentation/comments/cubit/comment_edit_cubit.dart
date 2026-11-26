import 'package:util/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/presentation/comments/comments.dart';

/// Cubit экрана добавления/редактирования комментария к животному.
///
/// Управляет прикреплённым файлом и жизненным циклом отправки. Текст
/// комментария остаётся в [TextEditingController] на стороне виджета. Данные —
/// доменные [AnimalNote] из [CommentsRepository] (Result, без DTO).
class CommentEditCubit extends Cubit<CommentEditState> {
  CommentEditCubit({required CommentsRepository repository, required this.animalId, this.comment})
    : _repository = repository,
      super(const CommentEditState());

  final CommentsRepository _repository;

  /// ID животного, к которому относится комментарий.
  final int animalId;

  /// Редактируемый комментарий (null — создание нового).
  final AnimalNote? comment;

  /// Режим редактирования существующего комментария.
  bool get isEdit => comment != null;

  /// Прикрепить выбранный пользователем файл.
  void attachFile(PlatformFile file) {
    safeEmit(state.copyWith(attachedFile: () => file));
  }

  /// Сбросить прикреплённый файл.
  void clearAttachedFile() {
    safeEmit(state.copyWith(attachedFile: () => null));
  }

  /// Отправить комментарий на сервер.
  ///
  /// Возвращает созданный/обновлённый [AnimalNote] при успехе, либо `null` при
  /// ошибке. По завершении неуспешной отправки сбрасывает флаг отправки.
  Future<AnimalNote?> submit(String text) async {
    Log.debug('CommentEditCubit.submit isEdit=$isEdit animalId=$animalId');
    safeEmit(state.copyWith(isSubmitting: true));
    final file = state.attachedFile;
    final files = file == null ? <AnimalNoteFileInput>[] : await _toInputs([file]);
    final source = comment;

    final result = source != null
        ? await _repository.patch(id: source.id, animalId: source.animal, text: text, files: files)
        : await _repository.create(animalId: animalId, text: text, files: files);

    return result.fold(
      (failure) {
        Log.error('CommentEditCubit.submit failed: $failure');
        safeEmit(state.copyWith(isSubmitting: false));
        return null;
      },
      (note) {
        Log.info('CommentEditCubit.submit ok: id=${note.id}');
        return note;
      },
    );
  }

  /// Выбранные файлы → доменные входные данные. Байты читаем через
  /// [PlatformFile.readAsBytes] — одинаково на web и нативе. Файлы, которые не
  /// удалось прочитать, отбрасываем.
  Future<List<AnimalNoteFileInput>> _toInputs(List<PlatformFile> files) async {
    final inputs = <AnimalNoteFileInput>[];
    for (final file in files) {
      try {
        inputs.add(AnimalNoteFileInput(name: file.name, bytes: await file.readAsBytes(), extension: file.extension));
      } catch (e) {
        Log.error('CommentEditCubit: cannot read attached file ${file.name}: $e');
      }
    }
    return inputs;
  }
}
