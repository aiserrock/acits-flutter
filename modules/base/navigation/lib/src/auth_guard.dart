import 'routes.dart';

/// Redirect-гард go_router без знания фич. Логику «авторизован ли пользователь»
/// поставляет root-приложение через колбэк — пакет остаётся primitives-only.
class AuthGuard {
  const AuthGuard({required this.isAuthenticated, this.publicRoutes = _defaultPublic});

  final bool Function() isAuthenticated;
  final Set<String> publicRoutes;

  static const _defaultPublic = <String>{
    Routes.splash,
    Routes.onboarding,
    Routes.login,
    Routes.register,
    Routes.emailConfirmation,
  };

  /// Возвращает путь для redirect или null (пускаем как есть).
  /// `matchedLocation` — текущий путь без query.
  String? redirect(String matchedLocation) {
    if (isAuthenticated() || publicRoutes.contains(matchedLocation)) return null;
    return Routes.login;
  }
}
