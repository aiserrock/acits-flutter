import 'package:ui_kit/ui_kit.dart';
import 'package:material_ui/material_ui.dart';
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

  group('drawer, rail leading and disabled destinations', () {
    Widget app(Size size, {required GlobalKey<ScaffoldState> scaffoldKey, List<int>? selected}) => MediaQuery(
      data: MediaQueryData(size: size),
      child: MaterialApp(
        theme: AppTheme.light,
        home: AdaptiveScaffold(
          scaffoldKey: scaffoldKey,
          drawer: const Drawer(child: Text('drawer')),
          railLeading: const Text('leading'),
          destinations: const [
            AdaptiveDestination(icon: Icon(Icons.home), label: 'Home'),
            AdaptiveDestination(icon: Icon(Icons.search), label: 'Search'),
            AdaptiveDestination(icon: Icon(Icons.event), label: 'Locked', enabled: false),
          ],
          selectedIndex: 0,
          onDestinationSelected: (index) => selected?.add(index),
          body: const SizedBox(),
        ),
      ),
    );

    for (final size in const [Size(375, 800), Size(700, 800), Size(1300, 800)]) {
      testWidgets('the drawer opens through the scaffold key at ${size.width.toInt()} px', (tester) async {
        final key = GlobalKey<ScaffoldState>();
        await tester.pumpWidget(app(size, scaffoldKey: key));
        expect(find.text('drawer'), findsNothing);

        key.currentState!.openDrawer();
        await tester.pumpAndSettle();

        expect(find.text('drawer'), findsOneWidget);
      });
    }

    testWidgets('the rail shows its leading widget; the bottom bar has none', (tester) async {
      await tester.pumpWidget(app(const Size(700, 800), scaffoldKey: GlobalKey()));
      expect(find.text('leading'), findsOneWidget);

      await tester.pumpWidget(app(const Size(375, 800), scaffoldKey: GlobalKey()));
      expect(find.text('leading'), findsNothing);
    });

    for (final size in const [Size(375, 800), Size(700, 800)]) {
      testWidgets('a disabled destination cannot be selected at ${size.width.toInt()} px', (tester) async {
        final selected = <int>[];
        await tester.pumpWidget(app(size, scaffoldKey: GlobalKey(), selected: selected));

        await tester.tap(find.text('Locked'));
        await tester.tap(find.text('Search'));

        expect(selected, [1]);
      });
    }
  });

  testWidgets('bottomInset keeps the bar above an unreported bottom safe area', (tester) async {
    Future<double> barBottom(double inset) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(375, 800)),
          child: MaterialApp(
            home: AdaptiveScaffold(
              destinations: _destinations,
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              bottomInset: inset,
              body: const SizedBox(),
            ),
          ),
        ),
      );
      return tester.getBottomLeft(find.byType(NavigationBar)).dy;
    }

    final flush = await barBottom(0);
    final raised = await barBottom(34);
    expect(flush - raised, 34);
  });

  testWidgets('ContentWidth caps wide content and passes narrow content through', (tester) async {
    Future<double> widthAt(double window) async {
      await tester.pumpWidget(
        Center(
          child: SizedBox(
            width: window,
            height: 400,
            child: const Directionality(
              textDirection: TextDirection.ltr,
              child: ContentWidth(child: SizedBox.expand(key: Key('content'))),
            ),
          ),
        ),
      );
      return tester.getSize(find.byKey(const Key('content'))).width;
    }

    expect(await widthAt(360), 360);
    expect(await widthAt(1400), ContentWidth.form);
  });
}
