import 'package:acits_flutter/di/di_container.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _proxyKey = 'proxy';
const _baseUrl = 'baseUrl';

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

  set baseUrl(String? baseUrl) {
    if (baseUrl != null) {
      _sp.setString(_baseUrl, baseUrl);
    } else {
      _sp.remove(_baseUrl);
    }
  }

  String? get baseUrl => _sp.getString(_baseUrl);
}
