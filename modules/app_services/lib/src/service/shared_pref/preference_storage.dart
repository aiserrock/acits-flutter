import 'package:di/di.dart';
import 'package:injectable/injectable.dart';
import 'package:observability/observability.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isFirstKey = 'isFirstKey';
const _currentShelterKey = 'currentShelterId';
const _collectionEnabledKey = 'collectionEnabled';

@injectable
class PreferenceStorage implements CollectionPreferenceStore {
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

  @override
  bool? readCollectionEnabled() => _sp.getBool(_collectionEnabledKey);

  @override
  Future<void> writeCollectionEnabled(bool enabled) => _sp.setBool(_collectionEnabledKey, enabled);
}
