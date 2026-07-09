# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog],
and this project adheres to [Semantic Versioning].

## [Unreleased]

### Fixed

- CI provisions Firebase configs for the new per-flavor layout (`ios/flavors/{dev,prod}/`) and installs the flutterfire CLI so the iOS `bundle-service-file` build phase can select the right plist; the stale `ios/Runner/GoogleService-Info.plist.example` copy no longer breaks the pipeline
- Removed the FlutterFire `upload-crashlytics-symbols` Xcode build phase (it looked for the Crashlytics run script in SPM's DerivedData and failed the unsigned CI build with `ProcessException: No such file or directory`); `uploadDebugSymbols` set to false in `firebase.json`

## [0.6.0+18] - 2026-07-09

### Added

- Firebase for both flavors on Android, iOS and web, each flavor in its own project (`acits-prod` / `acits-dev`): Analytics on all three platforms, Crashlytics on Android/iOS (no web plugin exists; guarded off with `kIsWeb`). Configured via FlutterFire (`firebase_options.dart` per flavor) with native `google-services.json` per flavor and per-flavor iOS `GoogleService-Info.plist` selected by an Xcode `flutterfire bundle-service-file` build phase, plus the Android Crashlytics Gradle plugin (NDK symbol upload) — ready for push notifications.
- Web PWA now uses the path URL strategy (`/login` instead of `/#/login`), with a `404.html` SPA-fallback for GitHub Pages and `try_files` on nginx
- iOS now has `Profile-dev` / `Profile-prod` build configurations, so `flutter build ios --profile --flavor {dev,prod}` works (Android profile builds already worked)
- iOS builds via Swift Package Manager (hybrid): SPM-capable plugins use SPM, the rest stay on CocoaPods

### Changed

- CI no longer runs on a plain push to `main`/`develop`; it now runs only on pull requests and on a `v*` release tag
- CI now builds a signed release: the dev flavor on a PR, the prod flavor on a `v*` tag (both signed with the release keystore); artifacts are named `acits-dev-release` / `acits-prod-release`
- README now links directly to the deployed PWA
- Telegram build notification now fires on every CI run, including pull requests (previously tag-only)
- Telegram notification now includes the live PWA link when the web deploy succeeds
- Web PWA shows a loading spinner over the splash screen until the app's first frame renders
- Bundle identifier changed to `ru.acits` (prod) / `ru.acits.dev` (dev) across Android and iOS; iOS signing team set to `45G32KJDV7`
- `assetLinks.json` fingerprint updated to the release keystore's certificate

### Fixed

- Web PWA now boots ~4s faster: `main.dart.js` loads immediately instead of waiting on service-worker registration (which stalled and hit a 4s fallback timeout on GitHub Pages)
- iOS pod install no longer fails on a stale `Podfile.lock` that pinned Firebase 8.9.0 against `firebase_core 4.x` (which needs Firebase 12.x)
- Web PWA no longer crashes on the "terms" link (registration), comment links and comment attachments: `flutter_web_browser` (no web support) replaced with `url_launcher`, and the attachment download (`path_provider` / `open_filex`, mobile-only) now opens the file URL directly on web

## [0.5.1+17] - 2026-07-08

### Added

- GitHub Release is now published automatically when a `v*` tag is pushed: builds the dev APK, extracts that version's bullet points from `CHANGELOG.md` as release notes, attaches the APK, deploys web to GitHub Pages

### Changed

- Android/iOS builds now run only on pull requests and on a release tag, not on every push to `main`/`develop`
- Web favicon and PWA icons replaced with the app's actual logo (were the default Flutter icon)

### Fixed

- Two favicon `<link>` tags used a root-absolute path (`/favicon-32x32.png`), which 404'd once the site moved under a GitHub Pages subpath (`/acits-flutter/`); switched to relative paths

## [0.5.0+17] - 2026-07-08

### Added

- CI job that builds the `prod` web target and deploys it to [GitHub Pages](https://aiserrock.github.io/acits-flutter/) whenever a `v*` tag is pushed

### Changed

- Consolidated all generated code under `lib/gen/` (was scattered across `lib/api/`, `lib/generated/`)
- Retired the `lib/l10n/` folder name (the project uses `easy_localization`, not the `intl_utils`/`.arb` pattern that name implied); the hand-written `L10n` config class moved to `lib/res/`

### Fixed

- `Dockerfile` pinned an unmaintained base image (`cirrusci/flutter:3.3.1`) predating the project's SDK requirement and used a removed `--web-renderer` flag; replaced with `ghcr.io/cirruslabs/flutter:3.44.0`, dropped the obsolete flag, bumped `nginx` off its EOL 1.20.0
- Added a missing `.dockerignore` — `docker build .` was sending the whole repo (`build/`, `.dart_tool/`, `.git/`, ...) into the build context, multiple gigabytes for nothing the image needs

### Removed

- Dead code found in a project-wide audit: obsolete Charles debug-cert pinning (`test/dev/res/cert_res.dart`, `test/dev/ssl/http_overrides.dart`), unused `lib/domain/curator.dart`, `lib/api/client_index.dart`/`client_mapping.dart`, `script/version.sh`, `doc/tmp/*` scratch files

## [0.4.0+17] - 2026-07-08

### Added

- Dev APK attached directly to the GitHub release (CI-built from `main`, signed with the debug keystore)

### Fixed

- Corrected v0.3.0 release attribution

## [0.3.0+17] - 2022-11-16 (retagged 2026-07-08)

### Added

- Migrated navigation to `go_router`
- Migrated all screens from legacy state handling to `flutter_bloc` Cubit + `DataState` (forms, list/stream-leak screens, complex screens, registration/prescription-edit/drawer)
- Migrated localization from `intl_utils` to `easy_localization`
- Localized remaining hardcoded strings and sealed bloc events
- Real unit/bloc test suite (80 tests)
- Patrol E2E smoke test setup
- CI pipeline rebuilt: Android/iOS build jobs, Telegram build notifications, prepare → lint → analyse → test → build → notify stage split
- Bilingual README/CONTRIBUTING (English default + Russian), later extended with Chinese, Hindi, Spanish, French, and Arabic translations
- Project branding, badges, language switcher with flags, Builds section, Community section
- Project wiki: Architecture, Project Structure, Flavors and Environments, CI/CD Pipeline, Localization, Testing, FAQ
- Deep-linking for account registration confirmation
- Personal data screen and organisation/shelter renaming across the UI
- Animal card PDF download
- Autotest suite scaffolding

### Changed

- Upgraded dependencies to latest major versions
- Upgraded to Flutter 3.44.0 / Dart 3.12.0
- Rewrote English translations in British English

### Fixed

- Closed SSRF, token log leak, and auth-header issues
- Resolved re-audit findings: `safeEmit`, an off-by-one, resource leaks
- Fixed the "actual" execution filter in prescriptions to use the local date
- Suppressed the `REQUEST_INSTALL_PACKAGES` permission
- Fastlane iOS upload fix

### Removed

- Dropped dead agent files and Gherkin scaffolding from the repo

## [0.2.0+17] - 2022-10-08

### Added

- Account registration flow: email confirmation, deeplink handler, domain association files
- Registration screen localization

## [0.1.6+17] - 2022-10-08

### Added

- Debug menu stand switcher
- Animal field validation
- Prescription screen create/edit tab localization
- Session refresh persistence between app restarts
- Associated domain files for universal links
- Dev App Store app target

### Changed

- Migrated to Flutter 3

### Fixed

- Animal card single-slide layout order
- Login/auth screen bug fixes
- Shelter picker showing when only one shelter is available

## [0.1.4+13] - 2022-06-12

### Added

- Prescription create/edit screens
- Debug SSL certificate overrides for local backends

### Fixed

- Prescription card display bug

## [0.1.3+12] - 2022-06-05

### Added

- File actions (open/share/download) for animal attachments

### Fixed

- Hotfix for a production regression

## [0.1.2+11] - 2022-05-17

### Fixed

- Hotfix for a production regression

## [0.1.1+10] - 2022-05-16

### Added

- File actions groundwork
- Release process patch

## [0.1.0+9] - 2022-05-16

### Added

- Animal comments
- Android/iOS launcher assets per flavor
- Personal drawer (side menu)
- Role-based actions for animals
- "Today's executions" screen fixes

## [0.0.8+8] - 2022-05-11

### Added

- CI/CD for iOS
- Photo gallery for animal cards
- APK build patch

### Fixed

- Analyze/lint pipeline fixes

## [0.0.7+7] - 2022-03-28

### Added

- Dev environment flavor
- CI/CD analyze fix

## [0.0.6+6] - 2022-03-20

### Added

- Curator add/edit screen
- Applicant search/add/edit screen
- Design system refactoring pass

## [0.0.5+5] - 2022-02-08

### Added

- Migrated to the `sc-api` network client

## [0.0.4+4] - 2022-02-07

### Added

- Add/edit animal screen (continued)

## [0.0.3+3] - 2022-02-06

### Added

- Add/edit animal screen

## [0.0.2+2] - 2022-02-06

### Added

- Onboarding flow with native splash screens
- App localization
- Auth screens (login)
- Shelter picker
- Main screen frame and content
- Firebase project initialization
- Animals list screen
- Animal card screen
- Login form autofill support
- GitLab CI scaffolding

## [0.0.1+1] - 2021-12-19

### Added

- Initial project scaffold

<!-- Links -->
[keep a changelog]: https://keepachangelog.com/en/1.0.0/
[semantic versioning]: https://semver.org/spec/v2.0.0.html

<!-- Versions -->
[unreleased]: https://github.com/aiserrock/acits-flutter/compare/v0.4.0...HEAD
[0.4.0+17]: https://github.com/aiserrock/acits-flutter/releases/tag/v0.4.0
[0.3.0+17]: https://github.com/aiserrock/acits-flutter/releases/tag/v0.3.0
