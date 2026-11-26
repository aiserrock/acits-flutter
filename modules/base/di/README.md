# di

Owns the shared `get_it` instance — nothing else.

## Exports

- **`getIt`** — the single service-locator instance. Everything resolves from it.

## Why it is this small

`di` is a leaf: it depends on no other workspace package, so any package may
resolve from `getIt` without creating an upward edge. The registrations are
composed by the application, which is the only package that sees every module:

- prod flavor — `lib/di/di_container.dart` (`initDi()`),
- dev flavor — `test/dev/di/di_container.dart` (`initDevDi()`).

Each feature contributes an injectable micro-package module (for example
`AppServicesPackageModule`, `ShellPackageModule`) that those two files pull in.
**A port registered in one flavor and not the other is a runtime crash in that
flavor**, invisible to the analyzer; keep the two in sync when adding a dependency.

## Regenerating

```sh
fvm dart run melos run gen
```

`lib/di/di_container.config.dart` and `test/dev/di/di_container.config.dart` are
generated — never edit them by hand.
