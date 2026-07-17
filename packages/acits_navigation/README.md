# acits_navigation

Navigation **primitives** for ACITS: route path constants, typed query/path
param codecs, and route guards built on `go_router`. It holds the pieces that
are safe to share without creating a dependency cycle.

## Exports

- **`Routes`** — kebab-case path constants (the single source of truth for URLs).
- **Param codecs** — typed encode/decode helpers for path and query parameters.
- **Guards** — `AuthGuard` and friends (redirect logic that needs no screen).

## Dependency rule

May import: `go_router`, `acits_core`, Flutter SDK. **May NOT import any feature
module or screen widget.** The concrete `GoRouter` tree — which does import
screens — is assembled in the **root app**, not here. Keeping this package
feature-free is what breaks the otherwise unavoidable
`app → navigation → screen → app` cycle: features export a `RouterService`
interface (declared with the feature, base in `acits_domain`), the root
implements it against these constants, and injects it down. Per-feature
`RouterServiceImpl`s therefore live in the root, and this package stays a
primitives-only leaf.
