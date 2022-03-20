import 'package:acits_flutter/di/di_container.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _proxyKey = 'proxy';

@injectable
class PreferenceStorage {
  set proxy(String? proxyUrl) {
    if (proxyUrl != null) {
      _sp.setString(_proxyKey, proxyUrl);
    } else {
      _sp.remove(_proxyKey);
    }
  }

  String? get proxy => _sp.getString(_proxyKey);

  SharedPreferences get _sp => getIt.get<SharedPreferences>();
}
