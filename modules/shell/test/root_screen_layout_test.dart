import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// The root screen delegates its navigation form to [AdaptiveScaffold]; this pins
/// the widths at which the app's four tabs switch between bar and rail.
void main() {
  const tabs = [
    AdaptiveDestination(icon: Icon(Icons.today), label: 'Today'),
    AdaptiveDestination(icon: Icon(Icons.pets), label: 'Animals'),
    AdaptiveDestination(icon: Icon(Icons.event), label: 'Calendar', enabled: false),
    AdaptiveDestination(icon: Icon(Icons.medication), label: 'Drugs', enabled: false),
  ];

  Future<void> pump(WidgetTester tester, double width) => tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: Size(width, 900)),
      child: MaterialApp(
        home: AdaptiveScaffold(
          destinations: tabs,
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          body: const SizedBox(),
        ),
      ),
    ),
  );

  testWidgets('phone width: bottom bar with all four tabs', (tester) async {
    await pump(tester, 390);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    for (final tab in tabs) {
      expect(find.text(tab.label), findsOneWidget);
    }
  });

  testWidgets('tablet width: collapsed rail, no bottom bar', (tester) async {
    await pump(tester, 800);
    expect(find.byType(NavigationBar), findsNothing);
    expect(tester.widget<NavigationRail>(find.byType(NavigationRail)).extended, isFalse);
  });

  testWidgets('desktop width: extended rail with labels', (tester) async {
    await pump(tester, 1440);
    expect(tester.widget<NavigationRail>(find.byType(NavigationRail)).extended, isTrue);
    expect(find.text('Animals'), findsOneWidget);
  });

  testWidgets('resizing the window switches the navigation form without losing the body', (tester) async {
    await pump(tester, 390);
    expect(find.byType(NavigationBar), findsOneWidget);
    await pump(tester, 1440);
    expect(find.byType(NavigationRail), findsOneWidget);
    await pump(tester, 390);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
