# localization

The single generated `LocaleKeys` shared by the root app and every feature
module. One source of translation keys — no per-module key files.

## Exports

- **`LocaleKeys`** — generated constants for every key in
  `assets/translations/*.json`. Used as `LocaleKeys.someKey.tr()`.

## Adding a key

Add it to **both** `assets/translations/en.json` and `ru.json`, then regenerate:

```sh
fvm dart run melos run l10n
```

A key present in one file only renders the raw key string to the user in the
other locale — the analyzer cannot catch that, so keep the two in step. Russian
plural forms (`few`/`many`) legitimately exist only in `ru.json`; easy_localization
selects them by count.

`lib/src/locale_keys.g.dart` is generated — never edit it by hand.
