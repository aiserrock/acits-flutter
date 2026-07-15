import 'package:acits_flutter/di/di_container.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isFirstKey = 'isFirstKey';
const _currentShelterKey = 'currentShelterId';

@injectable
class PreferenceStorage {
  SharedPreferences get _sp => getIt.get<SharedPreferences>();

  bool? get isFirstLaunch => _sp.getBool(_isFirstKey);

  set isFirstLaunch(bool? isFirst) => _sp.setBool(_isFirstKey, isFirst ?? false);

  /// ID выбранного приюта — для автовхода без экрана выбора. Не секрет, поэтому
  /// SharedPreferences (а не secure storage).
  int? get currentShelterId => _sp.getInt(_currentShelterKey);

  set currentShelterId(int? id) {
    if (id == null) {
      _sp.remove(_currentShelterKey);
    } else {
      _sp.setInt(_currentShelterKey, id);
    }
  }
}
