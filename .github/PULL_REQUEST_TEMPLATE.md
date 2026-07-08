## Description

<!-- Describe what this PR does and why. -->

## Related Issue

Closes #

## Type of change

- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation
- [ ] Refactor
- [ ] Chore

## Checklist

- [ ] Branched from and targeting `develop` (not `main`)
- [ ] `fvm flutter format -l 100 .` run
- [ ] `fvm flutter analyze .` passes with no issues
- [ ] `fvm flutter test` passes
- [ ] Regenerated code via `fvm flutter pub run build_runner build --delete-conflicting-outputs` if I changed injectable/JsonSerializable/Chopper annotations
- [ ] Added/updated l10n strings in **both** `assets/translations/en.json` and `assets/translations/ru.json` and regenerated `LocaleKeys` via `fvm dart run easy_localization:generate -S assets/translations -O lib/gen/l10n -o locale_keys.g.dart -f keys` (no hardcoded UI strings)
- [ ] No secrets committed (Firebase configs, keystore/key.properties, Charles `.pem` certs stay gitignored; only `*.example` templates are tracked)
- [ ] Self-reviewed my code

## Screenshots (if UI)

<!-- Add before/after screenshots or screen recordings for UI changes. -->
