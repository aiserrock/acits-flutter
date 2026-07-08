[English](../../CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · **Français** · [العربية](../ar/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md)

# Contribuer à acits_flutter

Merci de l'intérêt que vous portez à contribuer à **acits_flutter** — le client mobile Flutter pour [acits.ru](https://acits.ru), un logiciel libre et open-source pour le suivi des animaux au sein d'un refuge animalier.

Ce projet est distribué sous **licence MIT**. En contribuant, vous acceptez que vos contributions soient distribuées sous les mêmes termes.

Dépôt : [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## Table des matières

- [Prérequis](#prerequisites)
- [Configuration du projet](#project-setup)
- [Modèle de branches](#branching-model)
- [Messages de commit](#commit-messages)
- [Normes de codage](#coding-standards)
- [Localisation](#localisation)
- [Tests](#testing)
- [Liste de vérification avant PR](#pre-pr-checklist)
- [Ouvrir une pull request](#opening-a-pull-request)
- [Signaler des bugs](#reporting-bugs)

---

## Prérequis

La chaîne d'outils est figée via **FVM** (Flutter Version Management) grâce au fichier `.fvmrc` à la racine du dépôt.

| Outil | Version |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | dernière version stable |

Installez FVM et le SDK figé :

```bash
dart pub global activate fvm
fvm install
```

Préfixez toujours les commandes Flutter et Dart par `fvm` afin d'utiliser le SDK figé :

```bash
fvm flutter <command>
fvm dart <command>
```

Une chaîne d'outils Android et/ou iOS fonctionnelle (Android Studio / Xcode) est également nécessaire pour compiler et exécuter l'application.

---

## Configuration du projet

1. **Forkez** le dépôt sur GitHub et **clonez** votre fork :

   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   ```

2. **Ajoutez le remote upstream** afin de pouvoir synchroniser votre fork :

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **Récupérez les dépendances :**

   ```bash
   fvm flutter pub get
   ```

4. **Copiez les modèles de configuration d'exemple.** Les fichiers de configuration Firebase sont exclus du dépôt (gitignore) ; copiez les modèles `*.example` et renseignez vos propres identifiants :

   ```bash
   # Android — par variante (flavour), un fichier par variante :
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > Le fichier `key.properties.example` sous `android/keystore/` suit le même modèle si vous devez configurer la signature en local.

5. **Générez le code.** Le projet utilise la génération de code pour l'injection de dépendances (injectable), la sérialisation JSON et Chopper :

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

6. **Lancez l'application.** Deux variantes (flavours) existent, chacune avec son propre point d'entrée :

   ```bash
   # variante dev
   fvm flutter run -t test/dev/main.dart --flavor dev

   # variante prod
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## Modèle de branches

Nous suivons un modèle de branches de type **git-flow** :

| Branche | Rôle |
| --- | --- |
| `main` | Code stable, prêt pour la production. Toujours déployable. Ne ciblez jamais directement cette branche avec une PR. |
| `develop` | Branche d'intégration où arrivent les fonctionnalités. Toutes les contributions ciblent `develop`. |
| `feature/*` | Fonctionnalités et corrections individuelles, créées à partir de `develop`. |

Créez votre branche à partir de `develop` :

```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/short-descriptive-name
```

Les pull requests sont toujours ouvertes **contre `develop`**, jamais contre `main`.

---

## Messages de commit

Nous utilisons les [**Conventional Commits**](https://www.conventionalcommits.org/). Chaque message de commit a la forme :

```
<type>(<optional scope>): <description>
```

Types courants :

| Type | Signification |
| --- | --- |
| `feat` | Une nouvelle fonctionnalité. |
| `fix` | Une correction de bug. |
| `refactor` | Un changement de code qui ne corrige pas de bug et n'ajoute pas de fonctionnalité. |
| `docs` | Documentation uniquement. |
| `test` | Ajout ou correction de tests. |
| `chore` | Processus de build, outillage ou changements de dépendances. |
| `style` | Changements de formatage sans impact sur le code. |

Exemples :

```text
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: update contributing guide for FVM 3.44
```

---

## Normes de codage

- **La longueur de ligne est de 100** (et non 80, la valeur par défaut de Dart). Formatez chaque modification :

  ```bash
  fvm dart format -l 100 lib test
  ```

- **La gestion d'état utilise des Cubits `flutter_bloc`** avec un `DataState<T>` scellé (`lib/util/data_state.dart`) rendu via `DataStateBuilder`. Les Cubits émettent via `safeEmit` (`lib/util/bloc_ext.dart`) pour éviter d'émettre après fermeture. Les formulaires utilisent `formz` ; les modèles utilisent `equatable`.

- **Les events et states sont des classes scellées (sealed classes).** Lorsqu'un BLoC complet est utilisé, définissez ses events et states comme des classes scellées attachées au fichier du bloc. Préférez un Cubit avec `DataState<T>` pour les écrans simples de type requête/réponse.

- **La navigation utilise `go_router`** (`lib/navigation/app_router.dart`). Les routes sont déclarées comme constantes dans `AppRoutes` ; les objets complexes sont transmis via `extra` et encodés via `AppExtraCodec`. N'utilisez pas d'appels impératifs `Navigator` ni de routes nommées.

- **L'injection de dépendances utilise `get_it` + `injectable` 3.** `initDi()` est appelé dans `main` avant `runApp`. Relancez `build_runner` après toute modification d'une annotation `@injectable`. **N'enregistrez pas les Cubits/BLoCs dans le conteneur DI** — fournissez-les via `BlocProvider` au niveau du widget d'écran et récupérez leurs dépendances depuis `getIt` dans le constructeur.

- **Le réseau utilise Chopper + Dio,** généré à partir de la spécification OpenAPI sous `doc/api/` vers `lib/api/`. Ne modifiez jamais manuellement les fichiers générés (`*.g.dart`, `*.chopper.dart`, `*.swagger.dart`). Pour les DTO écrits à la main, utilisez `@JsonSerializable` avec `part '<name>.g.dart';`.

- **Le stockage** passe par les wrappers dans `lib/service/` autour de `flutter_secure_storage` et `shared_preferences`. N'appelez pas directement `SharedPreferences.getInstance()` depuis les fonctionnalités.

- **Préférez les imports `package:`** (`package:acits_flutter/...`) aux imports relatifs. Chaque dossier d'écran fournit un barrel `<feature>.dart` ; le barrel global du projet `export.dart` réexporte les éléments partagés.

- **Les commentaires de documentation sont rédigés en russe** afin de rester cohérents avec le reste de la base de code.

### Structure du projet

```text
lib/
├── api/           # Couche HTTP générée par Chopper/OpenAPI (ne pas modifier)
├── di/            # Conteneur get_it + injectable
├── domain/        # Modèles de domaine Dart natifs
├── generated/     # LocaleKeys générés (ne pas modifier)
├── navigation/    # Configuration go_router (app_router.dart, AppRoutes)
├── res/           # Tokens de design (couleur, style, icônes)
├── service/       # Services injectables regroupés par domaine
├── ui/
│   ├── screen/<feature>/   # bloc-ou-cubit / vue / modèle par écran
│   └── widget/             # widgets partagés à l'échelle de l'app
├── util/          # aides, DataState, bloc_ext
└── export.dart    # barrel global du projet
```

---

## Localisation

La localisation utilise **easy_localization**. Les traductions se trouvent dans `assets/translations/en.json` et `assets/translations/ru.json`, et les clés sont générées dans `LocaleKeys` (`lib/generated/locale_keys.g.dart`). L'anglais et le russe sont tous deux complets ; la locale de repli est `ru`.

**Aucune chaîne de caractères visible par l'utilisateur ne doit être codée en dur** dans l'UI.

Pour ajouter une chaîne :

1. Ajoutez la **même clé** à la fois dans `assets/translations/en.json` **et** dans `assets/translations/ru.json`.
2. Régénérez les clés :

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. Utilisez-la dans le code :

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## Tests

- **Les tests unitaires et BLoC/Cubit** se trouvent dans `test/unit/` et utilisent `mocktail` + `bloc_test` :

  ```bash
  fvm flutter test
  ```

  Exécutez un seul fichier ou filtrez par nom :

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **Les tests de bout en bout** utilisent **Patrol** (`integration_test/`, configuré dans le bloc `patrol:` de `pubspec.yaml`) :

  ```bash
  patrol test --flavor dev
  ```

Les nouvelles fonctionnalités doivent être accompagnées de tests. Les corrections de bugs devraient inclure un test de non-régression lorsque cela est pertinent.

---

## Liste de vérification avant PR

Avant d'ouvrir une pull request, vérifiez chacun des points suivants :

- [ ] Le code est formaté : `fvm dart format -l 100 lib test`.
- [ ] L'analyse statique est propre : `fvm flutter analyze`.
- [ ] Tous les tests passent : `fvm flutter test`.
- [ ] Le code généré est régénéré si une annotation `@injectable` / `@JsonSerializable` / Chopper a été modifiée : `fvm dart run build_runner build --delete-conflicting-outputs`.
- [ ] Les nouvelles clés de localisation ont été ajoutées à **la fois** dans `en.json` et `ru.json`, et `LocaleKeys` a été régénéré.
- [ ] Aucune chaîne de caractères visible par l'utilisateur codée en dur ne subsiste dans l'UI.
- [ ] Les commits respectent les Conventional Commits.
- [ ] La branche est basée sur `develop`.

Committez tout fichier régénéré — les fichiers générés commités dans le dépôt font foi pour l'analyseur.

---

## Ouvrir une pull request

1. Poussez votre branche de fonctionnalité vers votre fork :

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. Ouvrez une pull request **contre `develop`** sur le dépôt upstream.

3. Renseignez la description de la PR : ce qui a changé, pourquoi, et comment cela a été testé. **Liez l'issue associée** (par exemple `Closes #123`) afin qu'elle soit suivie et fermée automatiquement à la fusion.

4. Assurez-vous que **la CI est au vert.** Le workflow `.github/workflows/ci.yml` exécute l'analyse + les tests, une build APK Android dev, et une build iOS non signée.

5. Répondez aux retours de revue en poussant des commits supplémentaires sur la même branche.

Gardez les PR ciblées et raisonnablement petites — les PR plus petites sont revues et fusionnées plus rapidement.

---

## Signaler des bugs

Merci d'ouvrir une issue sur GitHub en utilisant les **modèles d'issue** fournis. Un bon rapport de bug comprend :

- Un titre clair et descriptif.
- Les étapes de reproduction.
- Le comportement attendu par rapport au comportement observé.
- La variante (`dev` / `prod`), l'appareil et la version de l'OS.
- Des logs, captures d'écran ou un enregistrement d'écran le cas échéant.

Recherchez d'abord dans les issues existantes pour éviter les doublons. Pour les rapports sensibles en matière de sécurité, contactez les mainteneurs en privé plutôt que d'ouvrir une issue publique.

---

Merci de contribuer à l'amélioration d'acits_flutter et de soutenir les refuges pour animaux.
