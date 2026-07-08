import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:equatable/equatable.dart';

/// Режим экрана редактирования животного: заполнение формы или экран успеха.
enum AnimalEditScreenMode { form, success }

/// Контент состояния экрана редактирования животного.
///
/// Держит текущий [mode] (форма/успех) и загруженное животное [animal]
/// (в режиме редактирования — с сервера, иначе `null`). Обёрнут в
/// `DataState<AnimalEditContent>`, чтобы разделять loading/error/content.
class AnimalEditContent extends Equatable {
  const AnimalEditContent({this.mode = AnimalEditScreenMode.form, this.animal});

  /// Текущий режим экрана.
  final AnimalEditScreenMode mode;

  /// Загруженное животное (только для режима редактирования).
  final AnimalRead? animal;

  AnimalEditContent copyWith({AnimalEditScreenMode? mode, AnimalRead? animal}) {
    return AnimalEditContent(mode: mode ?? this.mode, animal: animal ?? this.animal);
  }

  @override
  List<Object?> get props => [mode, animal];
}
