# core

The shared kernel for ACITS, merging the domain and the API boundary into one
package with two internal halves that never cross-import:

- **`domain/`** — plain domain entities, repository interfaces, and the mapper
  contract. **DTO-free by rule** — this half is the boundary that keeps the wire
  format out of the app.
- **`api/`** — the ports-and-adapters API layer: stable `<Feature>ApiPort`
  interfaces, OUR DTOs, the swagger_parser adapters, and the (private) generated
  client. The **only** place generated code is imported.

Barrels: `core.dart` (the union — exports both halves), `domain.dart`
(domain only), `api.dart` (api only). Import the narrowest barrel you need —
e.g. a feature's `data/` layer imports `package:core/api.dart` plus
`package:core/domain.dart`; code that only needs entities imports
`package:core/domain.dart`.

## `domain/` exports

- **Shared entities** — `Animal`, `Prescription`, `Applicant`, `Curator`,
  `Shelter`, `AnimalSex`, `CurrentShelterRole`. Plain immutable `Equatable`
  types with no JSON and no knowledge of the API.
- **Repository interfaces** for shared domains (feature-local repositories stay
  in their own module).
- **`Transformable<T>`** — the mapper contract (`T toEntity()`) that every
  `data/mapper/` class implements to turn a DTO into an entity.
- **`RouterService`** — the base navigation-contract marker; per-feature
  `<Feature>RouterService` interfaces extend it.
- Re-exports `Result` / `Ok` / `Err` / `Failure` from `base` so features can
  pull them from the domain barrel.

## `api/` exports

- **`<Feature>ApiPort`** (`api/ports/`) — `abstract interface` API contracts
  expressed in OUR DTOs. **STABLE** — never changes when the generator is
  swapped. Repositories depend only on these.
- **OUR DTOs** (`api/ports/dto/`) — `@JsonSerializable`, project style,
  generator-agnostic.
- **swagger_parser adapters** (`api/adapters/swagger_parser/`) — **REPLACEABLE**;
  implement the ports by calling the generated client, unwrapping pagination,
  and mapping generated model → our DTO. The generated tree lives at
  `api/adapters/swagger_parser/generated/` (isolated, `linguist-generated`).

**Generator swap:** add `api/adapters/<name>/` implementing the same ports and
flip one DI binding — ports, DTOs, repositories, blocs, and UI are untouched.
`melos genapi` runs from `modules/core` (preprocess → swagger_parser →
build_runner); never invoke raw `swagger_parser`. See
[ARCHITECTURE.md](../../ARCHITECTURE.md) for the full ports-and-adapters detail.

## Dependency rule

May import: `base`, `equatable`, `dio` (adapter only), Flutter SDK. **`domain/`
must NOT import `api/`** — the domain never sees DTOs or generated code; DTO →
entity mapping lives in each feature's `data` layer. `core` does not depend on
`ui_kit` or `navigation`, and nothing above a feature repository imports
`core/api`.
