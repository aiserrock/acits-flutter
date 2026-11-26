import 'package:app_services/src/service/shared_pref/preference_storage.dart';
import 'package:app_services/src/service/storage/storage_keys.dart';
import 'package:app_services/src/service/storage/storage_migrations.dart';
import 'package:di/di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _existing = <String, Object>{
  'isFirstKey': false,
  'currentShelterId': 7,
  'collectionEnabled': true,
  'locale': 'ru_RU',
};

Future<SharedPreferences> _prefs([Map<String, Object> values = _existing]) async {
  SharedPreferences.setMockInitialValues(values);
  return SharedPreferences.getInstance();
}

void main() {
  test('absent version -> current: keeps values and writes the version', () async {
    final prefs = await _prefs();

    await StorageMigrations.run(prefs);

    expect(prefs.getInt(StorageKeys.schemaVersion), currentStorageSchema);
    expect(currentStorageSchema, 1);
    for (final e in _existing.entries) {
      expect(prefs.get(e.key), e.value, reason: e.key);
    }
  });

  test('existing values stay readable through PreferenceStorage after migration', () async {
    final prefs = await _prefs();
    getIt.registerSingleton<SharedPreferences>(prefs);
    addTearDown(getIt.reset);

    await StorageMigrations.run(prefs);

    final storage = PreferenceStorage();
    expect(storage.isFirstLaunch, false);
    expect(storage.currentShelterId, 7);
    expect(storage.readCollectionEnabled(), true);
  });

  test('fresh install (no data) just records the version', () async {
    final prefs = await _prefs({});

    await StorageMigrations.run(prefs);

    expect(prefs.getKeys(), {StorageKeys.schemaVersion});
    expect(prefs.getInt(StorageKeys.schemaVersion), currentStorageSchema);
  });

  test('running twice is idempotent and does not rerun steps', () async {
    final prefs = await _prefs();
    var calls = 0;
    Future<void> step(SharedPreferences p) async => calls++;

    await StorageMigrations.run(prefs, steps: [step], target: 1);
    final afterFirst = {for (final k in prefs.getKeys()) k: prefs.get(k)};
    await StorageMigrations.run(prefs, steps: [step], target: 1);
    final afterSecond = {for (final k in prefs.getKeys()) k: prefs.get(k)};

    expect(calls, 1);
    expect(afterSecond, afterFirst);
    expect(prefs.getInt(StorageKeys.schemaVersion), 1);
  });

  test('runs only the steps above the stored version, in order', () async {
    final prefs = await _prefs({StorageKeys.schemaVersion: 1});
    final ran = <int>[];

    await StorageMigrations.run(
      prefs,
      steps: [(_) async => ran.add(0), (_) async => ran.add(1), (_) async => ran.add(2)],
      target: 3,
    );

    expect(ran, [1, 2]);
    expect(prefs.getInt(StorageKeys.schemaVersion), 3);
  });

  test('a failing step leaves values untouched, keeps the old version and does not throw', () async {
    final prefs = await _prefs();

    await expectLater(
      StorageMigrations.run(
        prefs,
        steps: [
          (p) async {
            await p.setInt('currentShelterId', 999);
            await p.remove('isFirstKey');
            await p.setString('partial', 'x');
            throw StateError('boom');
          },
        ],
        target: 1,
      ),
      completes,
    );

    expect(prefs.getKeys(), _existing.keys.toSet());
    for (final e in _existing.entries) {
      expect(prefs.get(e.key), e.value, reason: e.key);
    }
    expect(prefs.containsKey(StorageKeys.schemaVersion), isFalse);
  });

  test('a failing later step does not record a partial version', () async {
    final prefs = await _prefs({StorageKeys.schemaVersion: 0, ..._existing});

    await StorageMigrations.run(
      prefs,
      steps: [(p) async => p.setBool('collectionEnabled', false), (_) async => throw StateError('boom')],
      target: 2,
    );

    expect(prefs.getBool('collectionEnabled'), true);
    expect(prefs.getInt(StorageKeys.schemaVersion), 0);
  });

  test('a stored version newer than the app (downgrade) is left alone', () async {
    final prefs = await _prefs({StorageKeys.schemaVersion: 5, ..._existing});

    await StorageMigrations.run(prefs);

    expect(prefs.getInt(StorageKeys.schemaVersion), 5);
  });
}
