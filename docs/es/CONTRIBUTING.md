[English](../../CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · **Español** · [Français](../fr/CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md)

# Contribuir a acits_flutter

Gracias por tu interés en contribuir a **acits_flutter** — el cliente móvil Flutter para [acits.ru](https://acits.ru), software libre y de código abierto para el seguimiento de animales dentro de un refugio de animales.

Este proyecto está licenciado bajo la **Licencia MIT**. Al contribuir, aceptas que tus contribuciones se licenciarán bajo los mismos términos.

Repositorio: [github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## Tabla de contenidos

- [Requisitos previos](#prerequisites)
- [Configuración del proyecto](#project-setup)
- [Modelo de ramificación](#branching-model)
- [Mensajes de commit](#commit-messages)
- [Estándares de codificación](#coding-standards)
- [Localización](#localisation)
- [Pruebas](#testing)
- [Lista de verificación previa al PR](#pre-pr-checklist)
- [Abrir una solicitud de extracción (pull request)](#opening-a-pull-request)
- [Reportar errores](#reporting-bugs)

---

## Requisitos previos

El toolchain está fijado mediante **FVM** (Flutter Version Management) a través del archivo `.fvmrc` en la raíz del repositorio.

| Herramienta | Versión |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | latest stable |

Instala FVM y el SDK fijado:

```bash
dart pub global activate fvm
fvm install
```

Añade siempre el prefijo `fvm` a los comandos de Flutter y Dart para que se use el SDK fijado:

```bash
fvm flutter <command>
fvm dart <command>
```

También se requiere un toolchain de Android y/o iOS funcional (Android Studio / Xcode) para compilar y ejecutar la aplicación.

---

## Configuración del proyecto

1. **Haz un fork** del repositorio en GitHub y **clona** tu fork:

   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   ```

2. **Añade el remoto upstream** para poder mantener tu fork sincronizado:

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **Obtén las dependencias:**

   ```bash
   fvm flutter pub get
   ```

4. **Copia las plantillas de configuración de ejemplo.** Los archivos de configuración de Firebase están en `.gitignore`; copia las plantillas `*.example` y completa tus propias credenciales:

   ```bash
   # Android — por flavour, un archivo por flavour:
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > El archivo `key.properties.example` en `android/keystore/` sigue el mismo patrón si necesitas configurar la firma localmente.

5. **Genera el código.** El proyecto usa generación de código para DI (injectable), serialización JSON y Chopper:

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

6. **Ejecuta la aplicación.** Existen dos flavours, cada uno con su propio punto de entrada:

   ```bash
   # flavour dev
   fvm flutter run -t test/dev/main.dart --flavor dev

   # flavour prod
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## Modelo de ramificación

Seguimos un modelo de ramificación estilo **git-flow**:

| Rama | Propósito |
| --- | --- |
| `main` | Código estable, listo para producción. Siempre desplegable. Nunca la apuntes directamente con PRs. |
| `develop` | Rama de integración donde llega el trabajo de nuevas funcionalidades. Todas las contribuciones apuntan a `develop`. |
| `feature/*` | Funcionalidades y correcciones individuales, ramificadas desde `develop`. |

Crea tu rama a partir de `develop`:

```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/short-descriptive-name
```

Las pull requests siempre se abren **contra `develop`**, nunca contra `main`.

---

## Mensajes de commit

Usamos [**Conventional Commits**](https://www.conventionalcommits.org/). Cada mensaje de commit tiene la forma:

```
<type>(<optional scope>): <description>
```

Tipos comunes:

| Tipo | Significado |
| --- | --- |
| `feat` | Una nueva funcionalidad. |
| `fix` | Una corrección de error. |
| `refactor` | Un cambio de código que ni corrige un error ni añade una funcionalidad. |
| `docs` | Solo documentación. |
| `test` | Añadir o corregir pruebas. |
| `chore` | Cambios en el proceso de compilación, herramientas o dependencias. |
| `style` | Cambios de formato sin impacto en el código. |

Ejemplos:

```text
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: update contributing guide for FVM 3.44
```

---

## Estándares de codificación

- **La longitud de línea es 100** (no los 80 predeterminados de Dart). Formatea cada cambio:

  ```bash
  fvm dart format -l 100 lib test
  ```

- **La gestión de estado usa Cubits de `flutter_bloc`** junto con un `DataState<T>` sellado (`lib/util/data_state.dart`) renderizado a través de `DataStateBuilder`. Los Cubits emiten mediante `safeEmit` (`lib/util/bloc_ext.dart`) para evitar emitir después del cierre. Los formularios usan `formz`; los modelos usan `equatable`.

- **Los eventos y estados son clases selladas (sealed).** Donde se use un BLoC completo, define sus eventos y estados como clases selladas adjuntas al archivo del bloc. Prefiere un Cubit con `DataState<T>` para pantallas sencillas de solicitud/respuesta.

- **La navegación usa `go_router`** (`lib/navigation/app_router.dart`). Las rutas se declaran como constantes en `AppRoutes`; los objetos complejos se pasan a través de `extra` y se codifican mediante `AppExtraCodec`. No uses llamadas imperativas a `Navigator` ni rutas con nombre.

- **La inyección de dependencias usa `get_it` + `injectable` 3.** `initDi()` se llama en `main` antes de `runApp`. Vuelve a ejecutar `build_runner` después de tocar cualquier anotación `@injectable`. **No registres Cubits/BLoCs en DI** — provéelos mediante `BlocProvider` en el widget de pantalla y obtén sus dependencias de `getIt` en el constructor.

- **La red usa Chopper + Dio,** generados a partir de la especificación OpenAPI en `doc/api/` hacia `lib/api/`. Nunca edites manualmente los archivos generados (`*.g.dart`, `*.chopper.dart`, `*.swagger.dart`). Para DTOs escritos a mano usa `@JsonSerializable` con `part '<name>.g.dart';`.

- **El almacenamiento** pasa por los envoltorios en `lib/service/` alrededor de `flutter_secure_storage` y `shared_preferences`. No llames a `SharedPreferences.getInstance()` directamente desde las funcionalidades.

- **Prefiere las importaciones `package:`** (`package:acits_flutter/...`) sobre las importaciones relativas. Cada carpeta de pantalla incluye un barril `<feature>.dart`; el barril `export.dart` a nivel de proyecto reexporta las piezas compartidas.

- **Los comentarios de documentación se escriben en ruso** para coincidir con la base de código existente.

### Estructura del proyecto

```text
lib/
├── api/           # Capa HTTP generada por Chopper/OpenAPI (no editar)
├── di/            # Contenedor get_it + injectable
├── domain/        # Modelos de dominio en Dart puro
├── generated/     # LocaleKeys generado (no editar)
├── navigation/    # Configuración de go_router (app_router.dart, AppRoutes)
├── res/           # Tokens de diseño (color, estilo, iconos)
├── service/       # Servicios injectable agrupados por área
├── ui/
│   ├── screen/<feature>/   # bloc-o-cubit / view / model por pantalla
│   └── widget/             # widgets compartidos de toda la app
├── util/          # Ayudantes, DataState, bloc_ext
└── export.dart    # Barril a nivel de proyecto
```

---

## Localización

La localización usa **easy_localization**. Las traducciones están en `assets/translations/en.json` y `assets/translations/ru.json`, y las claves se generan en `LocaleKeys` (`lib/generated/locale_keys.g.dart`). Tanto el inglés como el ruso están completos; el idioma de reserva (fallback) es `ru`.

**No se permiten cadenas de texto codificadas de forma fija (hardcoded)** de cara al usuario en la interfaz.

Para añadir una cadena de texto:

1. Añade la **misma clave** tanto a `assets/translations/en.json` **como** a `assets/translations/ru.json`.
2. Regenera las claves:

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. Úsala en el código:

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## Pruebas

- **Las pruebas unitarias y de BLoC/Cubit** están en `test/unit/` y usan `mocktail` + `bloc_test`:

  ```bash
  fvm flutter test
  ```

  Ejecuta un solo archivo o filtra por nombre:

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **Las pruebas de extremo a extremo** usan **Patrol** (`integration_test/`, configurado en el bloque `patrol:` de `pubspec.yaml`):

  ```bash
  patrol test --flavor dev
  ```

Las nuevas funcionalidades deben incluir pruebas. Las correcciones de errores deben incluir una prueba de regresión cuando sea práctico.

---

## Lista de verificación previa al PR

Antes de abrir una pull request, confirma cada uno de los siguientes puntos:

- [ ] El código está formateado: `fvm dart format -l 100 lib test`.
- [ ] El análisis estático está limpio: `fvm flutter analyze`.
- [ ] Todas las pruebas pasan: `fvm flutter test`.
- [ ] El código generado se regeneró si se modificó alguna anotación `@injectable` / `@JsonSerializable` / Chopper: `fvm dart run build_runner build --delete-conflicting-outputs`.
- [ ] Se añadieron las nuevas claves de localización tanto a `en.json` **como** a `ru.json`, y se regeneró `LocaleKeys`.
- [ ] No quedan cadenas de texto codificadas de forma fija de cara al usuario en la interfaz.
- [ ] Los commits siguen Conventional Commits.
- [ ] La rama está basada en `develop`.

Haz commit de cualquier archivo regenerado — los archivos generados incluidos en el repositorio son la fuente de verdad para el analizador.

---

## Abrir una pull request

1. Sube tu rama de funcionalidad a tu fork:

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. Abre una pull request **contra `develop`** en el repositorio upstream.

3. Completa la descripción del PR: qué cambió, por qué y cómo se probó. **Enlaza el issue relacionado** (por ejemplo, `Closes #123`) para que se rastree y se cierre automáticamente al fusionar.

4. Asegúrate de que **la CI esté en verde.** El workflow en `.github/workflows/ci.yml` ejecuta analyse + test, una compilación de APK dev para Android y una compilación sin firmar para iOS.

5. Atiende los comentarios de revisión subiendo commits adicionales a la misma rama.

Mantén los PRs enfocados y razonablemente pequeños — los PRs más pequeños se revisan y fusionan más rápido.

---

## Reportar errores

Por favor, abre un issue en GitHub usando las **plantillas de issue** proporcionadas. Un buen reporte de error incluye:

- Un título claro y descriptivo.
- Pasos para reproducirlo.
- Comportamiento esperado frente al real.
- El flavour (`dev` / `prod`), dispositivo y versión del sistema operativo.
- Registros (logs), capturas de pantalla o una grabación de pantalla cuando sea relevante.

Busca primero en los issues existentes para evitar duplicados. Para reportes sensibles de seguridad, contacta a los mantenedores en privado en lugar de crear un issue público.

---

Gracias por ayudar a mejorar acits_flutter y apoyar a los refugios de animales.
