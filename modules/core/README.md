# acits_domain

The shared domain layer for ACITS: plain domain entities, repository
interfaces, and the mapper contract. **DTO-free by rule** — this package is the
boundary that keeps the wire format out of the app.

## Exports

- **Shared entities** — `Animal`, `Prescription`, `Applicant`, `Curator`,
  `Shelter`, `AnimalSex`, `CurrentShelterRole`. Plain immutable `Equatable`
  types with no JSON and no knowledge of the API.
- **Repository interfaces** for shared domains (feature-local repositories stay
  in their own module).
- **`Transformable<T>`** — the mapper contract (`T toEntity()`) that every
  `data/mapper/` class implements to turn a DTO into an entity.
- **`RouterService`** — the base navigation-contract marker; per-feature
  `<Feature>RouterService` interfaces extend it.
- Re-exports `Result` / `Ok` / `Err` / `Failure` from `acits_core` so features
  can pull them from the domain barrel.

## Dependency rule

May import: `acits_core`, `equatable`, Flutter SDK. **May NOT import
`acits_api`** — the domain never sees DTOs or generated code; DTO→entity mapping
lives in each feature's `data` layer. It also does not depend on `acits_ui_kit`
or `acits_navigation`.
