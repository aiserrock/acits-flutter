/// Every key the app persists on the device, in one place.
///
/// THESE STRINGS ARE FROZEN. They are part of the on-device storage format of
/// released builds: renaming a key or changing the encoding of its value
/// silently logs users out or drops their settings.
///
/// Rules:
/// - never rename a key string and never change how its value is encoded;
/// - only add new keys;
/// - removing a key (or changing its encoding) requires a migration step in
///   `storage_migrations.dart`, plus a bump of `currentStorageSchema`.
///
/// `test/unit/service/storage_keys_test.dart` pins each literal below, so a
/// rename fails CI. See `doc/storage.md` for the full table.
abstract final class StorageKeys {
  // ── Secure storage (Keychain / Android Keystore) ──────────────────────────

  /// Refresh token of the signed-in user. Secure storage, `String`.
  /// Written/read by `AuthRepository`.
  static const String refreshToken = 'refreshKey';

  /// Selected `ThemeMode`. Secure storage, `String` holding `ThemeMode.index`
  /// (`0` system, `1` light, `2` dark). Written/read by `ThemeStorage`.
  static const String themeMode = 'theme_mode';

  // ── SharedPreferences ─────────────────────────────────────────────────────

  /// Whether the onboarding has not been shown yet. SharedPreferences, `bool`.
  /// Written/read by `PreferenceStorage.isFirstLaunch`. Absent means first launch.
  static const String isFirstLaunch = 'isFirstKey';

  /// Id of the shelter selected for auto-login. SharedPreferences, `int`.
  /// Written/read by `PreferenceStorage.currentShelterId`; removed on logout.
  static const String currentShelterId = 'currentShelterId';

  /// User choice about analytics/crash data collection. SharedPreferences, `bool`.
  /// Written/read by `PreferenceStorage` (`CollectionPreferenceStore`).
  /// Absent means the user has not chosen yet.
  static const String collectionEnabled = 'collectionEnabled';

  /// Version of the on-device storage layout. SharedPreferences, `int`.
  /// Written/read by `StorageMigrations`. Absent means 0 (any install made
  /// before versioning existed).
  static const String schemaVersion = 'storage_schema_version';

  // ── Owned by libraries (recorded here, never written by app code) ─────────

  /// Locale chosen by the user. SharedPreferences, `String` (e.g. `ru_RU`).
  /// Owned by `easy_localization` (`saveLocale: true`, its default); the key name
  /// is hard-coded inside the library. Recorded for the migration inventory only:
  /// app code must not read or write it.
  static const String easyLocalizationLocale = 'locale';
}
