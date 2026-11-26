import 'package:util/util.dart';
import 'package:app_services/src/service/storage/storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Current version of the on-device storage layout. Bump it together with a new
/// step appended to [StorageMigrations] (see `doc/storage.md`).
const currentStorageSchema = 1;

/// One migration step: moves the stored data from version `index` to `index + 1`.
/// Steps must be idempotent (a failed run is retried on the next launch).
typedef StorageMigrationStep = Future<void> Function(SharedPreferences prefs);

/// Runs ordered, versioned migrations over SharedPreferences at app start.
abstract final class StorageMigrations {
  /// Ordered steps: `_steps[i]` migrates version `i` to `i + 1`.
  /// Append only; never edit or reorder a released step.
  static const List<StorageMigrationStep> _steps = [_v0to1];

  /// 0 → 1: no data changes, only records the schema version.
  static Future<void> _v0to1(SharedPreferences prefs) async {}

  /// Brings stored data up to [target].
  ///
  /// Reads the stored version (absent = 0), runs the steps in order and then
  /// writes [target]. Never throws: on any failure it logs, restores the values
  /// that were stored before the run and leaves the version untouched, so the
  /// next launch retries. A stored version newer than [target] (app downgrade)
  /// is left alone.
  ///
  /// Secure-storage data is not snapshotted: a step that touches it must write
  /// the new value before deleting the old one.
  static Future<void> run(
    SharedPreferences prefs, {
    @visibleForTesting List<StorageMigrationStep> steps = _steps,
    @visibleForTesting int target = currentStorageSchema,
  }) async {
    Map<String, Object>? snapshot;
    try {
      final stored = prefs.getInt(StorageKeys.schemaVersion) ?? 0;
      if (stored >= target) return;
      if (steps.length < target) {
        throw StateError('Missing migration steps: have ${steps.length}, need $target');
      }
      snapshot = _snapshot(prefs);
      for (var version = stored; version < target; version++) {
        await steps[version](prefs);
      }
      await prefs.setInt(StorageKeys.schemaVersion, target);
      Log.info('Storage schema migrated: $stored -> $target');
    } catch (e, s) {
      Log.warning('Storage migration failed; data left untouched', e, s);
      if (snapshot != null) await _restore(prefs, snapshot);
    }
  }

  static Map<String, Object> _snapshot(SharedPreferences prefs) => {
    for (final key in prefs.getKeys()) key: prefs.get(key)!,
  };

  static Future<void> _restore(SharedPreferences prefs, Map<String, Object> snapshot) async {
    try {
      for (final key in prefs.getKeys().difference(snapshot.keys.toSet())) {
        await prefs.remove(key);
      }
      for (final MapEntry(:key, :value) in snapshot.entries) {
        if (prefs.get(key) == value) continue;
        switch (value) {
          case final bool v:
            await prefs.setBool(key, v);
          case final int v:
            await prefs.setInt(key, v);
          case final double v:
            await prefs.setDouble(key, v);
          case final String v:
            await prefs.setString(key, v);
          case final List<String> v:
            await prefs.setStringList(key, v);
        }
      }
    } catch (e, s) {
      Log.warning('Storage migration rollback failed', e, s);
    }
  }
}
