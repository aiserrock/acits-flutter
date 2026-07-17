import 'package:equatable/equatable.dart';

import '../../../domain/animal.dart';

/// Режим экрана редактирования животного: заполнение формы или экран успеха.
enum AnimalEditMode { form, success }

/// Контент состояния модульного [AnimalEditCubit].
///
/// Держит текущий [mode] (форма/успех) и загруженную сущность [animal]
/// (в режиме редактирования — из репозитория, иначе `null`). Обёрнут в
/// `DataState<AnimalEditContent>`, чтобы разделять loading/error/content.
///
/// В отличие от прежнего корневого состояния, здесь домен [Animal] — не DTO
/// `AnimalRead`: write-путь замкнут на репозиторий модуля.
class AnimalEditContent extends Equatable {
  const AnimalEditContent({this.mode = AnimalEditMode.form, this.animal});

  final AnimalEditMode mode;

  /// Загруженная сущность (только для режима редактирования).
  final Animal? animal;

  AnimalEditContent copyWith({AnimalEditMode? mode, Animal? animal}) {
    return AnimalEditContent(mode: mode ?? this.mode, animal: animal ?? this.animal);
  }

  @override
  List<Object?> get props => [mode, animal];
}
