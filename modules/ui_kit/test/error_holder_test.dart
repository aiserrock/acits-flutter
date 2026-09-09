import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';
// `Timeout` collides with the test framework's own Timeout — prefix the domain one.
import 'package:util/util.dart' as domain;

/// The widget turns a typed [domain.Failure] into what the user reads. Getting
/// this wrong is invisible to the analyzer and to every other test: a mismapped
/// variant still compiles and still renders *something*.
///
/// There is no translation bundle in this package, so easy_localization's
/// `.tr()` returns the key itself. That is enough — these tests assert that
/// different failures resolve to DIFFERENT keys, which is exactly the property
/// that regressed.
void main() {
  Future<void> pump(WidgetTester tester, Object error) async {
    // The stub sizes its illustration off the viewport; the 800x600 default
    // leaves the column short and overflows. Give it a phone-sized screen.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ErrorHolderWidget(error: error)),
      ),
    );
    await tester.pump();
  }

  String textOf(WidgetTester tester) => tester.widgetList<Text>(find.byType(Text)).map((t) => t.data ?? '').join('|');

  testWidgets('a 4xx refusal shows the server explanation, not "server unavailable"', (tester) async {
    await pump(tester, const domain.ServerFailure(400, 'phone_number: enter a valid number'));
    final shown = textOf(tester);

    // The response body says which field failed — that is the point of showing it.
    expect(shown, contains('phone_number'));
    expect(shown, isNot(contains('errorServerFail')));
  });

  testWidgets('a 5xx does report the server as unavailable', (tester) async {
    await pump(tester, const domain.ServerFailure(503));
    final serverText = textOf(tester);

    await pump(tester, const domain.ServerFailure(400, 'validation detail'));
    final clientText = textOf(tester);

    // A dead server and a refused request must not read identically.
    expect(serverText, contains('errorServerFail'));
    expect(serverText, isNot(equals(clientText)));
  });

  testWidgets('offline and timeout are distinguishable', (tester) async {
    await pump(tester, const domain.NoInternet());
    final offline = textOf(tester);

    await pump(tester, const domain.Timeout());
    final timeout = textOf(tester);

    expect(offline, contains('errorInternetFail'));
    expect(timeout, contains('errorTimeoutFail'));
    expect(offline, isNot(equals(timeout)));
  });

  testWidgets('an auth failure gets its own message', (tester) async {
    await pump(tester, const domain.AuthFailure());
    final auth = textOf(tester);

    await pump(tester, const domain.UnknownFailure());
    final unknown = textOf(tester);

    expect(auth, contains('errorAuthFail'));
    expect(auth, isNot(equals(unknown)));
  });
}
