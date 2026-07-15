import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:acits_flutter/ui/screen/auth/login.dart';
import 'package:acits_flutter/ui/widget/app_logo.dart';
import 'package:acits_flutter/ui/widget/locale_switcher.dart';
import 'package:acits_flutter/ui/widget/theme_switcher_tile.dart';

/// Экран входа по логину - паролю
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: const ThemeToggleButton(),
        title: const AppLogoBar(),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Center(child: LocaleSwitcher()),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: KeyboardDismissOnTap(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocProvider(create: (_) => LoginBloc(), child: LoginForm()),
            ),
          ],
        ),
      ),
    );
  }
}
