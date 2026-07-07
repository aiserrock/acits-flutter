# acits_flutter — отчёт аудита кода

> Многоагентный аудит `lib/` (Flutter 3.44) с адверсариальной верификацией каждой находки.
> Подтверждено **45** находок: 11 high, 21 medium, 13 low.
> Каждая находка проверена отдельным агентом против реального кода (кандидаты, не выдержавшие проверку, отброшены).

Сгенерировано автоматически. Severity — скорректированная верификатором.


## HIGH

### Four conflicting state-management patterns coexist across screens
- **Файл:** `lib/ui/screen/prescription/prescription_edit_screen_controller.dart:22`  ·  **Измерение:** architecture  ·  **confidence:** high
- The stated convention is flutter_bloc + formz for screen state. In practice four incompatible patterns are used: (1) real BLoCs (login, search, onboarding); (2) hand-rolled RxDart BehaviorSubject 'Controllers' registered into getIt scopes (prescription_edit_screen_controller.dart, registration_screen_controller.dart); (3) ChangeNotifier + Provider/Consumer (animal_edit/data/animal_edit_data_holder.dart); (4) raw StatefulWidget + setState calling services directly (animal_detail_screen.dart, comments/comment_list.dart). This fragmentation triples the cognitive load, blocks shared tooling/testing, and means most screens have no testable state layer.
- **Fix:** Pick BLoC (the documented convention) and migrate the controller/ChangeNotifier/setState screens onto it. At minimum, stop adding new controllers.

### Registration screen calls getIt.popScope() before controller.dispose(), so dispose resolves an unregistered singleton
- **Файл:** `lib/ui/screen/registration/registration_screen.dart:42`  ·  **Измерение:** correctness  ·  **confidence:** high
- In `dispose()` the order is `getIt.popScope(); controller.dispose();`. The `controller` getter is `RegistrationScreenController.controller => getIt<RegistrationScreenController>()`, and the controller is only registered inside the pushed scope. After `popScope()` the singleton is unregistered, so the following `controller.dispose()` either throws (GetIt: object not registered) or resolves a stale/other instance — the intended controller is never disposed.
- **Fix:** Call `controller.dispose()` BEFORE `getIt.popScope()`. Same review applies to prescription_edit_screen.dart (lines 57-60) which has the identical popScope-before-dispose ordering.

### RegistrationScreenController.dispose() leaks TabController, ~17 TextEditingControllers and 6 BehaviorSubjects
- **Файл:** `lib/ui/screen/registration/registration_screen_controller.dart:105`  ·  **Измерение:** correctness  ·  **confidence:** high
- `dispose()` only removes the tab listener. It never calls `tabController.dispose()`, never disposes any of the ~17 `TextEditingController` fields (orgLoginController, orgPassController, orgEmailController, orgPhoneController, orgSName/Name/MName/ShelterName/Country/Region/City, customerPass/Email/SName/Name...), and never closes the BehaviorSubjects (tabState, privateState, screenState, customerRoleState, shelterState). All leak every time the registration screen is opened.
- **Fix:** In dispose(): dispose tabController and every TextEditingController, and close every BehaviorSubject (tabState, privateState, screenState, customerRoleState, shelterState).

### animal_detail_screen: uncancelled stream subscription, undisposed ScrollController and PageController, listener re-added in didChangeDependencies
- **Файл:** `lib/ui/screen/animal_detail/animal_detail_screen.dart:78`  ·  **Измерение:** correctness  ·  **confidence:** high
- Three defects: (1) `_prescriptionSwichState.listen((value) => _loadPrescriptions())` in initState returns a StreamSubscription that is never cancelled; it also calls `_loadPrescriptions()` which does `setState` — firing after dispose throws setState-after-dispose. (2) dispose() closes the subjects/stream but never disposes `_scrollController` (line 53) or `_imagePageController` (line 54) — both leak. (3) `didChangeDependencies` (line 66-70) calls `_scrollController.addListener(_onScroll)` on every invocation; didChangeDependencies can fire multiple times, registering the listener repeatedly while dispose removes it only once.
- **Fix:** Capture and cancel the subscription in dispose(); dispose both controllers; move `addListener` to initState (or guard against double-add); guard async setState with `if (!mounted) return;`.

