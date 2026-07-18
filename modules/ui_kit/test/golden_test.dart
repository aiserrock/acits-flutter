import 'package:ui_kit/acits_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _destinations = [
  AdaptiveDestination(icon: Icon(Icons.home), label: 'Home'),
  AdaptiveDestination(icon: Icon(Icons.search), label: 'Search'),
  AdaptiveDestination(icon: Icon(Icons.person), label: 'Profile'),
];

Widget _scaffoldAt(Size size) {
  return MediaQuery(
    data: MediaQueryData(size: size),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AdaptiveScaffold(
        destinations: _destinations,
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        appBar: const UiAppBar(title: 'Adaptive'),
        body: const Center(child: Text('body')),
      ),
    ),
  );
}

Future<void> _pumpSized(WidgetTester tester, Size size, Widget child) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(child);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('PrimaryButton golden', (tester) async {
    await _pumpSized(
      tester,
      const Size(300, 120),
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Scaffold(
          body: Center(
            child: PrimaryButton(onPressed: () {}, text: 'Primary'),
          ),
        ),
      ),
    );
    await expectLater(find.byType(PrimaryButton), matchesGoldenFile('goldens/primary_button.png'));
  });

  testWidgets('AdaptiveScaffold golden — compact bottom bar (375)', (tester) async {
    await _pumpSized(tester, const Size(375, 700), _scaffoldAt(const Size(375, 700)));
    await expectLater(find.byType(AdaptiveScaffold), matchesGoldenFile('goldens/scaffold_compact.png'));
  });

  testWidgets('AdaptiveScaffold golden — medium collapsed rail (700)', (tester) async {
    await _pumpSized(tester, const Size(700, 700), _scaffoldAt(const Size(700, 700)));
    await expectLater(find.byType(AdaptiveScaffold), matchesGoldenFile('goldens/scaffold_medium.png'));
  });

  testWidgets('AdaptiveScaffold golden — expanded extended rail (1000)', (tester) async {
    await _pumpSized(tester, const Size(1000, 700), _scaffoldAt(const Size(1000, 700)));
    await expectLater(find.byType(AdaptiveScaffold), matchesGoldenFile('goldens/scaffold_expanded.png'));
  });
}
