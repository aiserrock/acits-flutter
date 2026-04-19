import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/ui/screen/onboarding/bloc/onboarding_bloc.dart';
import 'package:acits_flutter/ui/screen/onboarding/view/onboarding_screen.dart';

/// Роут экрана онбординга
class OnboardingRoute extends MaterialPageRoute {
  OnboardingRoute()
    : super(
        builder: (_) =>
            BlocProvider(create: (context) => OnboardingBloc(), child: const OnboardingScreen()),
      );
}
