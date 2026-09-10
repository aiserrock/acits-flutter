import 'dart:typed_data';

/// Доменные входные данные вложения заметки — DTO-free форма того, что выбрал
/// пользователь. Репозиторий разворачивает это в write-DTO (включая base64).
///
/// Байты уже прочитаны на стороне presentation (выбор файла — платформенная
/// операция), кодирование под провод остаётся заботой data-слоя. Паттерн из
/// `AnimalImageInput` в модуле animals.
class AnimalNoteFileInput {
  const AnimalNoteFileInput({required this.name, required this.bytes, this.extension});

  /// Имя файла как его выбрал пользователь (с расширением).
  final String name;

  /// Содержимое файла.
  final Uint8List bytes;

  /// Расширение без точки (`pdf`, `docx`), если известно.
  final String? extension;
}
