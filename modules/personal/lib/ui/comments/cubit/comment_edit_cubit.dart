import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/comments_service.dart';
import '../../../domain/animal_note.dart';
import '../../../util/bloc_ext.dart';
import '../../../util/log.dart';
import 'comment_edit_state.dart';

/// Cubit экрана добавления/редактирования комментария к животному.
///
/// Управляет прикреплённым файлом и жизненным циклом отправки. Текст
/// комментария остаётся в [TextEditingController] на стороне виджета.
class CommentEditCubit extends Cubit<CommentEditState> {
  CommentEditCubit({required CommentsService service, required this.animalId, this.comment})
    : _service = service,
      super(const CommentEditState());

  final CommentsService _service;

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
  /// Возвращает созданный/обновлённый [AnimalNote] при успехе, либо
  /// пробрасывает исключение. По завершении сбрасывает флаг отправки.
  Future<AnimalNote?> submit(String text) async {
    Log.debug('CommentEditCubit.submit isEdit=$isEdit animalId=$animalId');
    safeEmit(state.copyWith(isSubmitting: true));
    final file = state.attachedFile;
    final files = file != null ? [file] : <PlatformFile>[];
    final source = comment;
    try {
      final result = source != null
          ? await _service.patchAnimalNote(id: source.id, animalId: source.animal, text: text, files: files)
          : await _service.createAnimalNote(animalId: animalId, text: text, files: files);
      Log.info('CommentEditCubit.submit ok: id=${result?.id}');
      return result;
    } catch (e, s) {
      Log.error('CommentEditCubit.submit failed', e, s);
      safeEmit(state.copyWith(isSubmitting: false));
      rethrow;
    }
  }
}
