# acits_api

API layer for ACITS: **stable ports + OUR DTOs** on top, a **replaceable
generated adapter** underneath. This is the only package where DTOs and
generated HTTP-client code live.

## The ports / adapters boundary

```
features / repositories
        │  depend only on ↓
   ports/ ──────────────────────────────  ← STABLE. Never changes on generator swap.
     ├─ animal_api_port.dart   (abstract interface, in terms of OUR DTOs)
     └─ dto/                    (AnimalDto, SpeciesDto, CuratorDto, …)
        │  implemented by ↓
   adapters/swagger_parser/
     ├─ animal_api_adapter.dart          ← the ONLY place generated code is touched
     └─ generated/                        ← swagger_parser output (isolated, regenerated)
```

- **`ports/`** — the contract the app depends on. `AnimalApiPort` and the DTOs
  under `ports/dto/` are OUR types: immutable, `json_serializable`-backed,
  snake_case wire keys, generator-agnostic. Nothing here imports generated code.
- **`adapters/swagger_parser/`** — wraps the generated Retrofit client (built on
  the shared `Dio` from `acits_core`) and maps generated models → our DTOs,
  field-for-field. Pagination envelopes are unwrapped here; the port exposes
  plain lists. This is the single seam that knows about the generator.
- **`generated/`** — swagger_parser output. Marked `linguist-generated`,
  excluded from `analyze` (see `analysis_options.yaml`), and NEVER hand-edited.

Only the current adapter is exported from `lib/acits_api.dart`; the generated
surface stays private (a narrow `lib/src/animals_client_barrel.dart` re-exports
the generated animals types for the parity tests only).

## Regenerating the client

Generated code is regenerated **in isolation** via melos — NOT by the app's
global `build_runner` pass:

```sh
melos genapi
```

which runs, inside `packages/acits_api/`:

1. `dart run tool/preprocess_openapi.dart` — writes a preprocessed spec to
   `.gen/openapi.preprocessed.json` (git-ignored build artifact).
2. `dart run swagger_parser` — generates the Retrofit clients + models under
   `adapters/swagger_parser/generated/` from the preprocessed spec.
3. `dart run build_runner build --delete-conflicting-outputs` — emits the
   `.g.dart` files (retrofit_generator + json_serializable).

The source of truth for the schema is `doc/api/openapi.json` (a copy of the
app's OpenAPI spec). It is never mutated in place.

### Why the preprocessing step exists

swagger_parser 1.44 has a bug: when a component schema is used as a
`multipart/form-data` request body, the parser inlines that schema's properties
into the request method's parameters **and drops the standalone data class**.
But those same schemas are also returned as JSON responses (or nested via
`$ref`, e.g. `Species` inside `AnimalRead`), where the generated code still
imports the class — producing dangling imports and `InvalidType` errors that
fail `build_runner`. Affected: Adopter, Adoption, AnimalNote, AnimalSitter,
Applicant, Curator, Overstay, Prescription, ReleaseSerializers, Species,
UserSheltersAdminSerializers.

`tool/preprocess_openapi.dart` strips the non-JSON request-body content
variants (`multipart/form-data`, `x-www-form-urlencoded`) from every request
body that also offers `application/json`. The parser then emits those classes
normally. This is safe: the app's chopper client sends all these writes as
JSON; the stripped variants are DRF boilerplate the app never uses.

## Swapping the generator

The ports and DTOs are the durable contract. To move to a different generator
(retrofit-only, openapi-generator, hand-rolled, …):

1. Add a new `adapters/<name>/` that implements the SAME ports
   (`AnimalApiPort`, …), mapping its client's models onto OUR existing DTOs.
2. Flip one DI binding (Step 7 wiring) to construct the new adapter instead of
   `AnimalApiAdapter`.

`ports/`, `ports/dto/`, and every repository / feature that depends on them stay
untouched. The parity tests (`test/animal_api_adapter_parity_test.dart`) are the
safety net: they assert the adapter maps realistic wire JSON onto the DTOs
correctly and unwraps pagination, so a new adapter can be validated against the
same fixtures.
