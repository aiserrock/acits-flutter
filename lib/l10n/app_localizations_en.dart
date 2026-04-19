// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get animalAdd => 'New animal';

  @override
  String get animalAdditionalInfo => 'Additional info';

  @override
  String get animalAdmitted => 'Admitted';

  @override
  String get animalAge => 'Age';

  @override
  String get animalAgeAppox => 'Approximate';

  @override
  String get animalAgeExact => 'Exact';

  @override
  String get animalAnimalFamily => 'Animal family';

  @override
  String get animalAnimalKind => 'Animal kind';

  @override
  String get animalAnimalStatus => 'Animal status';

  @override
  String get animalApplicant => 'Applicant';

  @override
  String get animalBirth => 'Birth date';

  @override
  String get animalCardTitle => 'Animal card';

  @override
  String get animalCatchPlace => 'Catch place';

  @override
  String get animalCategory => 'Category';

  @override
  String get animalChip => 'Ring/chip';

  @override
  String get animalChipDate => 'Chipping date';

  @override
  String get animalColor => 'Color';

  @override
  String get animalComments => 'Comments';

  @override
  String get animalCommonInfo => 'Common info';

  @override
  String get animalCurator => 'Curator';

  @override
  String get animalCuratorAddress => 'Address';

  @override
  String get animalCuratorEmail => 'E-mail';

  @override
  String get animalCuratorLastName => 'Last name';

  @override
  String get animalCuratorName => 'Name';

  @override
  String get animalCuratorPhone => 'Phone';

  @override
  String get animalDateAdmitt => 'Admitt date';

  @override
  String get animalDeleteAcceptMsg => 'Do you sure to delete';

  @override
  String get animalEdit => 'Edit animal';

  @override
  String get animalFamily => 'Family';

  @override
  String get animalGenderFemale => 'Female';

  @override
  String get animalGenderLess => 'Gengerless';

  @override
  String get animalGenderMale => 'Male';

  @override
  String get animalGenderMiddle => 'Middle';

  @override
  String get animalGenderUndefined => 'Unknown';

  @override
  String get animalKind => 'Kind';

  @override
  String get animalMaxImagesCountIs => 'Max images count for animal is ';

  @override
  String get animalName => 'Nickname';

  @override
  String get animalPickCurator => 'Pick curator';

  @override
  String get animalPrescriptions => 'Prescriptions';

  @override
  String get animalQtyMonth => 'Qty month';

  @override
  String get animalQtyYear => 'Year qty';

  @override
  String get animalReceiptDate => 'Receipt date';

  @override
  String get animalSex => 'Sex';

  @override
  String get animalSocialLink => 'Social link';

  @override
  String get animalSpecSigns => 'Special signs';

  @override
  String get animalStatus => 'Status';

  @override
  String get animalStatusAndJoin => 'Status and join';

  @override
  String get animalTransferAct => 'Transfer act';

  @override
  String get animalUploadAct => 'Upload transfer act';

  @override
  String get animalWeight => 'Weight, kg';

  @override
  String get aninmalSize => 'Size, cm';

  @override
  String get applicantAdd => 'New applicant';

  @override
  String get applicantEdit => 'Edit applicant';

  @override
  String get commentDeletingFail => 'Comment deletion failed';

  @override
  String get commentTitleEdit => 'Edit comment';

  @override
  String get commentTitleNew => 'New comment';

  @override
  String get common => 'common';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonAnimals => 'Animals';

  @override
  String get commonBegin => 'Begin';

  @override
  String get commonCalendar => 'Calendar';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonDay => 'day';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonDidNotImpl => 'Did not implemented yet :(';

  @override
  String get commonDone => 'Done';

  @override
  String get commonDrugs => 'Drugs';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonError => 'Error';

  @override
  String get commonErrorStubMsg => 'Failed to load data.\nPlease try again.';

  @override
  String get commonErrorStubTitle => 'Oh, something went wrong...';

  @override
  String get commonErrorTryAgainMessage =>
      'Something went wrong. Try again later.';

  @override
  String get commonLoading => 'Loading';

  @override
  String get commonMonth => 'month';

  @override
  String commonNDays(int count, Object day) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ${day}s',
      few: '$count ${day}s',
      two: '$count ${day}s',
      one: '$count $day',
      zero: 'no ${day}s',
    );
    return '$_temp0';
  }

  @override
  String commonNMonth(int count, Object month) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ${month}s',
      few: '$count ${month}s',
      two: '$count ${month}s',
      one: '$count $month',
      zero: 'no ${month}s',
    );
    return '$_temp0';
  }

  @override
  String commonNYears(int count, Object year) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ${year}s',
      few: '$count ${year}s',
      two: '$count ${year}s',
      one: '$count $year',
      zero: 'no ${year}s',
    );
    return '$_temp0';
  }

  @override
  String get commonNext => 'Next';

  @override
  String get commonNoAppToOpenFileMsg => 'No app to open this file :(';

  @override
  String get commonNotCompleted => 'Not completed';

  @override
  String get commonNotFound => 'Nothing was found :(';

  @override
  String get commonReloadBtn => 'Reload';

  @override
  String get commonRepeat => 'Repeat';

  @override
  String get commonReschedule => 'Reschedule';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonShare => 'Share';

  @override
  String get commonSort => 'Sort';

  @override
  String get commonToday => 'Today';

  @override
  String get commonWarning => 'Warning';

  @override
  String get commonYear => 'year';

  @override
  String get curatorAdd => 'New curator';

  @override
  String get curatorEdit => 'Edit curator';

  @override
  String get errorDefaultMsg => 'Something went wrong. Try again later.';

  @override
  String get errorInternetFail => 'No internet :(';

  @override
  String get errorInternetFailMsg => 'Try again later';

  @override
  String get loginAuthorizeError => 'Wrong login or password';

  @override
  String get loginDescribeMsg => 'ACITS - Animal control\nin the shelter';

  @override
  String get loginEntryBtn => 'Enter';

  @override
  String get loginForgetPass => 'Forgot your password?';

  @override
  String get loginLoginHint => 'Enter your email or login';

  @override
  String get loginLoginLabel => 'Login';

  @override
  String get loginPassLabel => 'Password';

  @override
  String get loginToRegistration => 'Register now';

  @override
  String get mainAddAppointments => 'Add appointments';

  @override
  String get mainAnimal => 'Animal';

  @override
  String get mainAppoinment => 'Appoinment';

  @override
  String get mainAppoinmentAuthor => 'Appoinment author';

  @override
  String get mainAppointments => 'Appointments';

  @override
  String get mainEmptyState => 'There are no appointments for today';

  @override
  String get mainTitle => 'Today';

  @override
  String get onboardingDrugsMsg =>
      'We have prepared in advance the maximum number of medical appointments for shelters';

  @override
  String get onboardingDrugsTitle =>
      'Flexible system of work with appointments';

  @override
  String get onboardingFreeMsg =>
      'All functionality will be available to you in full, without restrictions';

  @override
  String get onboardingFreeTitle => 'Absolutely free';

  @override
  String get onboardingNewsMsg =>
      'The map is maintained throughout the life of the animal and does not depend on the shelter';

  @override
  String get onboardingNewsTitle => 'Unified card of the animal';

  @override
  String get onboardingPlanMsg =>
      'Allows you to clearly plan working hours and provide timely medical assistance to animals';

  @override
  String get onboardingPlanTitle =>
      'Summary of appointments for the current day';

  @override
  String get personChangePass => 'Change pass';

  @override
  String get personChangeShelter => 'Change shelter';

  @override
  String get personFeedback => 'Feedback';

  @override
  String get personLogout => 'Logout';

  @override
  String get personMyData => 'My data';

  @override
  String get personMyShelters => 'My shelters';

  @override
  String get personalChangeErrorMsg => 'Password did not changed';

  @override
  String get personalChangePass => 'Change pass';

  @override
  String get personalEmptyFieldErrorMsg => 'Fill field';

  @override
  String get personalNewPass => ' New password';

  @override
  String get personalOldPass => ' Old password';

  @override
  String get personalPassChanged => 'Password changed';

  @override
  String get personalRePass => ' Repeat password';

  @override
  String get prescriptionAnimal => 'Animal*';

  @override
  String get prescriptionCantChangeAnimalMsg =>
      'Can\\\'t change animal when editing prescription';

  @override
  String get prescriptionComment => 'Comment';

  @override
  String get prescriptionCurrent => 'Current';

  @override
  String get prescriptionDaily => 'Daily';

  @override
  String get prescriptionDate => 'Date';

  @override
  String get prescriptionDrug => 'Drug';

  @override
  String get prescriptionPast => 'Past';

  @override
  String get prescriptionPickAnimalMsg => 'Need pick the animal';

  @override
  String get prescriptionTime => 'At time';

  @override
  String get prescriptionTitleAdd => 'Add prescription';

  @override
  String get prescriptionTitleEdit => 'Edit prescription';

  @override
  String get prescriptionWaitLoadingMsg => 'Wait when loading is done please';

  @override
  String get prescriptionWeekly => 'Weekly';

  @override
  String get regAboutOrg => 'About organization';

  @override
  String get regAboutYou => 'About you';

  @override
  String get regAdminRegMsg =>
      'Person, whose data was write, will become an admin';

  @override
  String get regAgreePersonalDataPart0 => 'I agree with terms of ';

  @override
  String get regAgreePersonalDataPart1 => 'personal data processing';

  @override
  String get regCity => 'City *';

  @override
  String get regCountry => 'Country *';

  @override
  String get regEmaiConfirmation => 'Email confirmation';

  @override
  String get regEmailConfirmSentMsg =>
      'If are you an admin of organization, then you can login. Else you need wait for admin confirmation your request.';

  @override
  String get regEmailConfirmed => 'Email confirmed';

  @override
  String get regEmployee => 'Employee';

  @override
  String get regFathersName => 'Fathers name';

  @override
  String get regFieldEmptyError => 'Need fill the field';

  @override
  String get regGuest => 'Guest';

  @override
  String get regHaveAccount => 'Do you have account?';

  @override
  String get regLeast8Symbols => 'Min 8 symbols';

  @override
  String get regNeedConfirmPolicy =>
      'Require agree with terms of personal data processing';

  @override
  String get regOrg => 'ORGANIZATION';

  @override
  String get regOrgName => 'Shelter name';

  @override
  String get regPassSymbols => 'Eng letters, figures, symbols ';

  @override
  String get regPhoneMask => '+7(ххх)ххх-хх-хх';

  @override
  String get regRegion => 'Region ';

  @override
  String get regRegisterRejectMsg =>
      'Please, fill the form correctly, then try it again.';

  @override
  String get regRegisterRejectTitle => 'Your registration request rejected';

  @override
  String get regTUPmsg => 'You\'ll redirect\nto login page.';

  @override
  String get regTUPtitle => 'Thanks, we recorded everything!';

  @override
  String get regTitle => 'Registration';

  @override
  String get regUser => 'USER';

  @override
  String get regUserRole => 'User role';

  @override
  String get regWriteCity => 'Write the city';

  @override
  String get regWriteCountry => 'Write the country';

  @override
  String get regWriteRegion => 'Write the region';

  @override
  String get shelterSelectShelter => 'Pick the shelter';
}
