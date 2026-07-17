# {{name.snakeCase()}} (feature module)

{{description}} Scaffolded from the `feature` mason brick, modelled on
`modules/animals`.

## Layering

```
lib/
├── {{name.snakeCase()}}.dart            # barrel (public API; DTOs stay internal)
├── data/
│   ├── data_source/         # thin wrapper over acits_api {{name.pascalCase()}}ApiPort
│   ├── mapper/              # {{name.pascalCase()}}Mapper implements Transformable<{{name.pascalCase()}}>
│   └── repository/          # {{name.pascalCase()}}RepositoryImpl → Result<Failure, T>; DTOs stop here
├── domain/
│   ├── {{name.snakeCase()}}.dart        # feature-local entity
│   ├── {{name.snakeCase()}}_repository.dart  # repository interface (Result)
│   └── router/              # {{name.pascalCase()}}RouterService — nav contract (impl in root)
└── ui/{{screen.snakeCase()}}/           # bloc / view / widgets
```

## Wiring checklist (after scaffolding)

1. Add `modules/{{name.snakeCase()}}` under `workspace:` in the root `pubspec.yaml`, then `fvm flutter pub get`.
2. Add `{{name.pascalCase()}}ApiPort` + `{{name.pascalCase()}}Dto` to `packages/acits_api` (ports/ + ports/dto/) and a swagger_parser adapter (see CLAUDE.md → add an endpoint).
3. In the root DI: construct adapter → repository → `{{name.pascalCase()}}RouterServiceImpl`; register them; add routes to the root GoRouter tree.
4. `fvm dart run build_runner build --delete-conflicting-outputs`, then `melos check-all`.

**Dependency rule:** may import `acits_core`, `acits_domain`, `acits_api` (data layer only), `acits_ui_kit`, `acits_navigation`. May NOT import another feature module. DTOs are confined to `data/`.
