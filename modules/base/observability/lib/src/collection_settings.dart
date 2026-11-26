/// Where the user's choice about data collection is kept.
abstract interface class CollectionPreferenceStore {
  /// The stored choice, or `null` when the user has never changed it.
  bool? readCollectionEnabled();

  Future<void> writeCollectionEnabled(bool enabled);
}

/// Applies a collection switch to one backend (analytics, crash reporting, ...).
typedef CollectionSwitch = Future<void> Function(bool enabled);

/// The user's opt-out for analytics and error reporting. Collection is on until
/// the user turns it off; the choice survives restarts.
final class CollectionSettings {
  CollectionSettings({required CollectionPreferenceStore store, required List<CollectionSwitch> switches})
    : _store = store,
      _switches = switches;

  final CollectionPreferenceStore _store;
  final List<CollectionSwitch> _switches;

  bool get isEnabled => _store.readCollectionEnabled() ?? true;

  /// Applies the stored choice to every backend. Call once at startup.
  Future<void> apply() => _applyToAll(isEnabled);

  /// Stores [enabled] and applies it to every backend.
  Future<void> setEnabled(bool enabled) async {
    await _store.writeCollectionEnabled(enabled);
    await _applyToAll(enabled);
  }

  Future<void> _applyToAll(bool enabled) async {
    for (final apply in _switches) {
      try {
        await apply(enabled);
      } catch (_) {}
    }
  }
}
