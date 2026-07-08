import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/comments/cubit/comment_edit_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit экрана добавления/редактирования комментария к животному.
///
/// Управляет прикреплённым файлом и жизненным циклом отправки. Текст
/// комментария остаётся в [TextEditingController] на стороне виджета.
class CommentEditCubit extends Cubit<CommentEditState> {
  CommentEditCubit({required this.animalId, this.comment})
    : _animalService = getIt<AnimalService>(),
      super(const CommentEditState());

  final AnimalService _animalService;

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
    safeEmit(state.copyWith(isSubmitting: true));
    final file = state.attachedFile;
    final files = file != null ? [file] : <PlatformFile>[];
    final source = comment;
    try {
      final result = source != null
          ? await _animalService.patchAnimalNote(
              id: source.id!,
              animalId: source.animal!,
              text: text,
              files: files,
            )
          : await _animalService.createAnimalNote(animalId: animalId, text: text, files: files);
      return result;
    } catch (_) {
      safeEmit(state.copyWith(isSubmitting: false));
      rethrow;
    }
  }
}
