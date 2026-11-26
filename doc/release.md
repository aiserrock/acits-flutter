# Releasing

A release is built once and then promoted. Two pushes drive it, both handled by
[`.github/workflows/release.yml`](../.github/workflows/release.yml):

| Push | What happens |
| --- | --- |
| branch `release/*` | Signed prod builds for Android and iOS are produced and uploaded to the internal channels. |
| tag `v*` on that same commit | The builds already uploaded are promoted to production. Nothing is rebuilt. |

## Step by step

1. **Prepare the version on `develop`** (through a pull request): set `version:` in
   `pubspec.yaml` to `MAJOR.MINOR.PATCH` and move the `[Unreleased]` entries of
   `CHANGELOG.md` into a `## [MAJOR.MINOR.PATCH] - YYYY-MM-DD` section. The release
   workflow refuses to start without that section.
2. **Cut the release branch** from the commit to ship:
   `git switch -c release/MAJOR.MINOR.PATCH --no-track origin/develop && git push -u origin release/MAJOR.MINOR.PATCH`.
3. **CI builds and uploads.** After `Preflight` passes:
   - Google Play — the AAB goes to the **internal** track.
   - TestFlight — the IPA is uploaded.
   - RuStore — a version is created with manual publication and sent to moderation.
   - Firebase App Distribution — the dev build goes to the tester groups.
   - Crashlytics (and Sentry, when configured) receive the debug symbols.
4. **Verify the internal builds** on devices.
5. **Tag the commit that was built**: `git tag -a vMAJOR.MINOR.PATCH -m vMAJOR.MINOR.PATCH <sha> && git push origin vMAJOR.MINOR.PATCH`.
   The tag must point at a commit with a successful `release/*` run, and must equal
   `v` + the `pubspec.yaml` version; otherwise `Locate the build` fails.
6. **Approve the `production` environment** in the Actions run. Then:
   - Google Play — the internal build is promoted to production as a staged rollout.
   - App Store — the TestFlight build is submitted for review (released manually after approval).
   - RuStore — the moderated version is published.
   - GitHub — a Release is created with the prod APK and the changelog section as notes.
7. **Raise the Play rollout** in the Play Console as crash-free numbers hold.

## Fixing a release

- **A fix before tagging:** commit to the release branch and push. A new run produces a
  new build number; tag the new commit.
- **A hotfix after publication:** branch `release/MAJOR.MINOR.(PATCH+1)` from the tag,
  apply the fix, bump the version and changelog, and go through the same steps. Merge the
  release branch back into `develop` through a pull request.
- **Rollback:** stores do not allow re-publishing an older build number. Halt the Play
  staged rollout in the console and ship a hotfix with a higher build number.

## Build number

One number is shared by Google Play (`versionCode`), the App Store
(`CFBundleVersion`) and RuStore, and it only grows:

```
build number = 1000 + run number of the release workflow
```

`1000` is above every build number distributed before this pipeline existed (earlier
builds were stamped with the CI run number, below 200). Example: release run 7 of
version 1.0.0 produces `1.0.0 (1007)` in all three stores. The formula lives in
[`tool/release/build_number.sh`](../tool/release/build_number.sh).

The `+N` suffix of `version:` in `pubspec.yaml` is not used by release builds.

## Forced update and kill-switch

The splash asks Firebase Remote Config before routing anywhere
([`lib/update_policy.dart`](../lib/update_policy.dart)). Parameters, set in the Firebase
console of the prod project:

| Parameter | Type | Effect |
| --- | --- | --- |
| `min_supported_build` | number | Builds below it must update; the only action is "Update". |
| `recommended_build` | number | Builds below it see "Update available" with "Later". |
| `kill_switch` | boolean | `true` blocks every build with "Service temporarily unavailable" and "Try again". |
| `update_message` | string | Optional text that replaces the default message on these screens. |

Values are compared with the build number (see *Build number* above). The app never blocks
on its own defaults, on a failed or slow fetch (4 s), on web, or when Firebase is not
configured: only values actually published in the console restrict users. Results are
cached for an hour. Raising `min_supported_build` is the way to retire a build after an
incompatible backend change — do it only once the new build is live in all three stores.

RuStore builds open the RuStore page when built with `--dart-define=STORE=rustore`. The
App Store link searches by name until the app record exists; replace `StoreLinks.appStore`
with the `apps.apple.com/app/id…` link after the first iOS release.

## Symbols

Release builds are obfuscated (`--obfuscate --split-debug-info`). The Dart symbols of
each binary, the R8 mapping and the IPA are kept for 90 days as the `android-release`
and `ios-release` artefacts of the release run, and uploaded to Crashlytics. A stack
trace can only be decoded with the symbols of the build that produced it — keep the
artefacts of every published build before they expire.

Native iOS dSYMs are inside the `ios-release` artefact but are not uploaded to
Crashlytics by the pipeline yet; Dart symbols for both platforms are.

