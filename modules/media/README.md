# media

Photo gallery and editor, the cross-platform PDF viewer, and the generic search
/ picker used across features.

## Why it depends on other features

`media` is the one feature module that imports other feature modules
(`animals`, `applicants`, `prescriptions`). Its generic search pages their data —
animals, applicants, curators, drugs, shelters — so it needs their entities and
data layers.

This is a **downward leaf→leaf** edge, not a cycle: those modules do not import
`media`. The direction is deliberate and documented in ARCHITECTURE.md. It is
also why the `animal_detail` / `animal_edit` screens live in `shell` rather than
in `animals` — hosting them there would close the loop `animals → media → animals`.

## Exports

- **Photo gallery + editor** — animal photo browsing and the `pro_image_editor`
  based editing flow, one code path for mobile and web.
- **Document viewer** — PDF rendering behind a port, so io and web share a screen.
- **Generic search** — `Search`, `SearchTypeKey`, `SearchDeps` and the paging
  fetch adapters. `SearchDeps` is constructed in the app's DI and passed in, so
  the module resolves nothing from `getIt` itself.
- **`DocumentRepository`**, the router contract, and the platform ports
  (doc export, pdf.js readiness, shelter provider).
