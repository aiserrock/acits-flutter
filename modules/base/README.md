# acits_core

Cross-cutting core for ACITS: the primitives every other layer builds on. This
is the lowest package in the graph — it depends on no other workspace package.

## Exports

- **`Result<F, T>`** — sealed `Ok<T>` / `Err<F>` with `fold` / `map` / `mapErr`
  / `isOk`. The return type of every repository.
- **`Failure`** — sealed hierarchy: `NetworkFailure` (→ `NoInternet`,
  `Timeout`, `ServerFailure(code, note)`), `AuthFailure`, `ParseFailure`,
  `UnknownFailure`.
- **`DataState<T>`** — the `loading` / `content` / `error` state wrapper blocs
  emit to the UI.
- **Dio client + interceptors** — one configured `Dio` factory; `AuthInterceptor`
  (single-flight token refresh via injected `TokenStore` / `TokenRefresher` /
  `SessionInvalidator` ports), `HeaderInterceptor`, connectivity, dev logging.
- **`AppTask`** — the startup-task abstraction and its ordered runner.
- **Platform-service ports** — `DocumentExportService` (share/print),
  `PhotoUploadService`, file download, web insets, PWA detection. Declarations
  here; io/web implementations are provided by the root app via conditional
  imports.
- **Small utils** — datetime formatting, CORS-proxy URL helper.

## Dependency rule

May import: `dio`, `equatable`, `flutter_bloc`, `intl`, Flutter SDK. **May NOT
import** any other `acits_*` package or any feature — everything depends on
`acits_core`, so it must stay dependency-free within the workspace. No DTOs, no
generated API code, no go_router here.
