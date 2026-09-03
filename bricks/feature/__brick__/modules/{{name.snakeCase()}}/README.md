# {{name.snakeCase()}} (feature module)

{{description}} Scaffolded from the `feature` mason brick, modelled on
`modules/animals`.

## Layering

Every folder has a barrel (`<folder>/<folder>.dart`) that re-exports its files
and subfolder barrels; the root `{{name.snakeCase()}}.dart` exports the three
layer barrels. Intra-module logic imports go through `package:{{name.snakeCase()}}/<barrel>.dart`
(never relative). Barrel files themselves use relative exports.

```
lib/
├── {{name.snakeCase()}}.dart            # root barrel → data/domain/presentation
├── data/
│   ├── data.dart            # barrel → data_source / mapper / repository
│   ├── data_source/         # thin wrapper over core/api {{name.pascalCase()}}ApiPort (+ barrel)
│   ├── mapper/              # {{name.pascalCase()}}Mapper implements Transformable<{{name.pascalCase()}}> (+ barrel)
│   └── repository/          # {{name.pascalCase()}}RepositoryImpl → Result<Failure, T>; DTOs stop here (+ barrel)
├── domain/
│   ├── domain.dart          # barrel → entity + repository interface + router
│   ├── {{name.snakeCase()}}.dart        # feature-local entity
│   ├── {{name.snakeCase()}}_repository.dart  # repository interface (Result)
│   └── router/              # {{name.pascalCase()}}RouterService — nav contract (impl in root) (+ barrel)
└── presentation/
    ├── presentation.dart    # barrel → each screen barrel
    └── {{screen.snakeCase()}}/          # screen barrel + bloc / view / widgets (each with a barrel)
```

## Wiring checklist (after scaffolding)

1. Add `modules/{{name.snakeCase()}}` under `workspace:` in the root `pubspec.yaml`, then `fvm flutter pub get`.
2. Add `{{name.pascalCase()}}ApiPort` + `{{name.pascalCase()}}Dto` to `modules/base/core` (`lib/api/ports/` + `lib/api/ports/dto/`) and a swagger_parser adapter (see CLAUDE.md → add an endpoint).
3. In the root DI: construct adapter → repository → `{{name.pascalCase()}}RouterServiceImpl`; register them; add routes to the root GoRouter tree.
4. `fvm dart run build_runner build --delete-conflicting-outputs`, then `melos check-all`.

**Dependency rule:** may import `util`, `core` (`core/domain.dart` anywhere, `core/api.dart` + `core/data.dart` in the data layer only), `ui_kit`, `navigation`, `localization`. May NOT import another feature module. DTOs are confined to `data/`.
