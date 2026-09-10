# prescriptions

Prescriptions + drugs feature module: today executions, the prescription
edit screen, the animal-detail prescriptions tab cubit, drug search, the two
prescription cards, and the `PrescriptionService` application service on the new
stack.

## PrescriptionService + entities live here

`PrescriptionService` (application service over the stable `PrescriptionApiPort`
from `core/api`, mapping DTOs → the module's domain entities) and all
prescription domain entities (`Prescription`, `PrescriptionType`, `Drug`,
`PrescriptionExecutionToday`, …) move into this module and are exported from the
barrel. It is consumed by:

- the app **shell** (`root_screen` / `main` — today's prescription executions),
- the app's **animal-detail** screen (prescriptions tab),
- the app's **search** paging adapter (`paging_fetch_adapter.dart` — drug search).

App → module (downward) is allowed; those consumers import from
`package:prescriptions/prescriptions.dart`.

## Ports (implemented by the app)

- `PrescriptionsShelterProvider` — current shelter id for scoping requests
  (`x-current-shelter`). Bridged in the app to `AuthService.currentShelterId`
  (mirrors applicants_register.dart), so the module never imports the app.
- `PrescriptionTypeLabels` — human-readable prescription type names + config
  warm-up. Bridged to `ConfigService` (`getMyTypeName` / `getTypeValues`). The
  UI `typeString` extension resolves this port lazily from the shared
  `GetIt.instance`.
- `PrescriptionAnimalLoader` — loads a light `PrescriptionAnimalRef` by id for
  the edit screen (preset animal / edit mode). Bridged in the app to
  `AnimalRepository` (animals module) — a port instead of a module→module dep.
- `PrescriptionsRouterService` — feature navigation (`pickAnimal` / `pickDrug`
  open the app's generic search). `PrescriptionsRouterServiceImpl` lives in the
  app nav layer and drives go_router.

## l10n, lottie & shared widgets

- Localization: literal `.tr()` keys via `PrescriptionsL10nKeys` (key == value in
  the app translation bundle), same pattern as the other modules.
- Lottie: asset path strings (`PrescriptionsLottieRes`) resolved from the app
  bundle, mirroring app `res/lottie.dart`.
- Shared widgets (`FormEditCard`/`EditCardData`, `VisibleItem`,
  `LoaderHolderWidget`, `ErrorHolderWidget`, `ShimmerNetworkImage`,
  `bsSelectorActions`, `PrimaryButton`) come from `package:ui_kit/acits_ui_kit.dart`;
  `DataState` from `base`; `UrlCorsProxy` from `base`;
  `MessagedException` from `core/domain`.
