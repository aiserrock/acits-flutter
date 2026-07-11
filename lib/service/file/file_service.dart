import 'dart:io';

import 'package:acits_flutter/service/file/file_repository.dart';
import 'package:acits_flutter/util/logger/log.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

/// Интерактор для загрузки и сохранения файлов
@injectable
class FileService {
  FileService(this._fileRepository);

  final FileRepository _fileRepository;

  /// Загрузить и сохранить PDF файл
  Future<File> loadFile(String url, String title) async {
    final filePath = await createNewFilePath(title);
    Log.info('Download file: $url → $filePath');
    try {
      await _fileRepository.getFile(url, filePath);
    } catch (e, s) {
      Log.error('Download file failed: $url', e, s);
      rethrow;
    }
    return File(filePath);
  }

  /// Создать новый уникальный путь для файла
  Future<String> createNewFilePath(String? title, {String? overrideExtension}) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final safeName = _sanitizeBaseName(title);
    return '$dir/$safeName${overrideExtension ?? ''}';
  }

  /// Привести имя файла к безопасному basename:
  /// убрать разделители путей, «..» и управляющие символы,
  /// чтобы исключить path traversal при подстановке имени с бэкенда.
  String _sanitizeBaseName(String? title) {
    final raw = (title ?? '').trim();
    // Оставляем только последний сегмент, отбрасывая любые компоненты пути.
    var name = raw.split(RegExp(r'[\\/]')).last;
    // Удаляем управляющие символы.
    name = name.replaceAll(RegExp(r'[\x00-\x1f\x7f]'), '');
    // Схлопываем последовательности точек (в т.ч. «..») в одну.
    name = name.replaceAll(RegExp(r'\.{2,}'), '.');
    // Убираем ведущие/замыкающие точки и пробелы.
    name = name.replaceAll(RegExp(r'^[.\s]+|[.\s]+$'), '');
    return name.isEmpty ? 'document' : name;
  }
}
