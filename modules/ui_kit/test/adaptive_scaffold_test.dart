import 'package:ui_kit/acits_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _destinations = [
  AdaptiveDestination(icon: Icon(Icons.home), label: 'Home'),
  AdaptiveDestination(icon: Icon(Icons.search), label: 'Search'),
  AdaptiveDestination(icon: Icon(Icons.person), label: 'Profile'),
];

Widget _harness(Size size, {Widget? secondaryPane, bool twoPane = true}) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: MaterialApp(
      theme: AppTheme.light,
      home: AdaptiveScaffold(
        destinations: _destinations,
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        body: const Center(child: Text('body')),
        secondaryPane: secondaryPane,
        twoPane: twoPane,
      ),
    ),
  );
}

void main() {
  testWidgets('compact (<600) shows NavigationBar, no rail', (tester) async {
    await tester.pumpWidget(_harness(const Size(375, 800)));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('medium (>=600) shows collapsed NavigationRail', (tester) async {
    await tester.pumpWidget(_harness(const Size(700, 800)));
    expect(find.byType(NavigationBar), findsNothing);
    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.extended, isFalse);
  });

  testWidgets('expanded (>=840) shows extended NavigationRail', (tester) async {
    await tester.pumpWidget(_harness(const Size(1000, 800)));
    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.extended, isTrue);
  });

  testWidgets('large (>=1200) with secondaryPane renders two panes', (tester) async {
    await tester.pumpWidget(_harness(const Size(1300, 800), secondaryPane: const Center(child: Text('secondary'))));
    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.extended, isTrue);
    expect(find.text('body'), findsOneWidget);
    expect(find.text('secondary'), findsOneWidget);
  });

  testWidgets('large with twoPane=false keeps a single pane', (tester) async {
    await tester.pumpWidget(
      _harness(const Size(1300, 800), secondaryPane: const Center(child: Text('secondary')), twoPane: false),
    );
    expect(find.text('secondary'), findsNothing);
    expect(find.text('body'), findsOneWidget);
  });
}
