# util

Pure cross-cutting utilities. This is the bottom of the dependency graph: `util`
depends on no other workspace package, and everything else may depend on it.

## Exports

- **`Result` / `Ok` / `Err`** — the sealed result type repositories return. No
  dartz; `fold(onErr, onOk)` and `isOk` are the whole API.
- **`Failure`** — sealed error hierarchy: `NoInternet`, `Timeout`,
  `ServerFailure(code, note)`, `AuthFailure`, `ParseFailure`, `UnknownFailure`.
  Transport exceptions are mapped onto it in the data layer (see `core/data.dart`).
- **`DataState<T>`** — the loading/content/error state cubits emit.
- **`AppTask`** — the phased startup pipeline the entrypoints run.
- **Platform ports** — `DocumentExportService`, `PhotoUploadService` and friends:
  abstractions whose io/web implementations live where they can be
  conditionally imported.
- **Logging** — `AppTalker` and the BLoC observer.
- **Helpers** — validators, `safeEmit`, app version, date and URL utilities.

## Rules

Nothing here may import Flutter framework UI, dio, or any feature. If a helper
needs dio, it belongs in `network` or `core/data.dart`, not here.
