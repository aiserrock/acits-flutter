import 'package:flutter/material.dart';

import 'package:acits_flutter/ui/screen/registration/email_confirmation_screen.dart';

///  Роут для экрана регистрации
class EmailConfirmationScreenRoute extends MaterialPageRoute {
  EmailConfirmationScreenRoute(String confirmLink)
      : super(builder: (_) => EmailConfirmationScreen(confirmLink: confirmLink));
}
