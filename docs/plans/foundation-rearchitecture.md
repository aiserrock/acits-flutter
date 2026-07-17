# Implementation Plan: Foundation Re-Architecture (Phase 0)

> Scope: the **foundation** the whole re-architecture stands on. NOT a screen. Screens (`animals` first, then the other 20) are planned per-screen via `/plan` **after** this phase lands. Source of truth: `docs/design-specs/architecture-rearchitecture.md` (approved).
>
> Toolchain: FVM Flutter 3.44.0. All commands `fvm flutter` / `fvm dart`. Formatting `fvm dart format -l 120`. Analyze `fvm dart analyze`. Melos is the task-runner.
>
> **Code style during refactor:** produce human-readable, maintainable code. **Comments minimal** — 1–2 lines, only where intent is non-obvious (a workaround, a non-trivial invariant, a "why"). No comments restating what the code says, no section-banner comments, no doc-blocks on self-explanatory members. Clear names over comments. Match surrounding style.
>
> **Migration = strangler, not big-bang.** New layers are built alongside the existing app; legacy (chopper, `openapi.swagger.*`) is removed only after its last consumer is migrated and an `rg` gate shows zero legacy imports. See "Migration strategy" in the spec.
>
> **Progress tracking:** the **Progress Checklist** at the bottom is the live status. Whoever (human or agent) completes an item flips its `- [ ]` to `- [x]` in the same commit as the work. A step is checked only when it compiles, `melos check-all` passes for the touched package, and its tests (if any) are green. Do not check an item on partial/failing work — leave it unchecked and add a note under it. Keep the checklist in sync with reality; it is the single source of "what's done vs. left."

## Description

Turn the single-package app into a layered, multi-package, cross-platform (mobile + web/PWA + desktop) codebase with: one dio client behind a swappable generator port, a domain boundary with DTO-containment, `Result`/`Failure`, go_router with per-feature router services (named path/query routes, no `extra`), a tokenized responsive design system, a phased startup pipeline, mason scaffolding, strict CI, and full OSS hygiene. Chopper removed. Generated API code isolated so `build_runner` no longer regenerates it globally.

This plan defines package skeletons and cross-cutting contracts (API signatures only — no bodies), plus the ordered ritual to build them. No feature screens here.

## Architecture

### Target package layout

```
acits_flutter/ (root app package — thin: entrypoints, AppTask pipeline, DI composition, MaterialApp.router)
├── pubspec.yaml                      # workspace: + melos scripts
├── melos.yaml (or melos block)       # genapi / genone / check-all / l10n
├── mason.yaml + bricks/{feature,screen}
├── lib/  (app shell only after migration)
├── modules/                          # feature packages (created lazily; animals is first, in its own /plan)
├── packages/
│   ├── acits_core/                   # dio client, Result, Failure, platform-service ports, AppTask
│   ├── acits_domain/                 # shared entities, repo interfaces, RouterService base, Transformable<T>
│   ├── acits_api/                    # ports/ (our DTOs + <Feature>ApiPort) + adapters/swagger_parser/
│   ├── acits_ui_kit/                 # M3 tokens, components, breakpoints, adaptive scaffold
│   └── (acits_uploader/)             # BACKLOG: pigeon native upload — blocked on backend upload-session contract
│   └── acits_navigation/             # go_router tree, RouterService impls, guards
```

### `acits_core` — API surface (signatures only)

- `sealed class Result<F, T>` with `Ok<T>(value)` / `Err<F>(failure)`; helpers `fold`, `map`, `mapErr`, `isOk`.
- `sealed class Failure` → `NetworkFailure` (→ `NoInternet`, `Timeout`, `ServerFailure(int code, String? note)`), `AuthFailure`, `ParseFailure`, `UnknownFailure`.
- `class ApiClient` — thin dio wrapper: `Future<T> get/post/put/delete<T>(String path, {body, query, parser})`; wraps errors → throws typed `Failure`. Interceptors: `AuthInterceptor` (port existing single-flight refresh), `HeaderInterceptor`, connectivity check, Talker/Alice logging (dev only).
- `abstract interface class PhotoUploadService` — `Future<void> enqueue(List<UploadTask>)`, `Stream<UploadProgress> get progress`, `Future<void> cancel(String taskId)`. Types `UploadTask`, `UploadProgress`, `UploadResult`.
- `abstract interface class DocumentExportService` — `shareText`, `shareImage`, `sharePdf`, `printPdf`.
- `abstract class AppTask` — `Future<void> run()`; runner executes an ordered `List<AppTask>`.
- Platform ports with conditional-import impls (`_io.dart` / `_web.dart`, web uses `package:web` + `dart:js_interop`): file download, web insets, standalone-PWA detection.

