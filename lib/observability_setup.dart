import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:observability/observability.dart';
import 'package:util/util.dart';

/// Error reporting shared by both flavors.
///
/// Created before anything else can fail: the Flutter and platform error hooks
/// feed [reporter] from the first line of startup. Backends join as they come
/// up — Crashlytics once Firebase is initialised, Sentry when a DSN was built in.
final class ObservabilitySetup {
  ObservabilitySetup({required this.environment});

  /// Flavor name: `prod` or `dev`.
  final String environment;

  final List<ErrorReporter> _backends = [];
  SentryErrorReporter? _sentry;
  bool _firebaseReady = false;

  /// Whether Firebase initialised for this build (Remote Config needs it).
  bool get firebaseReady => _firebaseReady;

  late final ErrorReporter reporter = CompositeErrorReporter(_backends);

  /// Routes uncaught Flutter and platform errors to [reporter]. Call first.
  void installErrorHooks() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      reporter.recordError(details.exception, details.stack, reason: details.context?.toDescription(), fatal: true);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      reporter.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// Initialises Firebase. A failure is reported and startup goes on: the app
  /// must open even when Firebase is misconfigured or unavailable.
  Future<void> initFirebase(FirebaseOptions options) async {
    try {
      await Firebase.initializeApp(options: options);
      _firebaseReady = true;
      // Crashlytics has no web implementation.
      if (!kIsWeb) _backends.add(CrashlyticsErrorReporter());
    } catch (error, stack) {
      debugPrint('Firebase init failed: $error');
      await reporter.recordError(error, stack, reason: 'Firebase init failed');
    }
  }

  /// Starts Sentry when the build carries a DSN. Needs [AppVersion.load].
  Future<void> initSentry() async {
    final sentry = SentryErrorReporter(
      SentryConfig.fromEnvironment(environment: environment, release: AppVersion.version, dist: AppVersion.buildNumber),
    );
    _sentry = sentry;
    _backends.add(sentry);
    try {
      await sentry.start();
    } catch (error) {
      debugPrint('Sentry init failed: $error');
    }
  }

  /// The user's opt-out, wired to every backend that collects data.
  CollectionSettings collectionSettings(CollectionPreferenceStore store) => CollectionSettings(
    store: store,
    switches: [
      reporter.setCollectionEnabled,
      (enabled) async {
        if (_firebaseReady) await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled);
      },
    ],
  );

  /// Navigator observers: screen views for Analytics and breadcrumbs for error
  /// reports. Screens are named by route pattern, so no ids leave the device.
  List<NavigatorObserver> navigatorObservers() => [
    ScreenTrackingObserver((screen) {
      reporter.breadcrumb('screen $screen');
      if (_firebaseReady) FirebaseAnalytics.instance.logScreenView(screenName: screen);
    }),
  ];

  /// Ties reports to the signed-in session by ids only; `null` clears it.
  Future<void> setUser({int? userId, int? shelterId}) async {
    await reporter.setUser(userId: userId?.toString(), shelterId: shelterId?.toString());
    if (_firebaseReady) await FirebaseAnalytics.instance.setUserId(id: userId?.toString());
  }

  /// Whether Sentry was configured for this build (shown on the debug screen).
  bool get isSentryConfigured => _sentry?.config.isEnabled ?? false;
}
