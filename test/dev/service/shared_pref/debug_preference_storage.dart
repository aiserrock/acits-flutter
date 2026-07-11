import 'package:acits_flutter/di/di_container.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _proxyKey = 'proxy';
const _proxyEnabledKey = 'proxyEnabled';
const _baseUrl = 'baseUrl';
const _customUrlKey = 'customUrl';

/// Хранилище debug-настроек (dev-сборка), переживает перезапуск приложения.
///
/// - [baseUrl] — выбранный контур из списка (prod/stage/dev-N) либо custom URL.
/// - [customUrl] — последний введённый custom/mockoon адрес (запоминается
///   отдельно, чтобы не терялся при переключении на другой контур).
/// - [proxy] / [proxyEnabled] — адрес и флаг прокси (Charles/mitmproxy).
@injectable
@dev
class DebugPreferenceStorage {
  SharedPreferences get _sp => getIt.get<SharedPreferences>();

  set proxy(String? proxyUrl) {
    if (proxyUrl != null) {
      _sp.setString(_proxyKey, proxyUrl);
    } else {
      _sp.remove(_proxyKey);
    }
  }

  String? get proxy => _sp.getString(_proxyKey);

  /// Включён ли прокси (Charles). При выключенном — адрес не применяется.
  set proxyEnabled(bool value) => _sp.setBool(_proxyEnabledKey, value);

  bool get proxyEnabled => _sp.getBool(_proxyEnabledKey) ?? false;

  set baseUrl(String? baseUrl) {
    if (baseUrl != null) {
      _sp.setString(_baseUrl, baseUrl);
    } else {
      _sp.remove(_baseUrl);
    }
  }

  String? get baseUrl => _sp.getString(_baseUrl);

  /// Последний введённый custom/mockoon URL (сохраняется независимо от того,
  /// выбран ли сейчас контур Custom).
  set customUrl(String? url) {
    if (url != null) {
      _sp.setString(_customUrlKey, url);
    } else {
      _sp.remove(_customUrlKey);
    }
  }

  String? get customUrl => _sp.getString(_customUrlKey);
}
