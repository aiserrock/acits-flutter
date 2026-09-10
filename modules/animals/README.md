# animals (feature module)

The **reference feature slice** — animals list / detail / edit — taken to
production quality first. It is the template every other feature follows and the
model the `feature` / `screen` mason bricks are cut from.

## Internal layering

```
modules/animals/lib/
├── animals.dart                 # barrel: exports data + domain + presentation (DTOs stay internal)
├── data/
│   ├── data_source/             # thin wrapper over core/api <Feature>ApiPort — calls only, no logic
│   ├── mapper/                  # AnimalMapper implements Transformable<Animal> (DTO → entity)
│   └── repository/              # AnimalRepositoryImpl → Result<Failure, T>; DTOs stop here
├── domain/
│   ├── *.dart                   # feature-local entities/enums (shared ones live in core/domain)
│   ├── animal_repository.dart   # repository interface (domain types + Result)
│   ├── port/                    # inbound ports the app supplies (permissions, status labels, shelter)
│   └── router/                  # AnimalsRouterService — nav contract (impl lives in the root)
└── presentation/
    └── <screen>/                # one folder per screen
        ├── bloc/                #   cubit (+ state) or bloc
        ├── view/                #   <screen>_page.dart (BlocProvider) + <screen>_view.dart
        └── widgets/
```

## Dependency rule

May import: `base`, `core/domain`, `core/api` (**data layer only**),
`ui_kit`, `navigation`, `l10n`, and leaf UI packages (`flutter_bloc`,
`easy_localization`, …). **May NOT import another feature module** — features
meet only through `core/domain` contracts and the root's router. DTOs from
`core/api` are confined to `data/`; nothing above the repository sees them.

## What it exports

Domain entities, repository interface, the `AnimalsRouterService` contract, the
inbound ports (`AnimalPermissions`, `AnimalStatusLabels`, `CurrentShelterProvider`),
and the screen entrypoint pages. The root app constructs the repository (port →
adapter), implements the router contract, and provides the ports via DI.