### `acits_domain` — API surface

- Shared entities: `Animal`, `Prescription`, `Applicant`, `Curator`, `Shelter`, `AnimalSex` (freezed or Equatable, no JSON).
- `abstract class Transformable<T> { T toEntity(); }` (mapper contract).
- Repository interfaces for shared domains (feature-local repos stay in their module).
- `abstract class <Feature>RouterService` base convention (nav contracts live with features; base marker here).
- Re-exports `Result`/`Failure` from `acits_core` for convenience.

### `acits_api` — ports & adapters (generator replaceable)

- `lib/ports/` — `abstract <Feature>ApiPort` (e.g. `AnimalApiPort { Future<AnimalDto> getAnimal(int id); Future<List<AnimalDto>> list(...); }`) + `lib/ports/dto/` our freezed DTOs (`AnimalDto`, ...).
- `lib/adapters/swagger_parser/` — generated client + generated models (isolated) + `AnimalApiAdapter implements AnimalApiPort` mapping generated model → our DTO.
- `swagger_parser.yaml` config: input `doc/api/openapi.json`, output `lib/adapters/swagger_parser/generated/`, json_serializer `freezed`, client on dio.
- `.gitattributes`: generated files `linguist-generated`.

### `acits_ui_kit` — API surface

- Tokens: **extract existing `lib/res/theme.dart`** (`AppTheme` = `ColorScheme.fromSeed(0xFF6776E0)` + `AppColors` ThemeExtension via `context.appColors`) into the package and extend. Figma-confirmed palette: brand `#6776E0`, brand-light `#9DA7F1`, text `#101432`, grey `#9395A7`, border `#D6D7E0`, surface `#F3F4F9`. Roboto 14/16/20/24. No token invention, no Tokens-Studio dependency for v1.
- `abstract final class Breakpoints { static const medium=600, expanded=840, large=1200; }`.
- `class AdaptiveScaffold` — `MediaQuery.sizeOf` → `NavigationBar` (<600) / `NavigationRail` (≥600) / extended (≥840) / two-pane (≥1200 admin). `LayoutBuilder` in panes.
- Base components (button, appbar, text field, sheet, chip) reading tokens; Material 3. flutter_gen assets.

### `acits_navigation` — API surface

- `AppRouter` (go_router config): named routes, path/query params, **no `extra`** for serializable state. Guards (`AuthGuard`).
- `<Feature>RouterServiceImpl implements <Feature>RouterService` — the only place that knows go_router paths.
- `Routes` constants (kebab-case paths). Deep-link ready (URL == route).

## Data Layer / Domain Layer / UI Layer

Not applicable to the foundation itself — these are per-feature and get their own `/plan`. This phase only lays the contracts they will implement.

## Reusable Components (from current code)

- **Keep & move:** existing `AuthInterceptor` (single-flight refresh) → `acits_core`; `HeaderInterceptor` → `acits_core`; `lib/res/theme.dart`, `icon.dart` → provisional `acits_ui_kit` tokens; `injectable` DI setup → `acits_core`/app composition; existing go_router in `lib/navigation/app_router.dart` → `acits_navigation` (refactor: remove ~8 `extra` uses).
- **Remove:** chopper deps, `swagger_dart_code_generator`, `openapi.swagger.*` generated files, dio-vs-chopper split.

## Localization

No new UI strings in the foundation. l10n stays `easy_localization` (`melos l10n`); moves under the design-system/app as decided (kept in root for now per spec — low churn).

## Navigation

Foundation defines the router package and the RouterService pattern; concrete routes are added per feature. Convention fixed here: **named routes + path/query, `extra` only for in-memory non-serializable with id-fallback load.**

## Implementation Order

Strangler order — **chopper stays until the last consumer is migrated.** Foundation builds new layers next to legacy; it does NOT remove the old client.

