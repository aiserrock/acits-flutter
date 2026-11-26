import 'package:acits_flutter/startup_failure_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('shows an error and a retry button instead of a blank screen', (tester) async {
    var retries = 0;
    await tester.pumpWidget(StartupFailureApp(onRetry: () async => retries++));

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(retries, 1);
  });

  testWidgets('shows a progress indicator while the retry runs', (tester) async {
    var finish = false;
    await tester.pumpWidget(
      StartupFailureApp(
        onRetry: () async {
          while (!finish) {
            await Future<void>.delayed(const Duration(milliseconds: 10));
          }
        },
      ),
    );

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(FilledButton), findsNothing);

    finish = true;
    await tester.pump(const Duration(milliseconds: 20));
    expect(find.byType(FilledButton), findsOneWidget);
  });
}