### comment_list: onCreateCommentStream.forEach subscription never cancelled -> adds to closed BehaviorSubject after dispose; internal ScrollController not disposed
- **Файл:** `lib/ui/screen/comments/comment_list.dart:60`  ·  **Измерение:** correctness  ·  **confidence:** high
- initState does `widget.onCreateCommentStream?.stream.forEach(_onCreateComment)`. `forEach` creates a subscription that is never cancelled. `_onCreateComment` calls `_widgetState.add(...)`, and `_widgetState` is closed in dispose(). If a comment event arrives after the widget is disposed, `.add` on a closed BehaviorSubject throws 'Cannot add event after closing'. Additionally, when `widget.scrollController` is null the internally-created `_scrollController = ScrollController()` (line 59) is never disposed (dispose only removes the listener).
- **Fix:** Use `.listen(...)` capturing a StreamSubscription and cancel it in dispose(); guard `_onCreateComment` with `_widgetState.isClosed`. Dispose `_scrollController` in dispose() only when it was created internally (i.e. `widget.scrollController == null`).

### search_spec_screen: ScrollController, TextEditingController and _bounceTimer never disposed/cancelled
- **Файл:** `lib/ui/screen/search_screen/search_spec_screen.dart:47`  ·  **Измерение:** correctness  ·  **confidence:** high
- dispose() only removes the listeners from `_searchController` and `_scrollController` but never calls `.dispose()` on either (two controller leaks). Additionally the `_bounceTimer` (Timer, line 26) is never cancelled in dispose(); its callback fires `_loadData(resetOffset: true)` which calls `setState` and reads `_searchController.text` — after dispose this throws setState-after-dispose and touches disposed objects.
- **Fix:** In dispose(): cancel `_bounceTimer`, and dispose both controllers after removing listeners.

### Prod HTTP client logs full Authorization header and request/response bodies
- **Файл:** `lib/service/client/auth_client_register.dart:19`  ·  **Измерение:** security  ·  **confidence:** high
- Both prod Chopper clients (authenticated `createClient` and `guest` `createGuestClient`) register Chopper's built-in `HttpLoggingInterceptor()`. That interceptor logs every request/response line, ALL headers, and the full body. On the authenticated client this includes `authorization: Bearer <access_token>`; on the guest client it includes the login request body `{username, password}` (see AuthService.login sending TokenObtainPair) and registration PII. There is no `kReleaseMode`/flavor gate — the logging runs in prod release builds, writing bearer tokens, plaintext passwords and PII to the platform log (logcat/oslog), readable by other apps or anyone with device/log access.
- **Fix:** Remove HttpLoggingInterceptor from prod entirely, or wrap it behind `if (kDebugMode)`. If logging is needed, use a redacting interceptor that strips `authorization` and password/token fields. Keep verbose HTTP logging only in the dev flavor (test/dev already has its own logger).

