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
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
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

  /// `New animal`
  String get animalAdd {
    return Intl.message(
      'New animal',
      name: 'animalAdd',
      desc: '',
      args: [],
    );
  }

  /// `Additional info`
  String get animalAdditionalInfo {
    return Intl.message(
      'Additional info',
      name: 'animalAdditionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Admitted`
  String get animalAdmitted {
    return Intl.message(
      'Admitted',
      name: 'animalAdmitted',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get animalAge {
    return Intl.message(
      'Age',
      name: 'animalAge',
      desc: '',
      args: [],
    );
  }

  /// `Approximate`
  String get animalAgeAppox {
    return Intl.message(
      'Approximate',
      name: 'animalAgeAppox',
      desc: '',
      args: [],
    );
  }

  /// `Exact`
  String get animalAgeExact {
    return Intl.message(
      'Exact',
      name: 'animalAgeExact',
      desc: '',
      args: [],
    );
  }

  /// `Animal family`
  String get animalAnimalFamily {
    return Intl.message(
      'Animal family',
      name: 'animalAnimalFamily',
      desc: '',
      args: [],
    );
  }

  /// `Animal kind`
  String get animalAnimalKind {
    return Intl.message(
      'Animal kind',
      name: 'animalAnimalKind',
      desc: '',
      args: [],
    );
  }

  /// `Animal status`
  String get animalAnimalStatus {
    return Intl.message(
      'Animal status',
      name: 'animalAnimalStatus',
      desc: '',
      args: [],
    );
  }

  /// `Applicant`
  String get animalApplicant {
    return Intl.message(
      'Applicant',
      name: 'animalApplicant',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get animalBirth {
    return Intl.message(
      'Birth date',
      name: 'animalBirth',
      desc: '',
      args: [],
    );
  }

  /// `Animal card`
  String get animalCardTitle {
    return Intl.message(
      'Animal card',
      name: 'animalCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Catch place`
  String get animalCatchPlace {
    return Intl.message(
      'Catch place',
      name: 'animalCatchPlace',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get animalCategory {
    return Intl.message(
      'Category',
      name: 'animalCategory',
      desc: '',
      args: [],
    );
  }

  /// `Ring/chip`
  String get animalChip {
    return Intl.message(
      'Ring/chip',
      name: 'animalChip',
      desc: '',
      args: [],
    );
  }

  /// `Chipping date`
  String get animalChipDate {
    return Intl.message(
      'Chipping date',
      name: 'animalChipDate',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get animalColor {
    return Intl.message(
      'Color',
      name: 'animalColor',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get animalComments {
    return Intl.message(
      'Comments',
      name: 'animalComments',
      desc: '',
      args: [],
    );
  }

  /// `Common info`
  String get animalCommonInfo {
    return Intl.message(
      'Common info',
      name: 'animalCommonInfo',
      desc: '',
      args: [],
    );
  }

  /// `Curator`
  String get animalCurator {
    return Intl.message(
      'Curator',
      name: 'animalCurator',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get animalCuratorAddress {
    return Intl.message(
      'Address',
      name: 'animalCuratorAddress',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get animalCuratorEmail {
    return Intl.message(
      'E-mail',
      name: 'animalCuratorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get animalCuratorLastName {
    return Intl.message(
      'Last name',
      name: 'animalCuratorLastName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get animalCuratorName {
    return Intl.message(
      'Name',
      name: 'animalCuratorName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get animalCuratorPhone {
    return Intl.message(
      'Phone',
      name: 'animalCuratorPhone',
      desc: '',
      args: [],
    );
  }

  /// `Admitt date`
  String get animalDateAdmitt {
    return Intl.message(
      'Admitt date',
      name: 'animalDateAdmitt',
      desc: '',
      args: [],
    );
  }

  /// `Do you sure to delete`
  String get animalDeleteAcceptMsg {
    return Intl.message(
      'Do you sure to delete',
      name: 'animalDeleteAcceptMsg',
      desc: '',
      args: [],
    );
  }

  /// `Edit animal`
  String get animalEdit {
    return Intl.message(
      'Edit animal',
      name: 'animalEdit',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get animalFamily {
    return Intl.message(
      'Family',
      name: 'animalFamily',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get animalGenderFemale {
    return Intl.message(
      'Female',
      name: 'animalGenderFemale',
      desc: '',
      args: [],
    );
  }

  /// `Gengerless`
  String get animalGenderLess {
    return Intl.message(
      'Gengerless',
      name: 'animalGenderLess',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get animalGenderMale {
    return Intl.message(
      'Male',
      name: 'animalGenderMale',
      desc: '',
      args: [],
    );
  }

  /// `Middle`
  String get animalGenderMiddle {
    return Intl.message(
      'Middle',
      name: 'animalGenderMiddle',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get animalGenderUndefined {
    return Intl.message(
      'Unknown',
      name: 'animalGenderUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Kind`
  String get animalKind {
    return Intl.message(
      'Kind',
      name: 'animalKind',
      desc: '',
      args: [],
    );
  }

  /// `Max images count for animal is `
  String get animalMaxImagesCountIs {
    return Intl.message(
      'Max images count for animal is ',
      name: 'animalMaxImagesCountIs',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get animalName {
    return Intl.message(
      'Nickname',
      name: 'animalName',
      desc: '',
      args: [],
    );
  }

  /// `Pick curator`
  String get animalPickCurator {
    return Intl.message(
      'Pick curator',
      name: 'animalPickCurator',
      desc: '',
      args: [],
    );
  }

  /// `Prescriptions`
  String get animalPrescriptions {
    return Intl.message(
      'Prescriptions',
      name: 'animalPrescriptions',
      desc: '',
      args: [],
    );
  }

  /// `Qty month`
  String get animalQtyMonth {
    return Intl.message(
      'Qty month',
      name: 'animalQtyMonth',
      desc: '',
      args: [],
    );
  }

  /// `Year qty`
  String get animalQtyYear {
    return Intl.message(
      'Year qty',
      name: 'animalQtyYear',
      desc: '',
      args: [],
    );
  }

  /// `Receipt date`
  String get animalReceiptDate {
    return Intl.message(
      'Receipt date',
      name: 'animalReceiptDate',
      desc: '',
      args: [],
    );
  }

  /// `Sex`
  String get animalSex {
    return Intl.message(
      'Sex',
      name: 'animalSex',
      desc: '',
      args: [],
    );
  }

  /// `Social link`
  String get animalSocialLink {
    return Intl.message(
      'Social link',
      name: 'animalSocialLink',
      desc: '',
      args: [],
    );
  }

  /// `Special signs`
  String get animalSpecSigns {
    return Intl.message(
      'Special signs',
      name: 'animalSpecSigns',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get animalStatus {
    return Intl.message(
      'Status',
      name: 'animalStatus',
      desc: '',
      args: [],
    );
  }

  /// `Status and join`
  String get animalStatusAndJoin {
    return Intl.message(
      'Status and join',
      name: 'animalStatusAndJoin',
      desc: '',
      args: [],
    );
  }

  /// `Transfer act`
  String get animalTransferAct {
    return Intl.message(
      'Transfer act',
      name: 'animalTransferAct',
      desc: '',
      args: [],
    );
  }

  /// `Upload transfer act`
  String get animalUploadAct {
    return Intl.message(
      'Upload transfer act',
      name: 'animalUploadAct',
      desc: '',
      args: [],
    );
  }

  /// `Weight, kg`
  String get animalWeight {
    return Intl.message(
      'Weight, kg',
      name: 'animalWeight',
      desc: '',
      args: [],
    );
  }

  /// `Size, cm`
  String get aninmalSize {
    return Intl.message(
      'Size, cm',
      name: 'aninmalSize',
      desc: '',
      args: [],
    );
  }

  /// `New applicant`
  String get applicantAdd {
    return Intl.message(
      'New applicant',
      name: 'applicantAdd',
      desc: '',
      args: [],
    );
  }

  /// `Edit applicant`
  String get applicantEdit {
    return Intl.message(
      'Edit applicant',
      name: 'applicantEdit',
      desc: '',
      args: [],
    );
  }

  /// `Comment deletion failed`
  String get commentDeletingFail {
    return Intl.message(
      'Comment deletion failed',
      name: 'commentDeletingFail',
      desc: '',
      args: [],
    );
  }

  /// `Edit comment`
  String get commentTitleEdit {
    return Intl.message(
      'Edit comment',
      name: 'commentTitleEdit',
      desc: '',
      args: [],
    );
  }

  /// `New comment`
  String get commentTitleNew {
    return Intl.message(
      'New comment',
      name: 'commentTitleNew',
      desc: '',
      args: [],
    );
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

  /// `Add`
  String get commonAdd {
    return Intl.message(
      'Add',
      name: 'commonAdd',
      desc: '',
      args: [],
    );
  }

  /// `Animals`
  String get commonAnimals {
    return Intl.message(
      'Animals',
      name: 'commonAnimals',
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

  /// `Calendar`
  String get commonCalendar {
    return Intl.message(
      'Calendar',
      name: 'commonCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get commonCancel {
    return Intl.message(
      'Cancel',
      name: 'commonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get commonClose {
    return Intl.message(
      'Close',
      name: 'commonClose',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get commonDay {
    return Intl.message(
      'day',
      name: 'commonDay',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get commonDelete {
    return Intl.message(
      'Delete',
      name: 'commonDelete',
      desc: '',
      args: [],
    );
  }

  /// `Did not implemented yet :(`
  String get commonDidNotImpl {
    return Intl.message(
      'Did not implemented yet :(',
      name: 'commonDidNotImpl',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get commonDone {
    return Intl.message(
      'Done',
      name: 'commonDone',
      desc: '',
      args: [],
    );
  }

  /// `Drugs`
  String get commonDrugs {
    return Intl.message(
      'Drugs',
      name: 'commonDrugs',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get commonEdit {
    return Intl.message(
      'Edit',
      name: 'commonEdit',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get commonError {
    return Intl.message(
      'Error',
      name: 'commonError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load data.\nPlease try again.`
  String get commonErrorStubMsg {
    return Intl.message(
      'Failed to load data.\nPlease try again.',
      name: 'commonErrorStubMsg',
      desc: '',
      args: [],
    );
  }

  /// `Oh, something went wrong...`
  String get commonErrorStubTitle {
    return Intl.message(
      'Oh, something went wrong...',
      name: 'commonErrorStubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Try again later.`
  String get commonErrorTryAgainMessage {
    return Intl.message(
      'Something went wrong. Try again later.',
      name: 'commonErrorTryAgainMessage',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get commonLoading {
    return Intl.message(
      'Loading',
      name: 'commonLoading',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get commonMonth {
    return Intl.message(
      'month',
      name: 'commonMonth',
      desc: '',
      args: [],
    );
  }

  /// `{count,plural, =0{no {day}s} =1{{count} {day}} =2{{count} {day}s} few{{count} {day}s} other{{count} {day}s}}`
  String commonNDays(int count, Object day) {
    return Intl.plural(
      count,
      zero: 'no ${day}s',
      one: '$count $day',
      two: '$count ${day}s',
      few: '$count ${day}s',
      other: '$count ${day}s',
      name: 'commonNDays',
      desc: '',
      args: [count, day],
    );
  }

  /// `{count,plural, =0{no {month}s} =1{{count} {month}} =2{{count} {month}s} few{{count} {month}s} other{{count} {month}s}}`
  String commonNMonth(int count, Object month) {
    return Intl.plural(
      count,
      zero: 'no ${month}s',
      one: '$count $month',
      two: '$count ${month}s',
      few: '$count ${month}s',
      other: '$count ${month}s',
      name: 'commonNMonth',
      desc: '',
      args: [count, month],
    );
  }

  /// `{count,plural, =0{no {year}s} =1{{count} {year}} =2{{count} {year}s} few{{count} {year}s} other{{count} {year}s}}`
  String commonNYears(int count, Object year) {
    return Intl.plural(
      count,
      zero: 'no ${year}s',
      one: '$count $year',
      two: '$count ${year}s',
      few: '$count ${year}s',
      other: '$count ${year}s',
      name: 'commonNYears',
      desc: '',
      args: [count, year],
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

  /// `No app to open this file :(`
  String get commonNoAppToOpenFileMsg {
    return Intl.message(
      'No app to open this file :(',
      name: 'commonNoAppToOpenFileMsg',
      desc: '',
      args: [],
    );
  }

  /// `Not completed`
  String get commonNotCompleted {
    return Intl.message(
      'Not completed',
      name: 'commonNotCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Nothing was found :(`
  String get commonNotFound {
    return Intl.message(
      'Nothing was found :(',
      name: 'commonNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get commonReloadBtn {
    return Intl.message(
      'Reload',
      name: 'commonReloadBtn',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get commonRepeat {
    return Intl.message(
      'Repeat',
      name: 'commonRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get commonReschedule {
    return Intl.message(
      'Reschedule',
      name: 'commonReschedule',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get commonSearch {
    return Intl.message(
      'Search',
      name: 'commonSearch',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get commonShare {
    return Intl.message(
      'Share',
      name: 'commonShare',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get commonSort {
    return Intl.message(
      'Sort',
      name: 'commonSort',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get commonToday {
    return Intl.message(
      'Today',
      name: 'commonToday',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get commonWarning {
    return Intl.message(
      'Warning',
      name: 'commonWarning',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get commonYear {
    return Intl.message(
      'year',
      name: 'commonYear',
      desc: '',
      args: [],
    );
  }

  /// `New curator`
  String get curatorAdd {
    return Intl.message(
      'New curator',
      name: 'curatorAdd',
      desc: '',
      args: [],
    );
  }

  /// `Edit curator`
  String get curatorEdit {
    return Intl.message(
      'Edit curator',
      name: 'curatorEdit',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Try again later.`
  String get errorDefaultMsg {
    return Intl.message(
      'Something went wrong. Try again later.',
      name: 'errorDefaultMsg',
      desc: '',
      args: [],
    );
  }

  /// `No internet :(`
  String get errorInternetFail {
    return Intl.message(
      'No internet :(',
      name: 'errorInternetFail',
      desc: '',
      args: [],
    );
  }

  /// `Try again later`
  String get errorInternetFailMsg {
    return Intl.message(
      'Try again later',
      name: 'errorInternetFailMsg',
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

  /// `ACITS - Animal control\nin the shelter`
  String get loginDescribeMsg {
    return Intl.message(
      'ACITS - Animal control\nin the shelter',
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

  /// `Add appointments`
  String get mainAddAppointments {
    return Intl.message(
      'Add appointments',
      name: 'mainAddAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Animal`
  String get mainAnimal {
    return Intl.message(
      'Animal',
      name: 'mainAnimal',
      desc: '',
      args: [],
    );
  }

  /// `Appoinment`
  String get mainAppoinment {
    return Intl.message(
      'Appoinment',
      name: 'mainAppoinment',
      desc: '',
      args: [],
    );
  }

  /// `Appoinment author`
  String get mainAppoinmentAuthor {
    return Intl.message(
      'Appoinment author',
      name: 'mainAppoinmentAuthor',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get mainAppointments {
    return Intl.message(
      'Appointments',
      name: 'mainAppointments',
      desc: '',
      args: [],
    );
  }

  /// `There are no appointments for today`
  String get mainEmptyState {
    return Intl.message(
      'There are no appointments for today',
      name: 'mainEmptyState',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get mainTitle {
    return Intl.message(
      'Today',
      name: 'mainTitle',
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

  /// `Unified card of the animal`
  String get onboardingNewsTitle {
    return Intl.message(
      'Unified card of the animal',
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

  /// `Change pass`
  String get personChangePass {
    return Intl.message(
      'Change pass',
      name: 'personChangePass',
      desc: '',
      args: [],
    );
  }

  /// `Change shelter`
  String get personChangeShelter {
    return Intl.message(
      'Change shelter',
      name: 'personChangeShelter',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get personFeedback {
    return Intl.message(
      'Feedback',
      name: 'personFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get personLogout {
    return Intl.message(
      'Logout',
      name: 'personLogout',
      desc: '',
      args: [],
    );
  }

  /// `My data`
  String get personMyData {
    return Intl.message(
      'My data',
      name: 'personMyData',
      desc: '',
      args: [],
    );
  }

  /// `My shelters`
  String get personMyShelters {
    return Intl.message(
      'My shelters',
      name: 'personMyShelters',
      desc: '',
      args: [],
    );
  }

  /// `Password did not changed`
  String get personalChangeErrorMsg {
    return Intl.message(
      'Password did not changed',
      name: 'personalChangeErrorMsg',
      desc: '',
      args: [],
    );
  }

  /// `Change pass`
  String get personalChangePass {
    return Intl.message(
      'Change pass',
      name: 'personalChangePass',
      desc: '',
      args: [],
    );
  }

  /// `Fill field`
  String get personalEmptyFieldErrorMsg {
    return Intl.message(
      'Fill field',
      name: 'personalEmptyFieldErrorMsg',
      desc: '',
      args: [],
    );
  }

  /// ` New password`
  String get personalNewPass {
    return Intl.message(
      ' New password',
      name: 'personalNewPass',
      desc: '',
      args: [],
    );
  }

  /// ` Old password`
  String get personalOldPass {
    return Intl.message(
      ' Old password',
      name: 'personalOldPass',
      desc: '',
      args: [],
    );
  }

  /// `Password changed`
  String get personalPassChanged {
    return Intl.message(
      'Password changed',
      name: 'personalPassChanged',
      desc: '',
      args: [],
    );
  }

  /// ` Repeat password`
  String get personalRePass {
    return Intl.message(
      ' Repeat password',
      name: 'personalRePass',
      desc: '',
      args: [],
    );
  }

  /// `Animal*`
  String get prescriptionAnimal {
    return Intl.message(
      'Animal*',
      name: 'prescriptionAnimal',
      desc: '',
      args: [],
    );
  }

  /// `Can\'t change animal when editing prescription`
  String get prescriptionCantChangeAnimalMsg {
    return Intl.message(
      'Can\\\'t change animal when editing prescription',
      name: 'prescriptionCantChangeAnimalMsg',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get prescriptionComment {
    return Intl.message(
      'Comment',
      name: 'prescriptionComment',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get prescriptionCurrent {
    return Intl.message(
      'Current',
      name: 'prescriptionCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get prescriptionDaily {
    return Intl.message(
      'Daily',
      name: 'prescriptionDaily',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get prescriptionDate {
    return Intl.message(
      'Date',
      name: 'prescriptionDate',
      desc: '',
      args: [],
    );
  }

  /// `Drug`
  String get prescriptionDrug {
    return Intl.message(
      'Drug',
      name: 'prescriptionDrug',
      desc: '',
      args: [],
    );
  }

  /// `Past`
  String get prescriptionPast {
    return Intl.message(
      'Past',
      name: 'prescriptionPast',
      desc: '',
      args: [],
    );
  }

  /// `Need pick the animal`
  String get prescriptionPickAnimalMsg {
    return Intl.message(
      'Need pick the animal',
      name: 'prescriptionPickAnimalMsg',
      desc: '',
      args: [],
    );
  }

  /// `At time`
  String get prescriptionTime {
    return Intl.message(
      'At time',
      name: 'prescriptionTime',
      desc: '',
      args: [],
    );
  }

  /// `Add prescription`
  String get prescriptionTitleAdd {
    return Intl.message(
      'Add prescription',
      name: 'prescriptionTitleAdd',
      desc: '',
      args: [],
    );
  }

  /// `Edit prescription`
  String get prescriptionTitleEdit {
    return Intl.message(
      'Edit prescription',
      name: 'prescriptionTitleEdit',
      desc: '',
      args: [],
    );
  }

  /// `Wait when loading is done please`
  String get prescriptionWaitLoadingMsg {
    return Intl.message(
      'Wait when loading is done please',
      name: 'prescriptionWaitLoadingMsg',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get prescriptionWeekly {
    return Intl.message(
      'Weekly',
      name: 'prescriptionWeekly',
      desc: '',
      args: [],
    );
  }

  /// `About organization`
  String get regAboutOrg {
    return Intl.message(
      'About organization',
      name: 'regAboutOrg',
      desc: '',
      args: [],
    );
  }

  /// `About you`
  String get regAboutYou {
    return Intl.message(
      'About you',
      name: 'regAboutYou',
      desc: '',
      args: [],
    );
  }

  /// `Person, whose data was write, will become an admin`
  String get regAdminRegMsg {
    return Intl.message(
      'Person, whose data was write, will become an admin',
      name: 'regAdminRegMsg',
      desc: '',
      args: [],
    );
  }

  /// `I agree with terms of `
  String get regAgreePersonalDataPart0 {
    return Intl.message(
      'I agree with terms of ',
      name: 'regAgreePersonalDataPart0',
      desc: '',
      args: [],
    );
  }

  /// `personal data processing`
  String get regAgreePersonalDataPart1 {
    return Intl.message(
      'personal data processing',
      name: 'regAgreePersonalDataPart1',
      desc: '',
      args: [],
    );
  }

  /// `City *`
  String get regCity {
    return Intl.message(
      'City *',
      name: 'regCity',
      desc: '',
      args: [],
    );
  }

  /// `Country *`
  String get regCountry {
    return Intl.message(
      'Country *',
      name: 'regCountry',
      desc: '',
      args: [],
    );
  }

  /// `Email confirmation`
  String get regEmaiConfirmation {
    return Intl.message(
      'Email confirmation',
      name: 'regEmaiConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `If are you an admin of organization, then you can login. Else you need wait for admin confirmation your request.`
  String get regEmailConfirmSentMsg {
    return Intl.message(
      'If are you an admin of organization, then you can login. Else you need wait for admin confirmation your request.',
      name: 'regEmailConfirmSentMsg',
      desc: '',
      args: [],
    );
  }

  /// `Email confirmed`
  String get regEmailConfirmed {
    return Intl.message(
      'Email confirmed',
      name: 'regEmailConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get regEmployee {
    return Intl.message(
      'Employee',
      name: 'regEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Fathers name`
  String get regFathersName {
    return Intl.message(
      'Fathers name',
      name: 'regFathersName',
      desc: '',
      args: [],
    );
  }

  /// `Need fill the field`
  String get regFieldEmptyError {
    return Intl.message(
      'Need fill the field',
      name: 'regFieldEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get regGuest {
    return Intl.message(
      'Guest',
      name: 'regGuest',
      desc: '',
      args: [],
    );
  }

  /// `Do you have account?`
  String get regHaveAccount {
    return Intl.message(
      'Do you have account?',
      name: 'regHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Min 8 symbols`
  String get regLeast8Symbols {
    return Intl.message(
      'Min 8 symbols',
      name: 'regLeast8Symbols',
      desc: '',
      args: [],
    );
  }

  /// `Require agree with terms of personal data processing`
  String get regNeedConfirmPolicy {
    return Intl.message(
      'Require agree with terms of personal data processing',
      name: 'regNeedConfirmPolicy',
      desc: '',
      args: [],
    );
  }

  /// `ORGANIZATION`
  String get regOrg {
    return Intl.message(
      'ORGANIZATION',
      name: 'regOrg',
      desc: '',
      args: [],
    );
  }

  /// `Shelter name`
  String get regOrgName {
    return Intl.message(
      'Shelter name',
      name: 'regOrgName',
      desc: '',
      args: [],
    );
  }

  /// `Eng letters, figures, symbols `
  String get regPassSymbols {
    return Intl.message(
      'Eng letters, figures, symbols ',
      name: 'regPassSymbols',
      desc: '',
      args: [],
    );
  }

  /// `+7(ххх)ххх-хх-хх`
  String get regPhoneMask {
    return Intl.message(
      '+7(ххх)ххх-хх-хх',
      name: 'regPhoneMask',
      desc: '',
      args: [],
    );
  }

  /// `Region `
  String get regRegion {
    return Intl.message(
      'Region ',
      name: 'regRegion',
      desc: '',
      args: [],
    );
  }

  /// `Please, fill the form correctly, then try it again.`
  String get regRegisterRejectMsg {
    return Intl.message(
      'Please, fill the form correctly, then try it again.',
      name: 'regRegisterRejectMsg',
      desc: '',
      args: [],
    );
  }

  /// `Your registration request rejected`
  String get regRegisterRejectTitle {
    return Intl.message(
      'Your registration request rejected',
      name: 'regRegisterRejectTitle',
      desc: '',
      args: [],
    );
  }

  /// `You'll redirect\nto login page.`
  String get regTUPmsg {
    return Intl.message(
      'You\'ll redirect\nto login page.',
      name: 'regTUPmsg',
      desc: '',
      args: [],
    );
  }

  /// `Thanks, we recorded everything!`
  String get regTUPtitle {
    return Intl.message(
      'Thanks, we recorded everything!',
      name: 'regTUPtitle',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get regTitle {
    return Intl.message(
      'Registration',
      name: 'regTitle',
      desc: '',
      args: [],
    );
  }

  /// `USER`
  String get regUser {
    return Intl.message(
      'USER',
      name: 'regUser',
      desc: '',
      args: [],
    );
  }

  /// `User role`
  String get regUserRole {
    return Intl.message(
      'User role',
      name: 'regUserRole',
      desc: '',
      args: [],
    );
  }

  /// `Write the city`
  String get regWriteCity {
    return Intl.message(
      'Write the city',
      name: 'regWriteCity',
      desc: '',
      args: [],
    );
  }

  /// `Write the country`
  String get regWriteCountry {
    return Intl.message(
      'Write the country',
      name: 'regWriteCountry',
      desc: '',
      args: [],
    );
  }

  /// `Write the region`
  String get regWriteRegion {
    return Intl.message(
      'Write the region',
      name: 'regWriteRegion',
      desc: '',
      args: [],
    );
  }

  /// `Pick the shelter`
  String get shelterSelectShelter {
    return Intl.message(
      'Pick the shelter',
      name: 'shelterSelectShelter',
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
