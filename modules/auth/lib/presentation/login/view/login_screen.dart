import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/login/login.dart';

/// Экран входа по логину - паролю.
///
/// Сессионные зависимости ([AuthSessionApi], deep-link/debug порты, роутер) и
/// app-виджеты (логотип, переключатели темы/локали, метка версии, иконки
/// показа пароля) приходят от корня приложения — модуль не знает про app-ассеты
/// и app-инфру.
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.authService,
    required this.deepLinkService,
    required this.debugService,
    required this.router,
    required this.appLogo,
    required this.themeToggle,
    required this.localeSwitcher,
    required this.versionLabel,
    required this.passwordVisibleIcon,
    required this.passwordHiddenIcon,
    super.key,
  });

  final AuthSessionApi authService;
  final AuthDeepLinkHandler deepLinkService;
  final AuthDebugHook debugService;
  final AuthRouterService router;

  final Widget appLogo;
  final Widget themeToggle;
  final Widget localeSwitcher;
  final Widget versionLabel;
  final Widget passwordVisibleIcon;
  final Widget passwordHiddenIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: themeToggle,
        title: appLogo,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: KeyboardDismissOnTap(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocProvider(
                create: (_) => LoginBloc(
                  authService: authService,
                  deepLinkService: deepLinkService,
                  debugService: debugService,
                  router: router,
                ),
                child: LoginForm(
                  router: router,
                  localeSwitcher: localeSwitcher,
                  versionLabel: versionLabel,
                  passwordVisibleIcon: passwordVisibleIcon,
                  passwordHiddenIcon: passwordHiddenIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
