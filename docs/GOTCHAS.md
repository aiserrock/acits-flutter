# Gotchas

Symptoms-first troubleshooting for the workspace + codegen setup. When
something breaks in a confusing way, scan the symptom column.

## Codegen

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| `InvalidType`, "the getter/field X isn't defined", missing DTO field after a spec change | Stale API client — the OpenAPI spec changed but `melos genapi` was not run | `melos genapi` (regenerates the swagger_parser client inside `modules/core`) |
| New `@JsonSerializable` DTO won't compile / `_$FooFromJson` undefined | `.g.dart` not generated | `melos gen` (or `MELOS_GENONE_PKG=modules/core melos run genone`) |
| `@injectable` binding not found at runtime / DI can't resolve a type | `di_container.config.dart` stale | `fvm dart run build_runner build --delete-conflicting-outputs` |
| `LocaleKeys.foo` undefined after adding a string | l10n keys not regenerated, or key added to only one language file | add the key to **both** `en.json` and `ru.json`, then `melos l10n` |
| `build_runner` fails inside `modules/core` with dangling imports around `Species` / `Applicant` / `Prescription` etc. | swagger_parser 1.44 drops data classes used as `multipart/form-data` request bodies | this is why `melos genapi` runs `tool/preprocess_openapi.dart` first — always go through `melos genapi`, never raw `swagger_parser`. See [`modules/core/README.md`](../modules/core/README.md) |

**Rule of thumb:** touched the API layer → `melos genapi` then `melos gen`.
Touched DI/json/assets → `melos gen`. Touched the spec → `melos genapi`.

## Workspace

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| A new module isn't picked up / `pub get` doesn't see it | not listed under `workspace:` in the root `pubspec.yaml` | add it, then `fvm flutter pub get` |
| Analyzer flags files under `modules/*/build/` or generated output | those are build artifacts | `modules/*/build/`, `modules/*/.dart_tool/` (and `packages/*/build/` if a fork lands there) are gitignored; generated code is excluded from analysis — don't commit `build/` |
| `flutter` / `dart` uses the wrong SDK version | ran without FVM | always prefix with `fvm` (Flutter 3.44.0 / Dart 3.12, pinned in `.fvmrc`) |
| `flutter test` at the root passes but package tests are ignored | root `flutter test` runs only the root package | run each package: `for p in . packages/* modules/*; do [ -d "$p/test" ] && (cd "$p" && fvm flutter test); done` (CI does this) |

## Analyze / format

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| CI `Analyse` fails but local `flutter analyze` is clean | CI runs the **strict** gate | run `melos analyze:strict` (`flutter analyze --fatal-infos --fatal-warnings`) locally |
| Format check fails on generated files | generated files must not be hand-formatted | `melos format` excludes `*.g.dart` / `*.config.dart` / `*.gen.dart` / `locale_keys.g.dart` / `firebase_options.dart` — format via `melos format`, not a blanket `dart format .` |

## Web

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| Compile error importing `dart:html` | forbidden | use `package:web` + `dart:js_interop` behind a conditional-import port in `base` |
| Screen doesn't reflow on browser resize | branching on device type instead of window width | drive layout from `MediaQuery.sizeOf` + `Breakpoints`, never `Platform.isX` |
