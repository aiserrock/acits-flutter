import 'dart:async';

import 'package:auth/auth.dart' show AppUpdatePolicy, UpdateLimits, UpdateRequirement;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:util/util.dart' show AppVersion;

/// Remote Config parameter names. Published in the Firebase console; frozen
/// once a store build reads them.
abstract final class UpdateConfigKeys {
  static const minSupportedBuild = 'min_supported_build';
  static const recommendedBuild = 'recommended_build';
  static const killSwitch = 'kill_switch';
  static const message = 'update_message';
}

/// Store pages for [AppUpdatePolicy.openStore].
abstract final class StoreLinks {
  static final googlePlay = Uri.parse('https://play.google.com/store/apps/details?id=ru.acits');
  static final rustore = Uri.parse('https://www.rustore.ru/catalog/app/ru.acits');

  /// App Store search by name until the app record exists; replace with the
  /// `apps.apple.com/app/id…` link after the first iOS release.
  static final appStore = Uri.parse('https://apps.apple.com/search?term=acits');
}

/// [AppUpdatePolicy] over Firebase Remote Config.
///
/// Safe by default: the in-app defaults never block anyone, a fetch is bounded
/// by [fetchTimeout], and any failure answers [UpdateRequirement.none]. A user
/// is locked out only by values that were actually fetched from the console.
class RemoteConfigUpdatePolicy implements AppUpdatePolicy {
  RemoteConfigUpdatePolicy({
    required bool firebaseReady,
    this.fetchTimeout = const Duration(seconds: 4),
    FirebaseRemoteConfig? config,
    int Function()? buildNumber,
    Future<bool> Function(Uri)? launch,
  }) : _firebaseReady = firebaseReady,
       _config = config,
       _buildNumber = buildNumber ?? (() => int.tryParse(AppVersion.buildNumber) ?? 0),
       _launch = launch ?? ((uri) => launchUrl(uri, mode: LaunchMode.externalApplication));

  final bool _firebaseReady;
  final Duration fetchTimeout;
  final FirebaseRemoteConfig? _config;
  final int Function() _buildNumber;
  final Future<bool> Function(Uri) _launch;

  UpdateLimits _limits = const UpdateLimits();

  /// Limits used by the last [check].
  @visibleForTesting
  UpdateLimits get limits => _limits;

  @override
  String? get message => _limits.message;

  @override
  Future<UpdateRequirement> check() async {
    if (!_firebaseReady) return UpdateRequirement.none;
    try {
      final config = _config ?? FirebaseRemoteConfig.instance;
      await config.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: fetchTimeout,
          // Short in debug so console changes show up while testing.
          minimumFetchInterval: kDebugMode ? Duration.zero : const Duration(hours: 1),
        ),
      );
      await config.setDefaults(const {
        UpdateConfigKeys.minSupportedBuild: 0,
        UpdateConfigKeys.recommendedBuild: 0,
        UpdateConfigKeys.killSwitch: false,
        UpdateConfigKeys.message: '',
      });
      await config.fetchAndActivate().timeout(fetchTimeout + const Duration(seconds: 1));
      _limits = limitsFrom(config);
    } catch (error) {
      // Offline, timeout, misconfigured project: keep the user working.
      debugPrint('Update policy: remote config unavailable ($error)');
      return UpdateRequirement.none;
    }
    return _limits.requirementFor(_buildNumber());
  }

  /// Reads the limits. A value counts only if it came from the server (now or
  /// in an earlier, cached fetch); in-app defaults never restrict anyone.
  @visibleForTesting
  static UpdateLimits limitsFrom(FirebaseRemoteConfig config) {
    bool remote(String key) => config.getValue(key).source == ValueSource.valueRemote;
    final message = config.getString(UpdateConfigKeys.message);
    return UpdateLimits(
      minSupportedBuild: remote(UpdateConfigKeys.minSupportedBuild)
          ? config.getInt(UpdateConfigKeys.minSupportedBuild)
          : 0,
      recommendedBuild: remote(UpdateConfigKeys.recommendedBuild)
          ? config.getInt(UpdateConfigKeys.recommendedBuild)
          : 0,
      killSwitch: remote(UpdateConfigKeys.killSwitch) && config.getBool(UpdateConfigKeys.killSwitch),
      message: message.isEmpty ? null : message,
    );
  }

  @override
  Future<void> openStore() async {
    final uri = switch (defaultTargetPlatform) {
      TargetPlatform.iOS || TargetPlatform.macOS => StoreLinks.appStore,
      _ => _isRuStoreBuild ? StoreLinks.rustore : StoreLinks.googlePlay,
    };
    try {
      await _launch(uri);
    } catch (error) {
      debugPrint('Update policy: cannot open $uri ($error)');
    }
  }

  /// RuStore builds are the same APK; `--dart-define=STORE=rustore` marks them.
  static const _isRuStoreBuild = String.fromEnvironment('STORE') == 'rustore';
}
