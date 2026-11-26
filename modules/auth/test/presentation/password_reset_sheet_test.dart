import 'package:auth/auth.dart';
import 'package:auth/presentation/login/view/password_reset_sheet.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_kit/ui_kit.dart' show PrimaryButton;
import 'package:util/util.dart';

class _MockAuth extends Mock implements AuthSessionApi {}

void main() {
  late _MockAuth auth;

  setUp(() => auth = _MockAuth());

  test('e-mail check accepts addresses and rejects logins and typos', () {
    expect(isPlausibleEmail('user@example.org'), isTrue);
    expect(isPlausibleEmail('  user@example.org '), isTrue);
    expect(isPlausibleEmail('ivanov'), isFalse);
    expect(isPlausibleEmail('user@example'), isFalse);
    expect(isPlausibleEmail('us er@example.org'), isFalse);
    expect(isPlausibleEmail(''), isFalse);
  });

  test('only a 400 counts as an unknown address', () {
    expect(isUnknownAddress(const ServerFailure(400)), isTrue);
    expect(isUnknownAddress(const ServerFailure(500)), isFalse);
    expect(isUnknownAddress(const NoInternet()), isFalse);
  });

  Future<void> pump(WidgetTester tester, {String initialEmail = ''}) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        // A fresh key per pump: a new sheet, not the previous state with new props.
        body: PasswordResetSheet(key: UniqueKey(), auth: auth, initialEmail: initialEmail),
      ),
    ),
  );

  testWidgets('a login typed on the form does not pre-fill the e-mail; an e-mail does', (tester) async {
    await pump(tester, initialEmail: 'ivanov');
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, '');

    await pump(tester, initialEmail: 'user@example.org');
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, 'user@example.org');
  });

  testWidgets('an invalid address is rejected before any request', (tester) async {
    await pump(tester);
    await tester.enterText(find.byType(TextField), 'ivanov');
    await tester.tap(find.byType(PrimaryButton));
    await tester.pump();

    verifyNever(() => auth.requestPasswordReset(any()));
    expect(tester.widget<TextField>(find.byType(TextField)).decoration!.errorText, isNotNull);
  });

  testWidgets('a known and an unknown address get the same confirmation', (tester) async {
    for (final answer in <Result<Failure, void>>[const Ok(null), const Err(ServerFailure(400))]) {
      when(() => auth.requestPasswordReset(any())).thenAnswer((_) async => answer);
      await pump(tester);
      await tester.enterText(find.byType(TextField), 'user@example.org');
      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNothing, reason: '$answer');
      verify(() => auth.requestPasswordReset('user@example.org')).called(1);
    }
  });

  testWidgets('a network failure keeps the form and shows an error', (tester) async {
    when(() => auth.requestPasswordReset(any())).thenAnswer((_) async => const Err(NoInternet()));
    await pump(tester);
    await tester.enterText(find.byType(TextField), 'user@example.org');
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('errorInternetFailMsg'), findsOneWidget);
  });
}
