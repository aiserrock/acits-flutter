import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Translation bundles must stay in step. A key present in one locale and
/// missing in the other renders the raw key string to the user in that locale —
/// invisible to the analyzer and to every widget test.
void main() {
  Map<String, dynamic> load(String locale) =>
      jsonDecode(File('assets/translations/$locale.json').readAsStringSync()) as Map<String, dynamic>;

  /// Flattens nested groups to dotted paths (`commonNDays.few`).
  Set<String> flatten(Map<String, dynamic> json, [String prefix = '']) {
    final keys = <String>{};
    json.forEach((key, value) {
      final path = '$prefix$key';
      if (value is Map<String, dynamic>) {
        keys.addAll(flatten(value, '$path.'));
      } else {
        keys.add(path);
      }
    });
    return keys;
  }

  late Set<String> en;
  late Set<String> ru;

  setUpAll(() {
    en = flatten(load('en'));
    ru = flatten(load('ru'));
  });

  test('every en key exists in ru', () {
    expect(en.difference(ru), isEmpty, reason: 'keys missing from ru.json');
  });

  test('every ru key exists in en, except plural forms English does not have', () {
    // Russian needs `few`/`many` categories; English resolves to one/other, so
    // those sub-keys legitimately exist only on the ru side.
    final pluralOnly = RegExp(r'\.(few|many)$');
    final ruOnly = ru.difference(en).where((k) => !pluralOnly.hasMatch(k));

    expect(ruOnly, isEmpty, reason: 'keys missing from en.json');
  });

  test('generated LocaleKeys is in sync with the bundles', () {
    // LocaleKeys is what code references. If a key was added to the JSON but
    // `melos run l10n` was not re-run, the constant does not exist — this test
    // is the only thing that notices before a screen ships with a raw key.
    final source = File('modules/base/localization/lib/src/locale_keys.g.dart').readAsStringSync();
    final generated = RegExp(r"static const \w+ = '([^']+)'").allMatches(source).map((m) => m.group(1)!).toSet();

    // Plural sub-keys (`commonNDays.few`) collapse into their parent constant.
    final expected = en.map((k) => k.split('.').first).toSet();

    expect(
      expected.difference(generated),
      isEmpty,
      reason: 'translation keys with no LocaleKeys constant — run `melos run l10n`',
    );
  });
}
