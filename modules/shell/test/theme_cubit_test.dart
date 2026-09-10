import 'package:app_services/app_services.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shell/widget/cubit/theme_cubit.dart';

class _MockThemeStorage extends Mock implements ThemeStorage {}

void main() {
  late _MockThemeStorage storage;

  setUpAll(() => registerFallbackValue(ThemeMode.system));

  setUp(() {
    storage = _MockThemeStorage();
    when(() => storage.write(any())).thenAnswer((_) async {});
  });

  blocTest<ThemeCubit, ThemeMode>(
    'loads the persisted mode on construction',
    setUp: () => when(storage.read).thenAnswer((_) async => ThemeMode.dark),
    build: () => ThemeCubit(storage: storage),
    wait: const Duration(milliseconds: 10),
    expect: () => [ThemeMode.dark],
  );

  blocTest<ThemeCubit, ThemeMode>(
    'setMode emits the new mode and persists it',
    setUp: () => when(storage.read).thenAnswer((_) async => ThemeMode.system),
    build: () => ThemeCubit(storage: storage),
    // Let the initial load settle first, so this asserts setMode alone.
    wait: const Duration(milliseconds: 10),
    act: (cubit) => cubit.setMode(ThemeMode.light),
    expect: () => [ThemeMode.light],
    verify: (_) => verify(() => storage.write(ThemeMode.light)).called(1),
  );

  blocTest<ThemeCubit, ThemeMode>(
    'setMode to the current mode does not persist again',
    setUp: () => when(storage.read).thenAnswer((_) async => ThemeMode.dark),
    build: () => ThemeCubit(storage: storage),
    // `wait` only applies AFTER act, so settle the initial load inside act —
    // otherwise the cubit is still on the default and this would not be a no-op.
    act: (cubit) async {
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await cubit.setMode(ThemeMode.dark);
    },
    // Only the initial load lands; the redundant set writes nothing.
    expect: () => [ThemeMode.dark],
    verify: (_) => verifyNever(() => storage.write(ThemeMode.dark)),
  );

  blocTest<ThemeCubit, ThemeMode>(
    'a choice made before the load finishes is not overwritten by it',
    // Storage is slow and would answer `dark`, but the user picks `light` first.
    setUp: () =>
        when(storage.read).thenAnswer((_) => Future.delayed(const Duration(milliseconds: 30), () => ThemeMode.dark)),
    build: () => ThemeCubit(storage: storage),
    act: (cubit) => cubit.setMode(ThemeMode.light),
    wait: const Duration(milliseconds: 60),
    expect: () => [ThemeMode.light],
    verify: (cubit) => expect(cubit.state, ThemeMode.light),
  );

  blocTest<ThemeCubit, ThemeMode>(
    'falls back to system when storage has nothing stored',
    setUp: () => when(storage.read).thenAnswer((_) async => ThemeMode.system),
    build: () => ThemeCubit(storage: storage),
    wait: const Duration(milliseconds: 10),
    expect: () => [ThemeMode.system],
    verify: (cubit) => expect(cubit.state, ThemeMode.system),
  );
}
