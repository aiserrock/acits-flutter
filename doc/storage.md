# On-device storage

All persisted keys live in `StorageKeys`
(`modules/app_services/lib/src/service/storage/storage_keys.dart`). After the
first store release these strings are a frozen on-device format.

## Keys

| Key string | Store | Type | Written by | Read by |
| --- | --- | --- | --- | --- |
| `refreshKey` | secure storage | String (refresh token) | `AuthRepository.setRefresh` / `clearRefresh` | `AuthRepository.refresh` |
| `theme_mode` | secure storage | String (`ThemeMode.index`: 0 system, 1 light, 2 dark) | `ThemeStorage.write` | `ThemeStorage.read` |
| `isFirstKey` | SharedPreferences | bool (absent = first launch) | `PreferenceStorage.isFirstLaunch=` (via `ConfigService.setFirstLaunch`) | `PreferenceStorage.isFirstLaunch` (via `ConfigService`, splash) |
| `currentShelterId` | SharedPreferences | int (removed on logout) | `PreferenceStorage.currentShelterId=` (`AuthService`) | `PreferenceStorage.currentShelterId` (`AuthService`) |
| `collectionEnabled` | SharedPreferences | bool (absent = not chosen) | `PreferenceStorage.writeCollectionEnabled` | `PreferenceStorage.readCollectionEnabled` (observability `CollectionSettings`) |
| `storage_schema_version` | SharedPreferences | int (absent = 0) | `StorageMigrations.run` | `StorageMigrations.run` |
| `locale` | SharedPreferences | String (e.g. `ru_RU`) | `easy_localization` (`saveLocale` default true) | `easy_localization` at start-up |

`locale` belongs to the library; its name is hard-coded in `easy_localization`
and the app never touches it. It is listed in `StorageKeys.easyLocalizationLocale`
for the inventory only.

Dev-build only (not in release builds), `test/dev/service/shared_pref/debug_preference_storage.dart`,
SharedPreferences: `proxy` (String), `proxyEnabled` (bool), `baseUrl` (String),
`customUrl` (String). These literals are not yet in `StorageKeys`.

## Freeze rule

- Never rename a key string and never change the encoding of a stored value.
- Only add keys. Give each a doc comment in `StorageKeys` and a row above.
- Removing a key, or changing a value encoding, needs a migration step.
- `test/unit/service/storage_keys_test.dart` pins every literal. If it fails,
  revert the rename; do not edit the expected string.

## Migrations

`StorageMigrations.run` (`storage_migrations.dart`) is called from
`SharedPreferenceRegister.createSp`, the `@preResolve` factory, so it finishes
before any code reads SharedPreferences. It reads `storage_schema_version`
(absent = 0), runs the steps above that version in order, then writes
`currentStorageSchema`. It never throws: on failure it logs, restores the
SharedPreferences values it had before the run, and leaves the version
unchanged so the next launch retries. A stored version newer than the app
(downgrade) is left alone.

### Add a migration step

1. Append a function to `StorageMigrations._steps`. `_steps[i]` migrates
   version `i` to `i + 1`. Never edit, reorder or delete a released step.
2. Bump `currentStorageSchema` to `_steps.length`.
3. Make the step idempotent: it can run again after a failed attempt. For
   secure storage (not rolled back), write the new value before deleting the old.
4. Add a test in `test/unit/service/storage_migrations_test.dart` that starts
   from the previous layout and checks the result.
5. Add or update the key's row in this file and its doc comment in `StorageKeys`.

Steps: `0 -> 1` is a no-op that records the version (every install made before
versioning has no stored version).
