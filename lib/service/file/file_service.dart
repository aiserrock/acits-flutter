import 'dart:io';

import 'package:acits_flutter/service/file/file_repository.dart';
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
    await _fileRepository.getFile(url, filePath);
    final file = File(filePath);
    return file;
  }

  /// Создать новый уникальный путь для файла
  Future<String> createNewFilePath(String? title, {String? overrideExtension}) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    return '$dir/${title ?? 'document'}${overrideExtension ?? ''}';
  }
}
