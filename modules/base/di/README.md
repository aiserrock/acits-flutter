# di

Owns the shared `get_it` instance and the `@InjectableInit` bootstrap that wires
every module and app service together.

## Exports

- **`getIt`** — the single service-locator instance. Everything resolves from it.
- **`initDi()`** — the generated composition root for the prod flavor.

## How registration works

Modules do not register themselves globally. Each contributes an injectable
micro-package module (for example `AppServicesPackageModule`, `ShellPackageModule`),
and the generated `di_container.config.dart` pulls them in. That keeps the
dependency direction intact: `di` composes the graph, so it may see feature
modules, while no feature may see `di`.

The dev flavor has its own composition under `test/dev/di/` — it registers the
same set with dev-specific overrides. **A port registered in one flavor and not
the other is a runtime crash in that flavor**, invisible to the analyzer; keep
the two in sync when adding a dependency.

## Regenerating

```sh
MELOS_GENONE_PKG=modules/base/di fvm dart run melos run genone
```

`lib/src/di_container.config.dart` is generated — never edit it by hand.