## Secrets and variables

Repository settings → Secrets and variables → Actions. `Preflight` fails with the full
list of what is missing.

| Secret | Contents | Where to get it |
| --- | --- | --- |
| `ANDROID_KEYSTORE_BASE64` | Upload keystore (`.jks`), base64 | `keytool -genkey …`, then `base64 -i release.jks` |
| `ANDROID_STORE_PASSWORD`, `ANDROID_KEY_PASSWORD`, `ANDROID_KEY_ALIAS` | Keystore credentials | Chosen when the keystore is created |
| `GOOGLE_SERVICES_JSON_PROD`, `GOOGLE_SERVICES_JSON_DEV` | `google-services.json`, base64 | Firebase console → Project settings → Android app |
| `GOOGLE_SERVICE_INFO_PLIST_PROD` | `GoogleService-Info.plist`, base64 | Firebase console → Project settings → iOS app |
| `PLAY_SERVICE_ACCOUNT_JSON` | Service-account JSON (raw) | Play Console → Setup → API access; grant release permissions for the app |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Service-account JSON (raw) with the *Firebase App Distribution Admin* and *Firebase Crashlytics Admin* roles | Google Cloud console → IAM → Service accounts |
| `ASC_KEY_ID`, `ASC_ISSUER_ID` | App Store Connect API key id and issuer id | App Store Connect → Users and Access → Integrations |
| `ASC_KEY_P8_BASE64` | The `.p8` key file, base64 | Downloaded once when the key is created; role *App Manager* |
| `APPLE_TEAM_ID` | Apple Developer team id | developer.apple.com → Membership |
| `RUSTORE_KEY_ID`, `RUSTORE_PRIVATE_KEY` | RuStore API key id and private key (base64 as shown in the console) | RuStore Console → Company → API RuStore → Create a key |
| `SENTRY_AUTH_TOKEN` | Optional. Token allowed to upload debug files | Sentry → Settings → Auth tokens |

| Variable | Contents |
| --- | --- |
| `FIREBASE_TESTER_GROUPS` | Optional. Comma-separated App Distribution group aliases |
| `PLAY_ROLLOUT_FRACTION` | Optional. Initial production rollout, default `0.1` |
| `SENTRY_ORG`, `SENTRY_PROJECT`, `SENTRY_URL` | Optional. Sentry is skipped unless the token, org and project are all set |

`GOOGLE_SERVICES_JSON_*` and `GOOGLE_SERVICE_INFO_PLIST_*` are also used by pull-request
builds in `ci.yml`, where missing values fall back to the committed placeholders. A
release build refuses placeholders.

## First release checklist

One-time actions outside the repository:

- **GitHub:** create the `production` environment with required reviewers (Settings →
  Environments). Restrict who can push `release/*` branches and `v*` tags with rulesets.
- **Google Play:** create the app `ru.acits`, enrol in Play App Signing and register the
  upload key. The first AAB has to be uploaded by hand in the console; the API works from
  the second upload on. New personal developer accounts need a closed test with 12
  testers for 14 days before production access.
- **App Store:** create the app record for bundle id `ru.acits`, fill in the privacy
  details, age rating and review notes with a demo account. Listing texts and screenshots
  are edited in App Store Connect; CI never overwrites them. See "Privacy manifest and
  App Store privacy questionnaire" below.
- **RuStore:** create the app and publish its first version by hand — the API creates
  drafts from an existing active version. Sign RuStore builds with the same key as Google
  Play so users can move between stores.
- **Firebase:** create the tester groups named in `FIREBASE_TESTER_GROUPS`.

### Privacy manifest and App Store privacy questionnaire

[`ios/Runner/PrivacyInfo.xcprivacy`](../ios/Runner/PrivacyInfo.xcprivacy) is the app's own
manifest; plugins and the Firebase and Sentry SDKs ship theirs. It declares no tracking,
the required-reason APIs the app and the Flutter engine use (UserDefaults, file
timestamps, system boot time) and the collected data: crash and performance data
(Crashlytics, Sentry), product interaction (Analytics screen views), user ID and email
address, all linked to the user and none used for tracking. Today reports carry the
current shelter id (set on shelter pick, cleared on logout), not the account id; the
user ID entry is declared so that adding the account id later needs no new review answer. `Info.plist` sets
`ITSAppUsesNonExemptEncryption` to `false` (HTTPS and OS crypto only), so App Store Connect
skips the export-compliance question.

Before the first submission:

- Answer the "App Privacy" questionnaire in App Store Connect with the same data types,
  purposes and "linked to the user" flags as the manifest, with tracking set to "No".
  Add every data type the backend stores beyond the manifest (name, phone, photos).
- After adding a plugin or SDK, rebuild the IPA and check Xcode's Product → Archive →
  Generate Privacy Report for the merged manifest; fix mismatches here.
- Keep the in-app opt-out (`CollectionSettings`) and the privacy policy URL in sync with
  these answers.
