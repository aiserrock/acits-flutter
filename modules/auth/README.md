# auth

Auth feature module: login / registration / email confirmation / splash /
onboarding / pick-shelter on the new stack.

## Session boundary (facade, not moved)

`AuthService` is cross-cutting session infrastructure imported by ~19 files
across every feature (tokens, current shelter, role). It **stays in the app**.
The module defines the narrow `AuthSessionApi` facade with only what the auth
screens need; the app's `AuthService implements AuthSessionApi` and injects it
into the screens/cubits. So the module never depends on the app, and features
keep depending on the concrete `AuthService` unchanged.

## Ports (implemented by the app)

- `AuthSessionApi` — session facade (`AuthService`).
- `AuthConfigInitializer` — config load + first-launch flag (`ConfigService`).
- `AuthDebugHook` — debug screen (`DebugService`).
- `AuthDeepLinkHandler` — deep links on login (`DeepLinkService`).
- `AuthRouterService` — screen navigation (`AuthRouterServiceImpl`, app nav layer).
- `SplashNavigator` — splash navigation + native-splash reveal (`SplashNavigatorImpl`).

## l10n & assets

- Localization: literal `.tr()` keys via `AuthL10nKeys` (key == value in the app
  translation bundle), same pattern as `modules/animals`.
- Assets (logos, onboarding illustrations, password/check icons, loading lottie):
  the app passes them into the screens as `Widget` params / asset-path lists.
  The module owns no app assets.