1. **Workspace + melos scripts.** Add `workspace:` to root pubspec, create empty `packages/*` skeletons with `resolution: workspace`. melos scripts: `genapi`, `genone`, `check-all` (format → `analyze --fatal-infos --fatal-warnings` → test), `l10n`. Verify `fvm dart pub get`.
2. **`acits_core`:** `Result`, `Failure`, `AppTask`; single configured `Dio` factory + interceptors in fixed order; `AuthInterceptor` rebuilt with injected ports (`TokenStore`/`TokenRefresher`/`SessionInvalidator`) + single-flight/refresh concurrency tests. Platform-service **port declarations** only. Unit tests for `Result`/`Failure`.
3. **`acits_domain`:** shared entities, `Transformable<T>`, repo interfaces, RouterService base. **Does not depend on `acits_api`.**
4. **`acits_api` (parity before cutover):** ports + our DTOs; `swagger_parser` adapter + `swagger_parser.yaml`; `melos genapi` into the adapter only (not app `build_runner`). **Parity spike**: inventory used endpoints; fixtures for nullable/required, enum wire values, the 2 `oneOf`, pagination, write/validation errors; adapter output matches chopper per endpoint group. Legacy chopper still present.
5. **`acits_ui_kit`:** extract `AppTheme`/`AppColors` from `lib/res`, `Breakpoints`, `AdaptiveScaffold`, base components, flutter_gen. Golden tests across breakpoints.
6. **Navigation (in root, no new package yet):** feature route **contracts/descriptors** + `RouterService` interfaces; root aggregates the GoRouter tree (avoids `app → navigation → app` cycle — router imports root screens 19×). `Routes` constants + param codecs may live in a primitives-only `acits_navigation` with **no feature imports**. `extra` → path/query is done **per feature during migration**, not here — foundation only fixes the URL rule.
7. **App composition (no legacy removal yet):** phased `List<AppTask>` startup; DI wires ports → adapters (swagger_parser adapter as `*ApiPort`; `DocumentExportService` io/web impls). **Adapters exist before they are registered.** App compiles with new base **alongside** chopper.
8. **`animals` reference slice** (via `/orchestrator`): first feature on the new stack, full test pyramid — proves the architecture. Its endpoints cut over to the swagger_parser adapter; its `extra` uses become path/query.
9. **Group-by-group migration** of the remaining features; each verified green. Route aliases old→canonical kept ≥1 release.
10. **Legacy removal (gated):** remove chopper, `chopper_generator`, `swagger_dart_code_generator`, `openapi.swagger.*` **only** when `rg -l 'gen/api|chopper' lib modules` returns nothing.
11. **mason bricks** `feature` + `screen` — **after** `animals` + one differing feature, so the template reflects proven boilerplate.
12. **OSS + CI:** README (10-section), CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, ARCHITECTURE.md + SVG diagrams (neutral wording — no closed-project names), per-package READMEs, `.github/` templates, `presubmit.yml`, `semantic-pr.yml`, release-please, dependabot; root `CLAUDE.md` documenting rituals.

Steps 1–5 are the critical path. Step 8 (`animals`) is the architecture proof. Legacy is removed only at step 10.

**Backlog (not in this phase):**
- **Native background upload** (pigeon + Kotlin `WorkManager` / Swift `NSURLSession`, resumable/chunked, web Background Fetch). Blocked on a backend upload-session/idempotency contract that doesn't exist (photos are base64 in a full `PUT Animal`). Current phase ships **durable whole-request retry** behind `PhotoUploadService`; the pigeon module is a separate future sub-plan behind a capability gate.
- On-device ML; Rust core.

## Dependencies

- **Add:** `swagger_parser` (dev), `package:web`, `printing`/`pdf` (for DocumentExportService), `mason` (dev), `universal_platform` (only if a screen needs a hard platform fork). `pigeon` — backlog (native upload).
- **Remove:** `chopper`, `chopper_generator`, `swagger_dart_code_generator`, `flutter_alice`-chopper glue (keep Alice for dio).
- **Internal:** app → all packages; features → `acits_domain`/`acits_ui_kit`/`acits_core`; `acits_navigation` → all feature modules; `acits_api` adapter → generated client only.

## Execution Strategy (workflow / agents)

How this plan is executed once approved. **Not started yet — awaiting owner approval and edits.**

