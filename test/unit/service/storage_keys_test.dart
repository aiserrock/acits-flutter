import 'package:app_services/src/service/auth/auth_repository.dart';
import 'package:app_services/src/service/storage/storage_keys.dart';
import 'package:app_services/src/service/theme/theme_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

/// Golden test: these strings are the on-device storage format of released
/// builds. If one of these expectations fails, do NOT edit the expected value:
/// revert the rename (see `doc/storage.md`).
void main() {
  test('StorageKeys literals are frozen', () {
    expect(StorageKeys.refreshToken, 'refreshKey');
    expect(StorageKeys.themeMode, 'theme_mode');
    expect(StorageKeys.isFirstLaunch, 'isFirstKey');
    expect(StorageKeys.currentShelterId, 'currentShelterId');
    expect(StorageKeys.collectionEnabled, 'collectionEnabled');
    expect(StorageKeys.schemaVersion, 'storage_schema_version');
    expect(StorageKeys.easyLocalizationLocale, 'locale');
  });

  group('secure storage still uses the frozen keys', () {
    late MockSecureStorage secure;

    setUp(() {
      secure = MockSecureStorage();
      when(
        () => secure.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(() => secure.read(key: any(named: 'key'))).thenAnswer((_) async => null);
      when(() => secure.delete(key: any(named: 'key'))).thenAnswer((_) async {});
    });

    test('AuthRepository: refreshKey', () async {
      final repo = AuthRepository(secure);
      await repo.setRefresh('tok');
      await repo.refresh;
      await repo.clearRefresh();
      verify(() => secure.write(key: 'refreshKey', value: 'tok')).called(1);
      verify(() => secure.read(key: 'refreshKey')).called(1);
      verify(() => secure.delete(key: 'refreshKey')).called(1);
    });

    test('ThemeStorage: theme_mode holds ThemeMode.index as a string', () async {
      final storage = ThemeStorage(secure);
      await storage.write(ThemeMode.dark);
      verify(() => secure.write(key: 'theme_mode', value: '2')).called(1);

      when(() => secure.read(key: 'theme_mode')).thenAnswer((_) async => '1');
      expect(await storage.read(), ThemeMode.light);
    });
  });
}
