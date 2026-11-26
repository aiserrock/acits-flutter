import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart' hide Timeout;
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_kit/ui_kit.dart' show PrimaryButton;
import 'package:util/util.dart';

class _MockAuth extends Mock implements AuthSessionApi {}

const _link = 'https://stage.app.acits.ru/api/v1/users/reset-password/confirm/MTIz/abc-def/';

void main() {
  group('PasswordResetLink.tryParse', () {
    test('reads uidb64 and token from an acits link', () {
      final link = PasswordResetLink.tryParse(_link)!;
      expect(link.uidb64, 'MTIz');
      expect(link.token, 'abc-def');
    });

    test('rejects other hosts, plain http and incomplete paths', () {
      expect(PasswordResetLink.tryParse('https://evil.test/api/v1/users/reset-password/confirm/MTIz/abc/'), isNull);
      expect(PasswordResetLink.tryParse('https://acits.ru.evil.test/api/v1/users/reset-password/confirm/a/b/'), isNull);
      expect(PasswordResetLink.tryParse('http://app.acits.ru/api/v1/users/reset-password/confirm/MTIz/abc/'), isNull);
      expect(PasswordResetLink.tryParse('https://app.acits.ru/api/v1/users/reset-password/confirm/MTIz/'), isNull);
      expect(PasswordResetLink.tryParse('not a link'), isNull);
    });
  });

  group('NewPasswordScreen', () {
    late _MockAuth auth;
    late int done;

    setUp(() {
      auth = _MockAuth();
      done = 0;
    });

    Future<void> pump(WidgetTester tester, {String link = _link}) => tester.pumpWidget(
      MaterialApp(
        home: NewPasswordScreen(auth: auth, link: link, onDone: () => done++),
      ),
    );

    Future<void> fill(WidgetTester tester, String password, String repeat) async {
      await tester.enterText(find.byKey(const Key('newPassword')), password);
      await tester.enterText(find.byKey(const Key('repeatPassword')), repeat);
      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();
    }

    testWidgets('an invalid link shows only the way back', (tester) async {
      await pump(tester, link: 'https://evil.test/x');
      expect(find.byType(TextField), findsNothing);
      await tester.tap(find.byType(PrimaryButton));
      expect(done, 1);
    });

    testWidgets('a short or mismatched password is rejected before any request', (tester) async {
      await pump(tester);
      await fill(tester, 'short', 'short');
      await fill(tester, 'longenough1', 'different1');
      verifyNever(
        () => auth.completePasswordReset(
          uidb64: any(named: 'uidb64'),
          token: any(named: 'token'),
          newPassword: any(named: 'newPassword'),
        ),
      );
    });

    testWidgets('a valid password is sent with the link parts, then the user signs in', (tester) async {
      when(
        () => auth.completePasswordReset(
          uidb64: any(named: 'uidb64'),
          token: any(named: 'token'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer((_) async => const Ok(null));
      await pump(tester);
      await fill(tester, 'longenough1', 'longenough1');

      verify(() => auth.completePasswordReset(uidb64: 'MTIz', token: 'abc-def', newPassword: 'longenough1')).called(1);
      expect(find.byType(TextField), findsNothing);
      await tester.tap(find.byType(PrimaryButton));
      expect(done, 1);
    });

    testWidgets('an expired link keeps the form and explains why', (tester) async {
      when(
        () => auth.completePasswordReset(
          uidb64: any(named: 'uidb64'),
          token: any(named: 'token'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer((_) async => const Err(ServerFailure(400)));
      await pump(tester);
      await fill(tester, 'longenough1', 'longenough1');

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('resetPassLinkInvalid'), findsOneWidget);
    });
  });
}
