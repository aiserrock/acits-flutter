import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observability/observability.dart';

void main() {
  late List<String> screens;
  late ScreenTrackingObserver observer;

  PageRoute<void> page(String? name) => PageRouteBuilder<void>(
    pageBuilder: (_, _, _) => const SizedBox(),
    settings: RouteSettings(name: name),
  );

  setUp(() {
    screens = [];
    observer = ScreenTrackingObserver(screens.add);
  });

  test('a pushed page is reported by its route pattern', () {
    observer.didPush(page('/animal/:id'), null);
    expect(screens, ['/animal/:id']);
  });

  test('popping reports the page that becomes visible again', () {
    observer.didPop(page('/animal/:id'), page('/root'));
    expect(screens, ['/root']);
  });

  test('a replaced page is reported', () {
    observer.didReplace(newRoute: page('/login'), oldRoute: page('/splash'));
    expect(screens, ['/login']);
  });

  test('routes without a name and non-page routes are ignored', () {
    observer
      ..didPush(page(null), null)
      ..didPush(_PopupRoute(const RouteSettings(name: '/animal/:id')), null);
    expect(screens, isEmpty);
  });
}

/// A named overlay route (dialog, sheet): not a screen, so it must not be reported.
class _PopupRoute extends PopupRoute<void> {
  _PopupRoute(RouteSettings settings) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
      const SizedBox();
}
