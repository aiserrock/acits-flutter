# observability

Error and event reporting. A leaf package: it depends on no other workspace
package, so any layer may report without adding an edge to the package graph.

## What it owns

- **`ErrorReporter`** — where errors and breadcrumbs go. `CompositeErrorReporter`
  sends each call to every backend exactly once; a backend that throws never
  stops the others.
- **`CrashlyticsErrorReporter`** — Firebase Crashlytics (not available on web).
- **`SentryErrorReporter`** — Sentry. The DSN comes from
  `--dart-define=SENTRY_DSN=...`; with an empty DSN the SDK is never initialised
  and nothing is sent.
- **`Scrubber`** — removes e-mails, tokens, credentials and phone numbers from
  text, headers and URLs before anything leaves the device.
- **`CollectionSettings`** — the user's opt-out. One switch turns Analytics,
  Crashlytics and Sentry on or off; the choice is persisted.
- **`ScreenTrackingObserver`** — names a screen by its route pattern
  (`/animal/:id`), never by the concrete location.

## How the app uses it

`lib/observability_setup.dart` is the single composition point for both flavors:
it installs the Flutter and platform error hooks first, initialises Firebase
without letting a failure stop startup, starts Sentry when a DSN was built in,
and hands the reporter to the logger. Warnings and errors logged through `Log`
reach the reporter in every build; in a prod release nothing is printed to the
device console.

## Rules

- Identify a session by ids only (`setUser`): never a name, an e-mail or a phone.
- Do not install your own `FlutterError.onError` or `PlatformDispatcher.onError`:
  the app owns them, and a second hook reports every error twice.