- **Mode:** ultracode + `Workflow`. Agents carry orchestrator-style instructions as their prompt (implement → run `fvm dart analyze` + `melos check-all` + tests → fix own errors in a loop → return). Note: workflow subagents cannot invoke the `/orchestrator` skill itself; they receive its plan→implement→self-verify→fix loop as instructions.
- **Sequencing: fully sequential — one agent at a time.** No parallel waves. Order follows the dependency graph strictly (a package is built only after everything it imports exists), so no false compile errors from missing deps: Step 1 workspace/melos → 2 `acits_core` → 3 `acits_domain` → 4 `acits_api` (+parity) → 5 `acits_ui_kit` → 6 navigation-in-root → 7 app composition (chopper stays) → 8 `animals` slice → 9 group migration → 10 gated legacy removal → 11 mason → 12 OSS/CI. One agent at a time ⇒ **no worktree isolation needed**. Native uploader is backlog (own sub-plan later).
- **Autonomy: run to the milestone gate without stopping for review.** Each agent self-verifies and fixes its own errors; owner is shown the result at the end (owner stated "not in prod, safe to proceed"). A step is checked only when it compiles + `melos check-all` is green + its tests pass. **Milestone gate is broader than "compiles"**: clean codegen, package-graph check (no forbidden edges), `fvm flutter build web`, Android debug build, iOS simulator build `--no-codesign`, plus a URL-reload/startup smoke test.
- **Git: branch `refactor/foundation` off `develop`.** Commit after each successfully completed step/wave (revertable checkpoints). Commit messages end without Claude attribution (per project rule). **No `push` / PR** until the owner explicitly asks.
- **Stop conditions:** an agent that cannot make its package compile/pass after its fix loop stops and reports rather than checking the box; the workflow surfaces the blocker instead of forcing a green.

## Progress Checklist

> Flip `- [ ]` → `- [x]` when done (compiles + `melos check-all` green + tests pass). Add a `> note:` line under an item if blocked or partial.

### Step 1 — Workspace + melos
- [x] `workspace:` added to root `pubspec.yaml`, `resolution: workspace` per package
- [x] skeletons: `acits_core`, `acits_domain`, `acits_api`, `acits_ui_kit` (navigation stays in root for now; uploader = backlog)
- [x] melos scripts: `genapi`, `genone`, `check-all` (format → `analyze --fatal-infos --fatal-warnings` → test), `l10n`
- [x] `fvm dart pub get` resolves the whole workspace
- [x] **chopper untouched** (strangler — legacy stays)

### Step 2 — acits_core
- [x] `Result<F,T>` (`Ok`/`Err`, `fold`/`map`/`mapErr`) + unit tests
- [x] `Failure` hierarchy + tests
- [x] `AppTask` abstraction + ordered runner
- [x] single configured `Dio` factory + interceptors in fixed order (no generic `ApiClient` surface)
- [x] `AuthInterceptor` rebuilt with injected ports (`TokenStore`/`TokenRefresher`/`SessionInvalidator`) + single-flight/refresh concurrency tests; `HeaderInterceptor`
- [x] platform-service **port declarations** (`PhotoUploadService`, `DocumentExportService`, file download, web insets)

### Step 3 — acits_domain
- [x] shared entities: `Animal`, `Prescription`, `Applicant`, `Curator`, `Shelter`, `AnimalSex`
- [x] `Transformable<T>` mapper contract
- [x] repository interfaces (shared domains)
- [x] `<Feature>RouterService` base convention
- [x] **no dependency on `acits_api`** (verified)

### Step 4 — acits_api (ports & adapters + parity) — CRITICAL PATH
- [x] `ports/` — `<Feature>ApiPort` + our DTOs in `ports/dto/` (json_serializable, not freezed — plain immutable + ==/hashCode)
- [x] `swagger_parser.yaml` (input preprocessed root spec, json_serializable, retrofit/dio)
- [x] `adapters/swagger_parser/` — generated client + `AnimalApiAdapter` mapping generated model → our DTO
- [x] `melos genapi` into the adapter only, NOT app `build_runner`; `.gitattributes` `linguist-generated`
- [x] **parity spike**: animals endpoint inventory + fixtures (nullable/required, enum wire values, pagination, sparse); adapter matches chopper animals group
- [x] swap-path documented (retrofit / openapi-generator adapter) in README
> note: codegen blocker was swagger_parser 1.44 skipping data classes used as multipart bodies (11 InvalidType). Fixed via `tool/preprocess_openapi.dart` (strip non-JSON request bodies) — root spec untouched. retrofit runtime dep added, isolated to adapter.

### Step 5 — acits_ui_kit
- [x] extract `AppTheme` + `AppColors` from `lib/res/theme.dart`
- [x] `Breakpoints` (600/840/1200)
- [x] `AdaptiveScaffold` (`MediaQuery.sizeOf` → bar/rail/extended/two-pane)
- [x] base components (button, appbar, text field, sheet, chip) token-driven M3
- [x] flutter_gen assets — package ships only its icomoon font; app pipeline untouched (app-owned)
- [x] golden tests across breakpoints