### Deep-link 'link' param used as raw HTTP GET target (SSRF / arbitrary request from device)
- **Файл:** `lib/service/auth/email_confirm_repository.dart:17`  ·  **Измерение:** security  ·  **confidence:** high
- An inbound deep link is routed by DeepLinkService.onLinkHandle to `/email-confirmation?link=<encoded url>`; app_router extracts `state.uri.queryParameters['link']` into EmailConfirmationScreen.confirmLink, which calls AuthService.confirmEmail(link) -> EmailConfirmRepository.confirmEmail(email) -> `_client.get(email)`. The attacker-controlled URL is passed unmodified as the Dio request target. A crafted deep/universal link therefore makes the app issue an arbitrary GET to any host the attacker chooses (SSRF from the user's device/IP, e.g. probing internal networks, hitting attacker-controlled endpoints, cache/analytics poisoning). The only guard is a substring check `link.contains('api/v1/users/verify-email')` in deep_link_service.dart:48, which is trivially satisfied by `https://evil.com/api/v1/users/verify-email`.
- **Fix:** Validate the URL host/scheme against an allowlist (only https and host == app.acits.ru / env.apiUrl host) before issuing the request; reject anything else. Prefer extracting only the verification token from the link and constructing the request URL server-side against the known API base instead of GET-ing the raw inbound URL. The bare Dio here has no auth interceptor so no token leaks, but the arbitrary-GET primitive still stands.

### Zero real test coverage: only a CI stub exists
- **Файл:** `test/temp_test.dart:1`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- The entire test suite is a single stub (`expect(true, true)`) plus a network-dependent throwaway (test/integration/auth/auth_service_test_tmp.dart) that hits a real backend with hardcoded credentials `test_user_2/user10000` and prints tokens. There are 143 hand-written lib/ files (13 services, 3 blocs, formz validators, a just-migrated go_router setup, a bespoke extra_codec) with no verification. Every refactor — including the current FLUTTER-AND-PACKAGE-UPGRADE branch bumping Flutter/Dart and packages — ships with no automated safety net. A green CI here means nothing.
- **Fix:** Establish a real test harness: unit tests for services with a mocked `Openapi` Chopper client (mocktail), bloc_test for blocs, plain unit tests for validators/codec/date utils. Delete or gate the credential-leaking integration stub behind an explicit, non-CI target. Wire `fvm flutter test` into CI as a gate.

### AuthService token lifecycle (refresh/login/logout) is completely untested
- **Файл:** `lib/service/auth/auth_service.dart:55`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- AuthService is the security core: it holds access/refresh tokens in memory, persists refresh to secure storage via the `_refresh` setter side-effect, drives session restore (tryRefreshLastAuth), and gates every other service through currentShelterId. A regression here silently logs users out, leaks a stale token, or bypasses auth. Subtle logic that must not break: tryRefreshLastAuth returns false when `_refresh != null` (guard against double-restore), swallows refresh errors via catchError(=>false); login maps only HTTP 401 to NotAuthorizedException and everything else to MessagedException; the `_refresh` setter must write to AuthRepository on every mutation including logout's `null` reset.
- **Fix:** Unit-test with a mocked Openapi + AuthRepository: (1) login success stores access+refresh and calls setRefresh; (2) 401 -> NotAuthorizedException, other error -> MessagedException; (3) refreshToken updates _access and preserves _refresh when body.refresh is null (line 60 `?? _refresh`); (4) tryRefreshLastAuth returns false when _refresh already set, false when repo has no token, true path calls refreshToken with stored token and swallows errors; (5) logout resets state AND persists null refresh.

### PrescriptionService UTC/local time conversion is untested and high-consequence
- **Файл:** `lib/service/prescription/prescription_service.dart:134`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- This service round-trips medical prescription execution times between server UTC and device local time (_toUtc on write, _toLocal on read across single/list/today shapes). A bug here means a shelter worker administers medication at the wrong hour, or a dose appears on the wrong day. The 'today' window is computed from local midnight (DateTime(year,month,day)) to +1 day, and actual/old filters use two different date formats (toPatchApiDate for gte, toIso8601String for lt) — an easy place for off-by-one and format mismatches that no test guards.
- **Fix:** Test conversions with fixed timezones: a prescription at 23:00 local near a UTC-offset boundary survives write-then-read unchanged; the today-window boundaries are inclusive/exclusive as intended; isActual/isOld produce the expected gte/lt strings. Inject a clock or pass DateTime.now() to make it deterministic.


## MEDIUM

### Repeated result.body/error unwrap boilerplate across every service method (~40 copies)
- **Файл:** `lib/service/animal/animal_service.dart:40`  ·  **Измерение:** architecture  ·  **confidence:** high
- The identical block `if (result.body != null) { return result.body!; } else { throw MessagedException(error: result.error); }` is duplicated in almost every service method — 11 times in animal_service, 8 in staff_service, 6 each in prescription/auth, etc. This is untyped, error-prone (some variants use result.error==null, some result.body!=null, some null-return), and any change to error handling must touch dozens of sites.
- **Fix:** Add one helper extension on the Chopper Response (e.g. `T unwrap()` / `T? unwrapOrNull()` throwing MessagedException) and call it everywhere; centralizes error semantics.

### Untyped stringly-keyed navigation payloads (runtime-cast crash risk)
- **Файл:** `lib/navigation/app_router.dart:131`  ·  **Измерение:** architecture  ·  **confidence:** high
- go_router routes pass screen arguments as `extra: <String, Object?>{...}` and the router casts them back by string key: `extra?['prescription'] as Prescription?`, `extra?['fetcher'] as PdfDocFetcher`, `extra?['shelterList'] as Paginated...`. A typo in a key or a missing entry produces a null/ClassCastException at navigation time with no compile-time safety, and couples call sites (animal_detail_screen.dart:346, prescription controller) to magic strings.
- **Fix:** Define typed route-argument classes (records or small data classes) per route and pass them as a single typed `extra`.

### AnimalService is a god-service mixing HTTP, image processing, base64 encoding, and file I/O
- **Файл:** `lib/service/animal/animal_service.dart:133`  ·  **Измерение:** architecture  ·  **confidence:** high
- AnimalService (315 lines) does far more than talk to the animals API: changeAnimalPhotos decodes images, resizes them with image_util.copyResize, base64-encodes assets/files, reads files synchronously (File(...).readAsBytesSync()); _prepareNoteFiles builds data URIs; fetchPdfAnimalCard reaches into getIt<DocumentRepository>() at call time with a `// TODO: extract to DI` and converts PDFs. Business/media logic is entangled with the network layer and cannot be reused or tested independently.
- **Fix:** Extract an image/media-encoding helper and inject DocumentRepository via the constructor; keep AnimalService to API calls.

### getIt.pushNewScope/popScope lifecycle for controllers is fragile and misordered
- **Файл:** `lib/ui/screen/prescription/prescription_edit_screen.dart:57`  ·  **Измерение:** architecture  ·  **confidence:** high
- PrescriptionEditScreen registers its controller into a new getIt scope in initState and in dispose calls `getIt.popScope()` and then `controller.dispose()`. The `controller` getter resolves via `getIt<PrescriptionEditScreenController>()`, but the scope holding that singleton was just popped, so the dispose ordering relies on getIt still resolving a popped-scope instance. Using DI scopes as per-screen widget lifetime is also an unusual coupling of DI with the widget tree that the DI conventions do not describe.
- **Fix:** Hold the controller/bloc as a field created in initState and disposed directly, or provide it via BlocProvider; avoid getIt scopes for widget-scoped instances. At minimum call dispose before popScope.

### LoginBloc.stream.listen subscription never cancelled; re-pushes pickShelter on every state change after success
- **Файл:** `lib/ui/screen/auth/bloc/login_bloc.dart:31`  ·  **Измерение:** correctness  ·  **confidence:** high
- The constructor subscribes to `stream.listen((event){ if (state.status.isSuccess) _pickShelter(); })` but the bloc has no `close()` override to cancel this subscription (leak). Worse, the listener fires on EVERY state change, and status stays `success` after a successful login; any subsequent state emission (e.g. name/password edits, or a rebuild) while status==success re-invokes `_pickShelter()`, which does `getIt<GoRouter>().push(AppRoutes.pickShelter, ...)` again — stacking duplicate pick-shelter routes.
- **Fix:** Store the StreamSubscription and cancel it in an overridden `close()`. Prefer reacting to the success transition inside the `_onSubmitted` handler (call `_pickShelter()` right after emitting success) instead of a broad stream.listen, or gate on a previous!=current status transition.

### PrescriptionEditScreenController leaks commentContoroller TextEditingController
- **Файл:** `lib/ui/screen/prescription/prescription_edit_screen_controller.dart:59`  ·  **Измерение:** correctness  ·  **confidence:** high
- `dispose()` closes all BehaviorSubjects and disposes the TabController, but never disposes `commentContoroller` (the TextEditingController on line 59). It leaks each time the prescription edit screen is opened.
- **Fix:** Add `commentContoroller.dispose();` to the controller's dispose().

### comment_edit_screen: TextEditingController and two BehaviorSubjects never disposed
- **Файл:** `lib/ui/screen/comments/comment_edit_screen.dart:27`  ·  **Измерение:** correctness  ·  **confidence:** high
- The State has no `dispose()` override. `_attachState` and `_submitState` (BehaviorSubjects) are never closed, and `_textController` (TextEditingController) is never disposed. All leak each time the comment edit screen is shown.
- **Fix:** Add a dispose() that closes both subjects and disposes `_textController`.

### applicant_edit_screen: five TextEditingControllers never disposed (no dispose override)
- **Файл:** `lib/ui/screen/applicant/applicant_edit_screen.dart:29`  ·  **Измерение:** correctness  ·  **confidence:** high
- `_ApplicantEditScreenState` declares five TextEditingControllers (_nameController, _lastNameController, _emailController, _phoneController, _socialController) but has no `dispose()` method, so all five leak each time the screen is opened.
- **Fix:** Add a dispose() disposing all five controllers.

### personal_screen: five TextEditingControllers never disposed (no dispose override)
- **Файл:** `lib/ui/screen/personal_screen/personal_screen.dart:28`  ·  **Измерение:** correctness  ·  **confidence:** high
- The personal screen state declares five TextEditingControllers (_firstNameController, _lastNameController, _fatherNameController, _phoneController, _emailController) but has no `dispose()` override; all leak.
- **Fix:** Add a dispose() disposing all five controllers.

### change_pass_widget: two TextEditingControllers never disposed; setState in async callbacks without mounted guard
- **Файл:** `lib/ui/screen/personal_screen/change_pass_widget.dart:24`  ·  **Измерение:** correctness  ·  **confidence:** high
- `_ChangePassScreenDataState` declares `_oldPassController` and `_newPassController` with no `dispose()` override (leak). Also `_submit` calls `setState` inside `.then`/`.catchError` after `changePass` completes without checking `mounted` — if the dialog is dismissed while the request is in flight, setState fires on a disposed State.
- **Fix:** Add dispose() for both controllers and guard the async setState with `if (!mounted) return;`.

### BsDosage StatelessWidget holds a TextEditingController it can never dispose
- **Файл:** `lib/ui/screen/prescription/dosage_bs.dart:11`  ·  **Измерение:** correctness  ·  **confidence:** high
- `BsDosage` is a StatelessWidget that creates `final TextEditingController controller = TextEditingController();` as a field. StatelessWidgets have no lifecycle/dispose, so the controller is leaked every time the dosage bottom sheet is opened.
- **Fix:** Convert BsDosage to a StatefulWidget and dispose the controller in dispose().

### pick_shelter_screen: StreamController _state never closed; auto-select may run twice in didChangeDependencies
- **Файл:** `lib/ui/screen/auth/pick_shelter_screen.dart:51`  ·  **Измерение:** correctness  ·  **confidence:** high
- Two issues: (1) `_state` is a `StreamController<...>` created inline and never closed — the State has no dispose(), so it leaks. (2) `didChangeDependencies` calls `_pickShelter(0)` when `_autoSelectSingle && results.length==1`. didChangeDependencies can be invoked more than once (e.g. inherited-widget/media changes), so `_pickShelter(0)` — which calls `_authService.setCurrentShelter` and `context.go(root)` — can run twice, double-selecting the shelter and double-navigating.
- **Fix:** Add dispose() closing `_state`. Move the auto-select to initState or gate it with a bool `_autoSelected` flag so it runs at most once.

### main_screen._loadExecutions error branch does not setState -> loader spins forever on error; missing mounted guard
- **Файл:** `lib/ui/screen/main/main_screen.dart:137`  ·  **Измерение:** correctness  ·  **confidence:** high
- `_loadExecutions` sets loading, then on `.then` calls `setState(...content)`, but the `.catchError` callback is `(e) => _state = ScreenDataState()..error = e` — it assigns the field WITHOUT calling setState, so on a fetch error the UI never rebuilds and the loader (`StateBuilder` loader) stays visible indefinitely. Both branches also lack a `mounted` check for async setState.
- **Fix:** Wrap the catchError assignment in setState and guard with `if (!mounted) return;`.

### Deep-link validation uses substring match instead of URL parsing
- **Файл:** `lib/service/link_handler/deep_link_service.dart:48`  ·  **Измерение:** security  ·  **confidence:** high
- `onLinkHandle` decides a link is a legitimate email-verification link with `link.contains('api/v1/users/verify-email')`. Substring matching is not authenticated URL validation: an arbitrary host containing that path segment passes, and there is no scheme/host check. This is the entry point that feeds the SSRF finding above, and more generally means the deep-link surface trusts unvalidated external input.
- **Fix:** Parse with Uri.tryParse, then verify uri.scheme == 'https' and uri.host equals the expected API host and uri.path starts with the expected path before routing.

### Formz validators (Name, Password) and the util Validator have no tests
- **Файл:** `lib/ui/screen/auth/model/password.dart:12`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- Name and Password only reject empty (no length/complexity), and lib/util/validator.dart carries the email regex used for registration/personal screens. These are pure functions — the cheapest possible tests — yet they gate every form submission. The email regex `(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)` is hand-rolled and permissive (accepts trailing dots in the TLD segment, double dots), and emailOrEmptyValidator/emailValidator semantics differ subtly (empty allowed vs not). A regression that silently accepts invalid emails or rejects valid ones would only surface in production.
- **Fix:** Table-driven unit tests: Name/Password pure==false-until-validated and empty->error/non-empty->null; Validator email accept/reject fixtures (valid addresses, missing @, missing TLD, double-dot, empty-string behavior for each of the three email variants), intValidator/doubleValidator edge cases (empty, negative, whitespace).

### extra_codec: bespoke token store with a one-shot-take and process-lifetime leak, untested
- **Файл:** `lib/navigation/extra_codec.dart:88`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- AppExtraCodec is custom infrastructure that all non-primitive go_router `extra` payloads flow through (prescription edit, doc viewer, pick-shelter, comment edit). Its contract is fragile: _ExtraTokenStore.take() removes the entry on first read, so if go_router encodes/decodes an extra more than once (rebuild, Inspector re-serialization, deep-link restore) the second decode returns null and the screen silently loses its argument (e.g. PickShelterScreen gets a null shelterList). Objects that are put() but never take()n leak for the process lifetime. Recursive encode/decode of nested Map/List and the token-shaped-map collision case (a real map that happens to have a single `__extra_token__` key) are untested branches.
- **Fix:** Unit-test the codec directly: primitives pass through; nested List/Map<String,Object?> round-trip; a non-primitive object encodes to a token map and decodes back to the SAME instance; a SECOND decode of the same token yields null (document/guard this); a legitimate map literal {'__extra_token__': ...} decode behavior is defined; verify store growth/leak under encode-without-decode.

### go_router setup: unguarded parsing and extra-casting in route builders
- **Файл:** `lib/navigation/app_router.dart:99`  ·  **Измерение:** test-coverage  ·  **confidence:** medium
- The freshly migrated router builders do unguarded `int.parse(state.pathParameters['id']!)` (animalDetail line 99, commentEdit line 121, photoGallery line 149) and blind casts of `state.extra as Map<String,Object?>?` then `as Prescription?/AnimalRead?/PdfDocFetcher`. A malformed deep link or a mismatched extra shape throws inside the builder — an uncaught navigation crash rather than a graceful error screen. Combined with the extra_codec one-shot-take risk, a wrong-shaped or already-consumed extra becomes a runtime failure. None of this is covered.
- **Fix:** Widget/router tests using a test GoRouter: valid path params build the right screen; non-numeric id (e.g. /animal/abc) is handled without an uncaught FormatException; each extra-consuming route with a missing/wrong extra degrades gracefully; searchPath with an unknown type key hits SearchAdapterTypeFactoryDelegate's UnimplementedError path in a controlled way.

### AnimalService.changeAnimalPhotos image pipeline and note-file encoding untested
- **Файл:** `lib/service/animal/animal_service.dart:133`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- changeAnimalPhotos contains the most complex non-generated logic in the services: it partitions gallery items into retained-network / asset / file sources, resizes images above 1024px preserving aspect ratio (ratio = max/ side), base64-encodes, and merges validImages. _prepareNoteFiles builds `data:application/<ext>;base64,...` URIs and slices the extension by lastIndexOf('.') with a guard for no-extension names. Bugs here corrupt uploads, drop user photos, or produce malformed data URIs — and they only manifest with real files, making manual QA unreliable. getLevel also has asserts (`value < length-1`) that encode a fragile off-by-one contract.
- **Fix:** Unit-test the pure/decomposable parts (extract if needed): retain-list building never emits -1 for chosen network items; filename with no dot yields full name and correct mime; resize math for landscape/portrait/square oversized and under-limit (no resize) images; getLevel boundary values pass/trip the asserts as intended.

### SearchBloc pagination logic untested — and its state drops `error` from equality
- **Файл:** `lib/ui/screen/search_screen/bloc/search_bloc.dart:34`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- SearchBloc drives all paginated search (animals, applicants, curators, drugs, shelters) with throttle+droppable transformers, an isReachedMax computation (value.length < pageLimit), a loading-guard on every handler, and append-vs-replace item semantics across three events. This is exactly the kind of concurrency-sensitive logic that breaks silently (duplicate pages, infinite fetch, lost search text). Compounding it, SearchState.props omits `error` (line ~44: props => [items,status,isReachedMax,searchRequest]) so two states differing only in error compare equal and a failure with the same items may not rebuild; copyWith also can't clear error back to null. None of this is exercised.
- **Fix:** bloc_test with a fake adapter: FetchNext appends and sets isReachedMax when a short page returns; guard prevents concurrent fetches; ChangeSearchRequest replaces items and stores searchRequest; failure emits SearchStatus.failure with the error surfaced (which will expose the props/error-equality bug). Fix props to include error / type items as List<T> as part of the fix.

### LoginBloc submit/refresh/shelter-pick flow untested
- **Файл:** `lib/ui/screen/auth/bloc/login_bloc.dart:62`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- LoginBloc coordinates form validation, auth submission, silent session refresh, deep-link short-circuit, and post-success shelter navigation. It has real branching: _onSubmitted re-validates then maps any exception to FormzSubmissionStatus.failure (swallowing the specific auth error), _tryRefreshLastSession no-ops while in progress and emits `canceled` regardless, and a stream.listen side-effect triggers _pickShelter on every success state (risking duplicate pushes). It pulls services from getIt in the constructor, so tests need DI-seam setup but the logic itself is very testable.
- **Fix:** bloc_test with mocked AuthService/DeepLinkService/DebugService: empty name/password -> no submission and dirty-error states; successful login -> inProgress then success (and _pickShelter invoked once); thrown NotAuthorizedException -> failure; tryRefreshLastSession while inProgress is a no-op; deep-link present at init skips refresh. Registering the getIt singletons (or refactoring to constructor injection) is the enabling step.

### ConfigService type-name resolution and UTF-8 JSON decode untested
- **Файл:** `lib/service/config/config_service.dart:66`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- ConfigService lazily parses backend 'values_for_selection' into prescription-type and animal-status display names, decoding the body via `json.decode(utf8.decode(result.bodyBytes))` (manual UTF-8 to avoid mojibake on Cyrillic) and reverse-mapping enum values through generated $Enum maps. getMyTypeName even accepts either a MyTypeEnum or a raw String and resolves via myTypeEnumFromJson. These display names surface throughout prescription/animal UI; a parse or enum-mapping regression shows blank or wrong labels to users with no crash to flag it. It also mutates shared caches (_prescriptionTypeNames/_animalStatusNames) lazily, a re-entrancy hazard.
- **Fix:** Unit-test with a stubbed Openapi returning a fixed values payload (including Cyrillic display_name bytes): getMyTypeName returns the right name for both enum and string inputs, null/unknown -> null; getStatus131Name maps known/unknown; verify lazy parse populates caches once and unknown API values are skipped rather than throwing.


## LOW

### Bloc events and states use abstract class, not sealed (convention violation)
- **Файл:** `lib/ui/screen/auth/bloc/login_event.dart:3`  ·  **Измерение:** architecture  ·  **confidence:** high
- CLAUDE.md states events and states must be sealed classes attached via part. Every event/state hierarchy uses `abstract class` instead of `sealed class` (login_event.dart:3, login_state.dart, search_event.dart:3, onboarding_event.dart:3, onboarding_state.dart:3). Without `sealed`, switch/pattern-matching over states is not exhaustiveness-checked by the compiler, so a new state silently falls through.
- **Fix:** Change `abstract class` to `sealed class` for all *_event.dart / *_state.dart base types (Dart 3 is available per stack notes).

### Hardcoded Russian user-facing strings bypass StringRes/.arb
- **Файл:** `lib/ui/screen/animal_edit/animal_edit_screen.dart:117`  ·  **Измерение:** architecture  ·  **confidence:** high
- Convention forbids hardcoded user-facing strings. Several literal Russian strings and hints are baked into widgets: 'Вернуться', 'Готово!', 'Изменения сохранены.', 'Закрыть' (animal_edit_screen.dart:117,129-131), 'Принять' (prescription/dosage_bs.dart:38), 'Войти' (registration_screen.dart:166), success_holder default 'Повторить' (success_holder.dart:45), and input hints 'Иванов'/'Иван'/'Иванович' (registration_screen.dart:309,315,320,423,429). These cannot be localized and drift from the .arb source of truth.
- **Fix:** Move all to lib/l10n/intl_ru.arb, regenerate, and access via StringRes.of(context)/StringRes.current.

### Validators return empty-string error sentinels instead of localized messages
- **Файл:** `lib/util/validator.dart:4`  ·  **Измерение:** architecture  ·  **confidence:** high
- Validator.emptyValidator/emailValidator/intValidator return `''` on failure. This makes forms show a blank (but still red) error and is the root reason UI screens hardcode hint text and inline messages to compensate. It also couples 'valid?' with 'no visible message', so the same validator cannot carry a localized reason.
- **Fix:** Have validators return a localized message (or a typed error) on failure; drive them from StringRes.

### ScreenDataState is a leaky, mutable ad-hoc state container with a dead field
- **Файл:** `lib/util/screen_state.dart:3`  ·  **Измерение:** architecture  ·  **confidence:** high
- ScreenDataState<T> is a hand-rolled mutable loading/content/error holder used in place of proper bloc states across setState/RxDart screens. It exposes a cascade-mutation API (`ScreenDataState()..loading()`, `..error = e`) that mutates in place, and carries a dead `final state = Stream<T>.empty();` field that is never used. StateBuilder reads private fields `state._value`/`state._error` from outside the class. This is the glue that lets non-bloc screens avoid the convention.
- **Fix:** Retire ScreenDataState in favor of formz/bloc states as screens migrate; at minimum remove the dead `state` field and the private-field access.

### Duplicated MessagedException-to-message logic; error handling inconsistent across screens
- **Файл:** `lib/ui/screen/registration/registration_screen_controller.dart:243`  ·  **Измерение:** architecture  ·  **confidence:** high
- A private `_MessagedExceptionX.errorMessage()` extension is defined locally in the registration controller, while other places re-implement `e is MessagedException ? ... : e.toString()` inline or swallow errors entirely (login_bloc.dart:73 `catch (_)` drops the error; comment_list.dart:351 `catch (_)`; animal_edit_screen.dart:251 `.catchError((_) => null)`). There is no single place that turns an exception into a user message, so behavior differs per screen (snackbar vs silent vs generic).
- **Fix:** Add one shared exception->localized-message mapper (on MessagedException / Object) and route all catch sites through it.

### Misspelled public identifiers propagate through domain and services
- **Файл:** `lib/domain/gallery_item_data.dart:14`  ·  **Измерение:** architecture  ·  **confidence:** high
- Public API names are misspelled and leak into service code: `isChoosed` (should be isChosen) on the domain GalleryItemData and consumed in animal_service.dart:141,145,164; `commentContoroller`, `_shiftFirtsStartDate`, `executuons`, `_prescriptionSwichState`. These are cosmetic but public/domain-level, so fixing later is a breaking rename touching multiple files.
- **Fix:** Rename to correct spellings now while the surface area is small (IDE rename across lib/).

### curator_edit_screen: five TextEditingControllers never disposed (no dispose override)
- **Файл:** `lib/ui/screen/curator/curator_edit_screen.dart:28`  ·  **Измерение:** correctness  ·  **confidence:** high
- `_CuratorEditScreenState` declares five TextEditingControllers (_nameController, _lastNameController, _emailController, _phoneController, _addressController) but has no `dispose()` method; all leak each time the screen is opened.
- **Fix:** Add a dispose() disposing all five controllers.

### HeaderInterceptor sends literal 'Bearer null' authorization header when not authenticated
- **Файл:** `lib/service/client/header_inteceptor.dart:19`  ·  **Измерение:** correctness  ·  **confidence:** high
- The header is built as `'authorization': 'Bearer ${authService.access}'`. When `access` is null (guest / pre-login), this produces the literal string `Bearer null` on every request through this authenticated client, rather than omitting the header.
- **Fix:** Only add the authorization header when `authService.access != null`.

### AuthInterceptor.refreshToken() can throw during 401 handling; exception not caught
- **Файл:** `lib/service/client/auth_interceptor.dart:16`  ·  **Измерение:** correctness  ·  **confidence:** medium
- On a 401, `authenticate` awaits `authService.refreshToken()`. `refreshToken` performs a network call (`apiTokenRefreshPost`) that can throw (network/DioException). The interceptor does not wrap this in try/catch, so the thrown error propagates out of `authenticate`, surfacing as an unexpected error instead of a clean auth failure/re-login.
- **Fix:** Wrap the refresh in try/catch, return null (triggering onAuthenticationFailed / logout) on error.

### Authorization header sent as literal 'Bearer null' when unauthenticated
- **Файл:** `lib/service/client/header_inteceptor.dart:19`  ·  **Измерение:** security  ·  **confidence:** high
- HeaderInterceptor unconditionally sets `'authorization': 'Bearer ${authService.access}'`. When access is null (logged out / before login) this sends the literal string `Bearer null` on every request from the authenticated client. Minor, but it is a malformed credential header that can confuse server-side auth/logging and slightly widens attack/telemetry surface; combined with the HTTP logging finding it also clutters logs.
- **Fix:** Only add the authorization header when access != null, e.g. `if (access != null) headers['authorization'] = 'Bearer $access';`.

### FlutterSecureStorage created with default options (no explicit Android/iOS hardening)
- **Файл:** `lib/service/secure_storage/secure_storage_register.dart:8`  ·  **Измерение:** security  ·  **confidence:** high
- The secure storage instance is `const FlutterSecureStorage()` with no AndroidOptions/IOSOptions. flutter_secure_storage ^10.0.0 defaults to EncryptedSharedPreferences on Android and Keychain on iOS, so the refresh token is still encrypted at rest; however no explicit `IOSOptions(accessibility: first_unlock_this_device)` / Android options are set, so keychain accessibility and backup behavior fall to library defaults. Worth pinning explicitly to avoid the token being included in device backups or accessible in unexpected lock states.
- **Fix:** Pass explicit options: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device) and AndroidOptions(encryptedSharedPreferences: true) to make at-rest protection and backup exclusion explicit and version-stable.

