import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_kit/ui_kit.dart' show PrimaryButton;

class _MockAuth extends Mock implements AuthSessionApi {}

class _MockConfig extends Mock implements AuthConfigInitializer {}

class _MockNavigator extends Mock implements SplashNavigator {}

class _FakePolicy implements AppUpdatePolicy {
  _FakePolicy(this.answers);

  final List<UpdateRequirement> answers;
  int checks = 0;
  int storeOpened = 0;

  @override
  Future<UpdateRequirement> check() async => answers[(checks++).clamp(0, answers.length - 1)];

  @override
  String? get message => null;

  @override
  Future<void> openStore() async => storeOpened++;
}

void main() {
  group('UpdateLimits.requirementFor', () {
    const limits = UpdateLimits(minSupportedBuild: 1010, recommendedBuild: 1020);

    test('a build below the minimum must update', () {
      expect(limits.requirementFor(1009), UpdateRequirement.required);
    });

    test('a build between the minimum and the recommended one is told about the update', () {
      expect(limits.requirementFor(1010), UpdateRequirement.recommended);
      expect(limits.requirementFor(1019), UpdateRequirement.recommended);
    });

    test('a current build carries on', () {
      expect(limits.requirementFor(1020), UpdateRequirement.none);
      expect(limits.requirementFor(2000), UpdateRequirement.none);
    });

    test('an unknown build (web, dev run) is never forced to update', () {
      expect(limits.requirementFor(0), UpdateRequirement.none);
    });

    test('the kill-switch blocks every build, known or not', () {
      const off = UpdateLimits(killSwitch: true);
      expect(off.requirementFor(0), UpdateRequirement.blocked);
      expect(off.requirementFor(5000), UpdateRequirement.blocked);
    });

    test('default limits never block anyone', () {
      expect(const UpdateLimits().requirementFor(1), UpdateRequirement.none);
    });
  });

  group('SplashScreen update gate', () {
    late _MockAuth auth;
    late _MockConfig config;
    late _MockNavigator navigator;

    setUp(() {
      auth = _MockAuth();
      config = _MockConfig();
      navigator = _MockNavigator();
      when(() => config.isFirstLaunch).thenReturn(false);
      when(() => auth.tryRefreshLastAuth()).thenAnswer((_) async => false);
    });

    Future<void> pump(WidgetTester tester, AppUpdatePolicy? policy) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SplashScreen(
            authService: auth,
            configService: config,
            navigator: navigator,
            logo: const SizedBox(),
            loadingAnimations: const ['missing.json'],
            updatePolicy: policy,
          ),
        ),
      );
      // Past the two-second minimum splash.
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
    }

    testWidgets('a required update stops before routing and offers only the store', (tester) async {
      final policy = _FakePolicy([UpdateRequirement.required]);
      await pump(tester, policy);

      expect(find.byType(UpdateGateView), findsOneWidget);
      verify(() => navigator.revealInPlace()).called(1);
      verifyNever(() => navigator.toLoginAndReveal());
      verifyNever(() => auth.tryRefreshLastAuth());
      expect(find.byType(TextButton), findsNothing);

      await tester.tap(find.byType(PrimaryButton));
      expect(policy.storeOpened, 1);
    });

    testWidgets('a recommended update can be skipped and the start route continues', (tester) async {
      await pump(tester, _FakePolicy([UpdateRequirement.recommended]));
      expect(find.byType(UpdateGateView), findsOneWidget);

      await tester.tap(find.byType(TextButton));
      await tester.pump(const Duration(seconds: 3));

      verify(() => navigator.toLoginAndReveal()).called(1);
    });

    testWidgets('the kill-switch retries and lets the user in once it is lifted', (tester) async {
      final policy = _FakePolicy([UpdateRequirement.blocked, UpdateRequirement.none]);
      await pump(tester, policy);
      expect(find.byType(UpdateGateView), findsOneWidget);
      verifyNever(() => navigator.toLoginAndReveal());

      await tester.tap(find.byType(PrimaryButton));
      await tester.pump(const Duration(seconds: 3));

      expect(policy.checks, 2);
      verify(() => navigator.toLoginAndReveal()).called(1);
    });

    testWidgets('no policy, or nothing to do, routes as before', (tester) async {
      await pump(tester, _FakePolicy([UpdateRequirement.none]));
      expect(find.byType(UpdateGateView), findsNothing);
      verify(() => navigator.toLoginAndReveal()).called(1);
    });
  });
}
