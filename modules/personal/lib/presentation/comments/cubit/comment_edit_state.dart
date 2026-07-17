import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

/// Состояние экрана добавления/редактирования комментария.
///
/// Держит выбранный для прикрепления файл ([attachedFile]) и флаг отправки
/// ([isSubmitting]). Данные самой заметки приходят в конструктор экрана, поэтому
/// в состоянии не хранятся.
class CommentEditState extends Equatable {
  const CommentEditState({this.attachedFile, this.isSubmitting = false});

  /// Прикреплённый пользователем файл (или null, если ничего не выбрано).
  final PlatformFile? attachedFile;

  /// Идёт ли сейчас отправка комментария.
  final bool isSubmitting;

  CommentEditState copyWith({PlatformFile? Function()? attachedFile, bool? isSubmitting}) {
    return CommentEditState(
      attachedFile: attachedFile != null ? attachedFile() : this.attachedFile,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [attachedFile, isSubmitting];
}
