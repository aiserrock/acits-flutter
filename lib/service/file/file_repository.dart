
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Репозиторий для загрузки и сохранения файлов
@injectable
class FileRepository {
  FileRepository(this._client);

  final Dio _client;

  /// Загрузить и сохранить PDF файл
  Future<void> getFile(String url, String filePath) async {
    await _client.download(url, filePath);
  }
}
