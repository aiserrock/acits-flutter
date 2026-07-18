# applicants

Applicants + curators (staff) feature module: applicant/curator edit screens,
their cubits, and the `StaffService` application service on the new stack.

## StaffService lives here

`StaffService` (application service over the stable `StaffApiPort` from
`core/api`, mapping DTOs → domain `Applicant`/`Curator`) is used by both edit
screens **and** the app's search paging adapter
(`search_screen/model/paging_fetch_adapter.dart`, media group, not yet
extracted). It moves into this module (`data/staff_service.dart`) and is exported
from the barrel; the app's search adapter imports it from
`package:applicants/applicants.dart`. App → module (downward) is allowed; when
the media/search group extracts later it can depend on `modules/applicants` for
staff search.

## Ports (implemented by the app)

- `ApplicantsShelterProvider` — current shelter id for scoping writes
  (`shelter` field / `x-current-shelter`). Bridged in the app to
  `AuthService.currentShelterId` (mirrors animals_port_bridges.dart), so the
  module never imports the app.
- `ApplicantsRouterService` — feature navigation marker (extends
  `core/domain` `RouterService`). Edit screens return their saved entity via
  `Navigator.pop(result)` (framework nav, no app-route knowledge), so the
  contract declares no extra transitions today. `ApplicantsRouterServiceImpl`
  lives in the app nav layer.

## l10n & shared widgets

- Localization: literal `.tr()` keys via `ApplicantsL10nKeys` (key == value in
  the app translation bundle), same pattern as `modules/auth` / `modules/animals`.
- Shared widgets (`FormEditCard`/`EditCardData`, `LoaderHolderWidget`,
  `ErrorHolderWidget`) come from `package:ui_kit/acits_ui_kit.dart`; `DataState`/
  `DataStateBuilder` from `base`; `Applicant`/`Curator`/`MessagedException`
  from `core/domain`.