### Web image/CORS proxy routes user content URLs through a personal DDNS host
- **Файл:** `lib/util/url_cors_proxy.dart:7`  ·  **Измерение:** security  ·  **confidence:** high
- On web, UrlCorsProxy.add rewrites image/content URLs to `https://andx2.tplinkdns.com/cors/<url>` — a personal TP-Link DDNS endpoint hardcoded in the client. All proxied media URLs (which may embed signed/temporary access params from the API) transit this third-party host, and the app trusts whatever it returns for Image.network rendering. This is an untrusted intermediary for potentially sensitive shelter content and a hardcoded infra dependency. Native builds are unaffected (returns URL unchanged).
- **Fix:** Replace the personal DDNS proxy with a first-party CORS proxy under the app's own domain, or configure proper CORS on the media backend and drop the proxy. Move the proxy host into env config rather than hardcoding it.

### url_matcher / url_cors_proxy string-handling helpers untested
- **Файл:** `lib/util/url_matcher.dart:13`  ·  **Измерение:** test-coverage  ·  **confidence:** high
- TextUrlWrapper.fromString splits arbitrary user/API text into url vs plain segments via a hand-written regex and splitMapJoin — used to render tappable links in notes/comments. Edge cases (adjacent URLs, trailing punctuation captured into the link, empty non-match segments, case sensitivity) are unverified and easy to regress. UrlCorsProxy.add rewrites URLs only on web to a hardcoded proxy host; a mistake would break all web image/doc loading or double-proxy. Both are trivial pure functions with meaningful UI blast radius.
- **Fix:** Unit-test TextUrlWrapper.fromString: plain text, single url, text-with-url-in-middle, two adjacent urls, url with query string, and confirm the isUrl flags/ordering. For UrlCorsProxy, assert native pass-through returns the input unchanged and null input is handled (web path is harder to unit-test but the null/native branches are trivial).
