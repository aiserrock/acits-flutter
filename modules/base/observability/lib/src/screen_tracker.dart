import 'package:flutter/widgets.dart';

/// Reports a screen by the path pattern of its route (`/animal/:id`), never by
/// the concrete location, so ids and query values stay on the device.
typedef ScreenSink = void Function(String screenName);

/// Navigator observer that names a screen after the route's path pattern.
///
/// go_router sets `RouteSettings.name` to the `name` of a `GoRoute` or, when the
/// route has none, to its path pattern — both are free of user data.
class ScreenTrackingObserver extends NavigatorObserver {
  ScreenTrackingObserver(this._onScreen);

  final ScreenSink _onScreen;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) => _report(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) => _report(newRoute);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => _report(previousRoute);

  void _report(Route<dynamic>? route) {
    final name = route?.settings.name;
    if (route is! PageRoute || name == null || name.isEmpty) return;
    _onScreen(name);
  }
}
