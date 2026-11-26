import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';

/// Pins the routing shape of the animals tab (see `app_router.dart`): a shell
/// route around `/animals` and `/animals/:id` wrapped in [ListDetailLayout].
/// The real screens need DI, so plain widgets stand in for them.
void main() {
  late int listBuilds;

  GoRouter router() => GoRouter(
    initialLocation: '/animals',
    routes: [
      ShellRoute(
        builder: (context, state, child) => ListDetailLayout(list: const _List(), detail: child),
        routes: [
          GoRoute(
            path: '/animals',
            builder: (context, state) => ListDetailLayout.isSplit(context) ? const Text('pick') : const _List(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) => Scaffold(
                  key: ValueKey(state.pathParameters['id']),
                  body: Text('card ${state.pathParameters['id']}'),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  setUp(() => listBuilds = 0);

  Future<GoRouter> pump(WidgetTester tester, Size size) async {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final r = router();
    await tester.pumpWidget(
      _ListBuildCounter(
        onBuild: () => listBuilds++,
        child: MaterialApp.router(routerConfig: r),
      ),
    );
    return r;
  }

  testWidgets('phone: the card opens over the list and «back» returns to it', (tester) async {
    final r = await pump(tester, const Size(390, 800));
    expect(find.text('list'), findsOneWidget);

    r.go('/animals/7');
    await tester.pumpAndSettle();
    expect(find.text('card 7'), findsOneWidget);

    r.pop();
    await tester.pumpAndSettle();
    expect(find.text('list'), findsOneWidget);
    expect(find.text('card 7'), findsNothing);
  });

  testWidgets('wide window: the list stays on the left while cards replace each other', (tester) async {
    final r = await pump(tester, const Size(1300, 800));
    expect(find.text('list'), findsOneWidget);
    expect(find.text('pick'), findsOneWidget);

    r.go('/animals/7');
    await tester.pumpAndSettle();
    final buildsAfterFirstCard = listBuilds;
    expect(find.text('list'), findsOneWidget);
    expect(find.text('card 7'), findsOneWidget);

    r.go('/animals/8');
    await tester.pumpAndSettle();
    expect(find.text('card 8'), findsOneWidget);
    expect(find.text('card 7'), findsNothing);
    expect(find.text('list'), findsOneWidget);
    // The list pane is the same element: picking another animal does not rebuild it.
    expect(listBuilds, buildsAfterFirstCard);
  });

  testWidgets('a deep link to a card on a wide window shows the list next to it', (tester) async {
    final r = await pump(tester, const Size(1300, 800));

    r.go('/animals/42');
    await tester.pumpAndSettle();

    expect(find.text('list'), findsOneWidget);
    expect(find.text('card 42'), findsOneWidget);
  });
}

class _List extends StatefulWidget {
  const _List();

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  @override
  Widget build(BuildContext context) {
    context.findAncestorWidgetOfExactType<_ListBuildCounter>()?.onBuild();
    return const Scaffold(body: Text('list'));
  }
}

class _ListBuildCounter extends InheritedWidget {
  const _ListBuildCounter({required this.onBuild, required super.child});

  final VoidCallback onBuild;

  @override
  bool updateShouldNotify(_ListBuildCounter oldWidget) => false;
}
