# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog],
and this project adheres to [Semantic Versioning].

## [Unreleased]

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
