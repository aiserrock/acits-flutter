import 'package:flutter_test/flutter_test.dart';
import 'package:observability/observability.dart';

final class _MemoryStore implements CollectionPreferenceStore {
  bool? value;

  @override
  bool? readCollectionEnabled() => value;

  @override
  Future<void> writeCollectionEnabled(bool enabled) async => value = enabled;
}

void main() {
  late _MemoryStore store;
  late List<bool> analytics;
  late List<bool> crashes;

  CollectionSettings build({bool failing = false}) => CollectionSettings(
    store: store,
    switches: [
      if (failing) (_) => throw StateError('backend down'),
      (enabled) async => analytics.add(enabled),
      (enabled) async => crashes.add(enabled),
    ],
  );

  setUp(() {
    store = _MemoryStore();
    analytics = [];
    crashes = [];
  });

  test('collection is on until the user turns it off', () {
    expect(build().isEnabled, isTrue);
  });

  test('apply pushes the stored choice to every backend', () async {
    store.value = false;
    await build().apply();
    expect(analytics, [false]);
    expect(crashes, [false]);
  });

  test('setEnabled stores the choice and switches every backend', () async {
    final settings = build();
    await settings.setEnabled(false);
    expect(store.value, isFalse);
    expect(settings.isEnabled, isFalse);
    expect(analytics, [false]);
    expect(crashes, [false]);
  });

  test('the choice survives a restart', () async {
    await build().setEnabled(false);
    expect(build().isEnabled, isFalse);
  });

  test('a backend that fails to switch does not block the others', () async {
    await build(failing: true).setEnabled(false);
    expect(analytics, [false]);
    expect(crashes, [false]);
  });
}