### Step 6 — Navigation (in root, no cycle)
- [x] feature route **contracts/descriptors** + `RouterService` interfaces (RouterService base in acits_domain from Step 3; per-feature contracts added during migration)
- [x] root aggregates the GoRouter tree (no `acits_navigation` → root-screen imports) — root `app_router.dart` untouched (strangler)
- [x] `Routes` constants + param codecs (primitives-only `acits_navigation`, no feature imports)
- [x] URL rule fixed (path/query carries identity; `extra` = optional cache hint) — actual `extra` removal happens per feature in migration
- [x] `AuthGuard`

### Step 7 — App composition (legacy NOT removed)
- [x] phased `List<AppTask>` startup pipeline
- [x] adapters exist before registration; DI wires ports → adapters (swagger_parser as `*ApiPort`; `DocumentExportService` io/web)
- [x] app compiles on the new base **alongside chopper** (zero features migrated yet)

### Step 8 — animals reference slice (via /orchestrator)
- [ ] animals migrated to new stack (data/domain/ui), endpoints cut to swagger_parser adapter, `extra`→path/query
- [ ] full test pyramid: repository/mapper, bloc, widget, responsive golden
- [ ] route aliases old→canonical kept

### Step 9 — Group-by-group migration
- [ ] features migrated per inventory phases (auth → prescriptions/applicants → personal/media), each green before next
- [ ] each feature: endpoints cut over, `extra`→URL, aliases kept ≥1 release

### Step 10 — Legacy removal (GATED)
- [ ] `rg -l 'gen/api|chopper' lib modules` returns nothing
- [ ] remove `chopper`, `chopper_generator`, `swagger_dart_code_generator`; delete `openapi.swagger.*`

### Step 11 — mason bricks (after animals + 1 differing feature)
- [ ] `feature` brick (data/domain/ui + bloc + router contract + barrel)
- [ ] `screen` brick (bloc/view/widgets)

### Step 12 — OSS + CI
- [ ] README (10-section), CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, LICENSE
- [ ] ARCHITECTURE.md + SVG diagrams (neutral wording — no closed-project names); per-package READMEs
- [ ] `.github/` issue + PR templates (linked+assigned issue rule)
- [ ] CI `presubmit.yml` (format → analyze `--fatal-infos --fatal-warnings` → test+coverage)
- [ ] `semantic-pr.yml`, release-please, dependabot, auto-labeler
- [ ] root `CLAUDE.md` (feature/endpoint rituals) + "gotcha" doc

### Backlog (separate sub-plans, not this phase)
- [ ] Native background upload — pigeon + Kotlin `WorkManager` / Swift `NSURLSession` + web Background Fetch; **blocked on backend upload-session/idempotency contract**. Interim: durable whole-request retry behind `PhotoUploadService`.
- [ ] On-device ML; Rust core.
- [ ] root `CLAUDE.md` documenting feature/endpoint rituals for agents
- [ ] "gotcha" doc (symptoms of skipping `genapi`/`genone`)

### Milestone gates
- [x] **Base ready (after Step 7)** — new stack compiles alongside chopper, whole-app `analyze` clean (--fatal-infos), all package tests + 88 root tests green, package-graph clean (domain⊥api verified), `flutter build web` ✓. → proceed to `animals` (Step 8).
> note: Android debug / iOS sim builds not run in this environment (no device toolchain); web build + full analyze + test suite cover the gate. Verify native builds on a machine with the mobile toolchains before Step 8 if targeting mobile.
- [ ] **Architecture proven (after Step 8)** — `animals` fully on new stack, full test pyramid green. → group migration.
- [ ] **Legacy-free (after Step 10)** — zero `gen/api`/chopper imports; old client deleted.

## Resolved

- **Reference slice = `animals`** (list/detail/edit) — Step 8, Figma nodes available (`770:873` / `2215:1204` / `3351:9669`).
- **Design tokens resolved** — from Figma + existing `AppTheme`; no Tokens-Studio export needed for v1.
- **UI layouts NOT rebuilt** — existing widgets move into new layers, visuals preserved.
- **Native upload → backlog** — blocked on backend upload-session contract; interim durable whole-request retry.

## Open Questions

- None blocking.
