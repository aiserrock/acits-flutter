import 'dart:convert';

import 'package:acits_flutter/update_policy.dart';
import 'package:auth/auth.dart' show UpdateRequirement;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockConfig extends Mock implements FirebaseRemoteConfig {}

class _FakeSettings extends Fake implements RemoteConfigSettings {}

RemoteConfigValue _value(Object value, ValueSource source) => RemoteConfigValue(utf8.encode(value.toString()), source);

void main() {
  late _MockConfig config;

  setUpAll(() => registerFallbackValue(_FakeSettings()));

  setUp(() {
    config = _MockConfig();
    when(() => config.setConfigSettings(any())).thenAnswer((_) async {});
    when(() => config.setDefaults(any())).thenAnswer((_) async {});
    when(() => config.fetchAndActivate()).thenAnswer((_) async => true);
  });

  /// Stubs the four parameters; [remote] marks which ones came from the server.
  void stub({int min = 0, int recommended = 0, bool kill = false, String message = '', Set<String> remote = const {}}) {
    ValueSource src(String key) => remote.contains(key) ? ValueSource.valueRemote : ValueSource.valueDefault;
    when(
      () => config.getValue(UpdateConfigKeys.minSupportedBuild),
    ).thenReturn(_value(min, src(UpdateConfigKeys.minSupportedBuild)));
    when(
      () => config.getValue(UpdateConfigKeys.recommendedBuild),
    ).thenReturn(_value(recommended, src(UpdateConfigKeys.recommendedBuild)));
    when(() => config.getValue(UpdateConfigKeys.killSwitch)).thenReturn(_value(kill, src(UpdateConfigKeys.killSwitch)));
    when(() => config.getInt(UpdateConfigKeys.minSupportedBuild)).thenReturn(min);
    when(() => config.getInt(UpdateConfigKeys.recommendedBuild)).thenReturn(recommended);
    when(() => config.getBool(UpdateConfigKeys.killSwitch)).thenReturn(kill);
    when(() => config.getString(UpdateConfigKeys.message)).thenReturn(message);
  }

  RemoteConfigUpdatePolicy policy({bool firebaseReady = true, int build = 1015}) =>
      RemoteConfigUpdatePolicy(firebaseReady: firebaseReady, config: config, buildNumber: () => build);

  test('without Firebase nothing is checked and nobody is blocked', () async {
    expect(await policy(firebaseReady: false).check(), UpdateRequirement.none);
    verifyNever(() => config.fetchAndActivate());
  });

  test('a failed fetch never blocks: offline users keep working', () async {
    when(() => config.fetchAndActivate()).thenThrow(Exception('offline'));
    expect(await policy().check(), UpdateRequirement.none);
  });

  test('values that only come from the in-app defaults are ignored', () async {
    stub(min: 9999, kill: true);
    expect(await policy().check(), UpdateRequirement.none);
  });

  test('a remote minimum above this build requires an update', () async {
    stub(min: 1020, recommended: 1020, remote: {UpdateConfigKeys.minSupportedBuild, UpdateConfigKeys.recommendedBuild});
    expect(await policy(build: 1015).check(), UpdateRequirement.required);
  });

  test('a remote recommended build above this one suggests an update', () async {
    stub(min: 1000, recommended: 1020, remote: {UpdateConfigKeys.minSupportedBuild, UpdateConfigKeys.recommendedBuild});
    expect(await policy(build: 1015).check(), UpdateRequirement.recommended);
  });

  test('the remote kill-switch blocks and carries the remote message', () async {
    stub(kill: true, message: 'Технические работы до 18:00', remote: {UpdateConfigKeys.killSwitch});
    final p = policy();
    expect(await p.check(), UpdateRequirement.blocked);
    expect(p.message, 'Технические работы до 18:00');
  });

  test('a build without a number (web, dev run) is only subject to the kill-switch', () async {
    stub(min: 5000, remote: {UpdateConfigKeys.minSupportedBuild});
    expect(await policy(build: 0).check(), UpdateRequirement.none);
  });

  test('openStore swallows launcher errors', () async {
    final p = RemoteConfigUpdatePolicy(firebaseReady: false, launch: (_) async => throw Exception('no browser'));
    await expectLater(p.openStore(), completes);
  });
}
