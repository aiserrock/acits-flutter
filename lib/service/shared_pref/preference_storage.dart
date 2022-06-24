import 'package:acits_flutter/di/di_container.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _proxyKey = 'proxy';
const _isFirstKey = 'isFirstKey';

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

  bool? get isFirstLaunch => _sp.getBool(_isFirstKey);

  set isFirstLaunch(bool? isFirst) => _sp.setBool(_isFirstKey, isFirst ?? false);
}
