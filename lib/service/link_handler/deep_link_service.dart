import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';

@singleton
class DeepLinkService implements Disposable {
  DeepLinkService() {
    getInitialLink().then((value) => _unhandledInitLink = value);
    _subscription = _instance.stringLinkStream.listen(onLinkHandle);
  }

  StreamSubscription<String>? _subscription;

  AppLinks? _appLinksInstance;

  AppLinks get _instance => _appLinksInstance ??= AppLinks();

  String? _unhandledInitLink;

  @override
  FutureOr onDispose() {
    _subscription?.cancel();
  }

  /// Линк, с которым было запущено приложение
  Future<String?> getInitialLink() => _instance.getInitialAppLinkString();

  /// Последний полученный приложением линк
  Future<String?> getLatestLink() => _instance.getLatestAppLinkString();

  /// Однократно получить и сбросить линк, с которым было запущено приложение
  String? getResetInitLink() {
    final out = _unhandledInitLink;
    _unhandledInitLink = null;
    return out;
  }

  /// Обработчик линков, приходящих в процессе работы приложения
  void onLinkHandle(String link) {
    if (link.contains('api/v1/users/verify-email')) {
      getIt<GlobalKey<NavigatorState>>().currentState?.push(
            MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text(link),
                ),
              ),
            ),
          );
    }
  }
}
