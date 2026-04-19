import 'package:flutter/material.dart';

import 'package:acits_flutter/ui/screen/personal_screen/personal_screen.dart';

class PersonalScreenRoute extends MaterialPageRoute<void> {
  PersonalScreenRoute({bool changePass = false})
    : super(builder: (_) => PersonalScreen(isChangePass: changePass));
}
