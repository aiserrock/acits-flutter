# network

The HTTP transport layer: one configured dio client and its interceptors. There
is exactly one client construction path in the app, and it starts here.

## Exports

- **`dio_factory`** — builds the configured `Dio` (base URL, timeouts,
  certificate handling). Both the authed and the guest client come from it.
- **`AuthInterceptor`** — attaches the access token and performs
  **single-flight** refresh: concurrent 401s wait on one refresh call instead of
  stampeding the token endpoint, then replay.
- **`HeaderInterceptor`** — common headers, including the current-shelter header.
- **`ports`** — the narrow interfaces the interceptors need (token storage,
  refresh call) so this package never depends on auth or any feature.
- **`seams`** — connectivity/logging injection points, so the dev flavor can add
  its own interceptors without this package knowing about them.

## Rules

Depends on `util` only. Knows nothing about endpoints — those live behind the
ports in `core/api`. A second HTTP client anywhere in the tree is a bug.
