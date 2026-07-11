import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/util/logger/log.dart';
import 'package:acits_flutter/util/url_cors_proxy.dart';

/// Репозиторий для загрузки и сохранения файлов
@injectable
class FileRepository {
  FileRepository(this._client);

  final Dio _client;

  /// Загрузить и сохранить PDF файл
  Future<void> getFile(String url, String filePath) async {
    // На web с CORS-прокси файловые URL оборачиваются так же, как API.
    url = UrlCorsProxy.add(url) ?? url;
    Log.debug('Download file: $url -> $filePath');
    try {
      await _client.download(url, filePath);
      Log.info('File saved: $filePath');
    } catch (e, s) {
      Log.error('Download file failed: $url', e, s);
      rethrow;
    }
  }
}
