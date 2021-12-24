import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/strings.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/ui/screen/auth/login_screen.dart';
import 'package:acits_flutter/ui/screen/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.commonAppName,
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(
          buttonColor: ColorRes.primaryButton,
          textTheme: ButtonTextTheme.primary,
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
        ),
        textTheme: const TextTheme(
          button: StyleRes.button,
        ),
      ),
      localizationsDelegates: const [
        StringRes.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: StringRes.delegate.supportedLocales,
      home: const LoginScreen(),
    );
  }
}
