# personal

Personal cabinet + calendar + animal comments feature module: the user profile
screen, the change-password dialog, the calendar placeholder, and the animal
comments list/edit screens, plus the two application services on the new stack.

## Why comments live here

Comments (`/animals/:id/comments`) are an animals concern, but they migrate
together with the personal cabinet in this step, so they land in this module
(`ui/comments/`). App → module (downward) is allowed; the app's animal-detail
screen imports the comments widgets from `package:personal/personal.dart`.

## Services + entities live here

- `PersonalService` — application service over the stable `ProfileApiPort`
  (`acits_api`), mapping `UserDto` → the module's `UserProfile` entity. Consumed
  by the personal screen, the change-password dialog, and the app's
  `PersonalDrawer` shell.
- `CommentsService` — application service over the stable `AnimalNotesApiPort`
  (`acits_api`), mapping `AnimalNoteDto` → the module's `AnimalNote` /
  `AnimalNoteFile` entities. The notes logic (incl. cross-platform file byte
  prep) moved out of the app's `AnimalService` into this module.

`UserProfile`, `AnimalNote` and `AnimalNoteFile` domain entities are exported
from the barrel.

## Ports (implemented by the app)

- `PersonalShelterProvider` — current shelter id (`x-current-shelter` scoping)
  plus a logout signal used to clear the profile cache. Bridged in the app to
  `AuthService` (itself a `ChangeNotifier`), mirroring applicants_register.dart /
  prescriptions_register.dart, so the module never imports the app.
- `CommentFileOpener` — downloads a comment attachment to disk for native open
  (web opens by URL). Bridged to the app's `FileService`.
- `PersonalRouterService` — feature navigation (`openCommentEdit` pushes the
  comment editor and returns the created/updated note).
  `PersonalRouterServiceImpl` lives in the app nav layer and drives go_router.

## l10n, lottie, assets & shared widgets

- Localization: literal `.tr()` keys via `PersonalL10nKeys` (key == value in the
  app translation bundle), same pattern as the other modules.
- Lottie: asset path strings (`PersonalLottieRes`) resolved from the app bundle.
- SVG icons: path strings via `PersonalAssets` / the module-local
  `LocaleSwitcher`, resolved from the app bundle (`assets/icon/*.svg`).
- Shared widgets (`FormEditCard`/`EditCardData`, `LoaderHolderWidget`,
  `ErrorHolderWidget`, `bsSelectorActions`, `PrimaryButton`, `context.appColors`)
  come from `package:acits_ui_kit`; `DataState`/`DataStateBuilder` from
  `acits_core`; `MessagedException` from `acits_domain`.
