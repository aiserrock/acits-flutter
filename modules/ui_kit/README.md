# ui_kit

Design system for ACITS: Material 3 tokens (`AppTheme`/`AppColors`), breakpoints,
`AdaptiveScaffold`, and token-driven base components.

## Assets

The package owns all design-system assets under `assets/`: `icon/`, `image/`,
`common/`, `onboarding/`, `gallery/`, `lottie/`, and the icomoon icon font
(`font/icomoon.ttf`, exposed via `IconRes`). They are declared in this package's
own `pubspec.yaml` `flutter:` block and resolve as `packages/ui_kit/assets/...`.

`flutter_gen` generates a package-aware `Assets` accessor into `lib/gen/`
(`package_parameter_enabled: true`), exported from `package:ui_kit/ui_kit.dart`.
Consumers use `Assets.icon.paw.svg()`, `Assets.image.animalStub.image()`,
`Assets.lottie.loading`, etc. — the `package: 'ui_kit'` is baked in, so they
render correctly from any consuming app. `IconRes` icons reference the font with
`fontPackage: 'ui_kit'`.

The app keeps only `assets/translations/` (localization) and `assets/cert/`
(runtime cert) — those are not design assets.

Regenerate the `Assets` accessor after changing assets:

```sh
cd modules/ui_kit && fvm dart run build_runner build
```

## Gallery

`lib/gallery/` holds the component catalog: one `GalleryEntry` (section, name,
`WidgetBuilder`) per page, plus the pages themselves under `gallery/pages/`. The
catalog imports no gallery tool of its own, so pulling it in never drags a dev
dependency into the production graph. It is exported from the separate
`package:ui_kit/ui_kit_gallery.dart` barrel — code that only wants components
imports `ui_kit.dart` and leaves the pages out of its bundle.

Two hosts render the same catalog through `widgetbook`, each converting
`galleryEntries` into a widgetbook tree:

- **Standalone app** — `example/`, branded «ACITS UI Kit». NOT a workspace
  member: it resolves independently, so it never affects the main app build.

  ```sh
  cd modules/ui_kit/example
  fvm flutter pub get
  fvm flutter run -d chrome
  ```

- **Debug screen in the app** — `/debug/gallery`, reachable from the UI Kit
  Gallery card on the dev debug screen. The route is registered only when
  `DebugService.isDevFlavor` is true, so it is available in the dev flavor in any
  build mode, and the prod bundle carries neither widgetbook nor the pages.

## Exports

- **`AppTheme` / `AppColors`** — Material 3 theme (`ColorScheme.fromSeed`) plus
  an `AppColors` `ThemeExtension`, read via `context.appColors` /
  `context.colorScheme` / `context.textTheme`.
- **`Breakpoints`** — `medium=600`, `expanded=840`, `large=1200`.
- **`AdaptiveScaffold`** — window-width-driven navigation shell (bar / rail /
  extended / two-pane).
- **Token-driven base components** — button, appbar, text field, sheet, chip.
- **`IconRes`** — the icomoon icon set.

## Dependency rule

May import: `base`, Flutter SDK, leaf UI packages. **May NOT import**
`core` (neither `core/api` nor `core/domain`), `navigation`, or any feature —
the design system is presentation-only and knows nothing about DTOs, entities,
or routes.
