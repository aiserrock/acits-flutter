// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class StringRes {
  StringRes();

  static StringRes? _current;

  static StringRes get current {
    assert(_current != null,
        'No instance of StringRes was loaded. Try to initialize the StringRes delegate before accessing StringRes.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<StringRes> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = StringRes();
      StringRes._current = instance;

      return instance;
    });
  }

  static StringRes of(BuildContext context) {
    final instance = StringRes.maybeOf(context);
    assert(instance != null,
        'No instance of StringRes present in the widget tree. Did you add StringRes.delegate in localizationsDelegates?');
    return instance!;
  }

  static StringRes? maybeOf(BuildContext context) {
    return Localizations.of<StringRes>(context, StringRes);
  }

  /// `common`
  String get common {
    return Intl.message(
      'common',
      name: 'common',
      desc: '',
      args: [],
    );
  }

  /// `Begin`
  String get commonBegin {
    return Intl.message(
      'Begin',
      name: 'commonBegin',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get commonNext {
    return Intl.message(
      'Next',
      name: 'commonNext',
      desc: '',
      args: [],
    );
  }

  /// `Wrong login or password`
  String get loginAuthorizeError {
    return Intl.message(
      'Wrong login or password',
      name: 'loginAuthorizeError',
      desc: '',
      args: [],
    );
  }

  /// `ACITS - Animal control system inside the shelter`
  String get loginDescribeMsg {
    return Intl.message(
      'ACITS - Animal control system inside the shelter',
      name: 'loginDescribeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get loginEntryBtn {
    return Intl.message(
      'Enter',
      name: 'loginEntryBtn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get loginForgetPass {
    return Intl.message(
      'Forgot your password?',
      name: 'loginForgetPass',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email or login`
  String get loginLoginHint {
    return Intl.message(
      'Enter your email or login',
      name: 'loginLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginLoginLabel {
    return Intl.message(
      'Login',
      name: 'loginLoginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPassLabel {
    return Intl.message(
      'Password',
      name: 'loginPassLabel',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get loginToRegistration {
    return Intl.message(
      'Register now',
      name: 'loginToRegistration',
      desc: '',
      args: [],
    );
  }

  /// `We have prepared in advance the maximum number of medical appointments for shelters`
  String get onboardingDrugsMsg {
    return Intl.message(
      'We have prepared in advance the maximum number of medical appointments for shelters',
      name: 'onboardingDrugsMsg',
      desc: '',
      args: [],
    );
  }

  /// `Flexible system of work with appointments`
  String get onboardingDrugsTitle {
    return Intl.message(
      'Flexible system of work with appointments',
      name: 'onboardingDrugsTitle',
      desc: '',
      args: [],
    );
  }

  /// `All functionality will be available to you in full, without restrictions`
  String get onboardingFreeMsg {
    return Intl.message(
      'All functionality will be available to you in full, without restrictions',
      name: 'onboardingFreeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Absolutely free`
  String get onboardingFreeTitle {
    return Intl.message(
      'Absolutely free',
      name: 'onboardingFreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `The map is maintained throughout the life of the animal and does not depend on the shelter`
  String get onboardingNewsMsg {
    return Intl.message(
      'The map is maintained throughout the life of the animal and does not depend on the shelter',
      name: 'onboardingNewsMsg',
      desc: '',
      args: [],
    );
  }

  /// `Unified medical card of the animal`
  String get onboardingNewsTitle {
    return Intl.message(
      'Unified medical card of the animal',
      name: 'onboardingNewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Allows you to clearly plan working hours and provide timely medical assistance to animals`
  String get onboardingPlanMsg {
    return Intl.message(
      'Allows you to clearly plan working hours and provide timely medical assistance to animals',
      name: 'onboardingPlanMsg',
      desc: '',
      args: [],
    );
  }

  /// `Summary of appointments for the current day`
  String get onboardingPlanTitle {
    return Intl.message(
      'Summary of appointments for the current day',
      name: 'onboardingPlanTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<StringRes> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<StringRes> load(Locale locale) => StringRes.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
