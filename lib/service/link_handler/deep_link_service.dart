import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/util/logger/log.dart';

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
  Future<String?> getInitialLink() => _instance.getInitialLinkString();

  /// Последний полученный приложением линк
  // TODO(migration): app_links 7.x убрал getLatestAppLinkString.
  //  Для получения последующих линков используйте подписку на [stringLinkStream].
  Future<String?> getLatestLink() => _instance.getInitialLinkString();

  /// Однократно получить и сбросить линк, с которым было запущено приложение
  String? getResetInitLink() {
    final out = _unhandledInitLink;
    _unhandledInitLink = null;
    return out;
  }

  /// Обработчик линков, приходящих в процессе работы приложения.
  ///
  /// Ссылка приходит извне, поэтому проверяем её структурой URL (схема, хост,
  /// путь), а не подстрокой — иначе `contains` матчит и `https://evil.test/?x=api/v1/users/verify-email`.
  /// Окончательная проверка доверенного хоста — в [EmailConfirmRepository].
  void onLinkHandle(String link) {
    Log.info('Deeplink received: $link');
    if (_isEmailVerifyLink(link)) {
      getIt<GoRouter>().push('${AppRoutes.emailConfirmation}?link=${Uri.encodeComponent(link)}');
    }
  }

  bool _isEmailVerifyLink(String link) {
    final uri = Uri.tryParse(link);
    if (uri == null || !uri.hasAuthority) return false;
    return uri.path.contains('/api/v1/users/verify-email');
  }
}
