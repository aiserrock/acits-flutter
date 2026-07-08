# Cubit migration spec (acits_flutter)

Target: replace ad-hoc state (`ScreenDataState` + `setState`, raw `StreamController`/`BehaviorSubject`, getIt-scoped controllers) with **flutter_bloc Cubit** and fix all controller/subscription/stream leaks. Preserve UI behaviour and navigation exactly.

## Reusable infra (already exists — USE IT)
`lib/util/data_state.dart`:
- `sealed class DataState<T>` with `DataState.loading()`, `DataState.content(T)`, `DataState.error(Object)`; getters `isLoading/isContent/hasError/valueOrNull`.
- `DataStateBuilder<T>({state, loader, builder, errorBuilder})` — renders by variant.
Import: `import 'package:acits_flutter/util/data_state.dart';`

## The pattern

1. **Cubit owns data-state & business logic.** Create `<feature>/cubit/<name>_cubit.dart`:
   ```dart
   class FooCubit extends Cubit<DataState<Foo>> {
     FooCubit({this.id}) : _service = getIt<FooService>(), super(const DataState.content(...init...)) { _init(); }
     final FooService _service;
     final int? id;
     bool get isEdit => id != null;
     Future<void> _init() async {
       if (!isEdit) return;
       emit(const DataState.loading());
       try { final v = await _service.fetchById(id!); emit(DataState.content(v)); }
       catch (e) { emit(DataState.error(e)); }
     }
     Future<Foo?> submit(Foo draft) async { ... emit loading; try/catch; return result or null ... }
   }
   ```
   - Cubit pulls deps from `getIt` in the constructor body (project convention).
   - Close any streams/subscriptions the cubit owns in `close()` (call `super.close()` last).
   - Do NOT put `TextEditingController`/`TabController`/`FocusNode` in the Cubit — those are UI controllers.

2. **StatefulWidget owns UI controllers with correct dispose.** Keep `TextEditingController`, `TabController`, `FocusNode`, `ScrollController`, `PageController` as State fields and DISPOSE them all in `dispose()`. This is the leak fix.

3. **Provide the cubit via `BlocProvider`**, not getIt.pushNewScope. Wrap the screen:
   ```dart
   BlocProvider(create: (_) => FooCubit(id: id), child: const _FooView())
   ```
   or provide in the route builder. Remove any `getIt.pushNewScope`/`popScope` for controllers.

4. **Render with `BlocBuilder` + `DataStateBuilder`.** Replace `StateBuilder`/`StreamBuilder<ScreenDataState>` with:
   ```dart
   BlocBuilder<FooCubit, DataState<Foo>>(
     builder: (context, state) => DataStateBuilder<Foo>(
       state: state, loader: (_) => const LoaderHolderWidget(),
       errorBuilder: (_, e) => ErrorHolderWidget(error: e),
       builder: (_, data) => ...content...,
     ),
   )
   ```
   For simple boolean/int sub-states (tab index, checkbox, obscure) either fold them into a richer state class (equatable) or use a small dedicated Cubit; prefer one cubit per screen with an equatable state object holding `{DataState<T> data, ...ui flags...}` when there are several flags.

5. **Navigation return values unchanged.** Screens that returned a value via `Navigator.pop(result)` / `context.pop(result)` keep doing so — the cubit's `submit()` returns the result to the widget, which pops. go_router `context.push<T>()` still receives it.

6. **Conventions:** line length 100; no hardcoded user-facing strings (use `StringRes.current.*` / `.of(context)`); Russian doc-comments; sealed classes for any bloc events/states (not freezed); `package:` absolute imports.

## Verify per file
After editing, the file must have: no `ScreenDataState`, no undisposed controllers, cubit provided via BlocProvider, behaviour preserved. Report exactly what you changed.
