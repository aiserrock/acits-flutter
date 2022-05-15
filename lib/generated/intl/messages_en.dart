// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count, day) =>
      "${Intl.plural(count, zero: 'no ${day}s', one: '${count} ${day}', two: '${count} ${day}s', few: '${count} ${day}s', other: '${count} ${day}s')}";

  static String m1(count, month) =>
      "${Intl.plural(count, zero: 'no ${month}s', one: '${count} ${month}', two: '${count} ${month}s', few: '${count} ${month}s', other: '${count} ${month}s')}";

  static String m2(count, year) =>
      "${Intl.plural(count, zero: 'no ${year}s', one: '${count} ${year}', two: '${count} ${year}s', few: '${count} ${year}s', other: '${count} ${year}s')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "animalAdd": MessageLookupByLibrary.simpleMessage("New animal"),
        "animalAdditionalInfo":
            MessageLookupByLibrary.simpleMessage("Additional info"),
        "animalAdmitted": MessageLookupByLibrary.simpleMessage("Admitted"),
        "animalAge": MessageLookupByLibrary.simpleMessage("Age"),
        "animalAgeAppox": MessageLookupByLibrary.simpleMessage("Approximate"),
        "animalAgeExact": MessageLookupByLibrary.simpleMessage("Exact"),
        "animalAnimalFamily":
            MessageLookupByLibrary.simpleMessage("Animal family"),
        "animalAnimalKind": MessageLookupByLibrary.simpleMessage("Animal kind"),
        "animalAnimalStatus":
            MessageLookupByLibrary.simpleMessage("Animal status"),
        "animalApplicant": MessageLookupByLibrary.simpleMessage("Applicant"),
        "animalBirth": MessageLookupByLibrary.simpleMessage("Birth date"),
        "animalCardTitle": MessageLookupByLibrary.simpleMessage("Animal card"),
        "animalCatchPlace": MessageLookupByLibrary.simpleMessage("Catch place"),
        "animalCategory": MessageLookupByLibrary.simpleMessage("Category"),
        "animalChip": MessageLookupByLibrary.simpleMessage("Ring/chip"),
        "animalChipDate": MessageLookupByLibrary.simpleMessage("Chipping date"),
        "animalColor": MessageLookupByLibrary.simpleMessage("Color"),
        "animalComments": MessageLookupByLibrary.simpleMessage("Comments"),
        "animalCommonInfo": MessageLookupByLibrary.simpleMessage("Common info"),
        "animalCurator": MessageLookupByLibrary.simpleMessage("Curator"),
        "animalCuratorAddress": MessageLookupByLibrary.simpleMessage("Address"),
        "animalCuratorEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "animalCuratorLastName":
            MessageLookupByLibrary.simpleMessage("Last name"),
        "animalCuratorName": MessageLookupByLibrary.simpleMessage("Name"),
        "animalCuratorPhone": MessageLookupByLibrary.simpleMessage("Phone"),
        "animalDateAdmitt": MessageLookupByLibrary.simpleMessage("Admitt date"),
        "animalEdit": MessageLookupByLibrary.simpleMessage("Edit animal"),
        "animalFamily": MessageLookupByLibrary.simpleMessage("Family"),
        "animalGenderFemale": MessageLookupByLibrary.simpleMessage("Female"),
        "animalGenderLess": MessageLookupByLibrary.simpleMessage("Gengerless"),
        "animalGenderMale": MessageLookupByLibrary.simpleMessage("Male"),
        "animalGenderMiddle": MessageLookupByLibrary.simpleMessage("Middle"),
        "animalGenderUndefined":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "animalKind": MessageLookupByLibrary.simpleMessage("Kind"),
        "animalMaxImagesCountIs": MessageLookupByLibrary.simpleMessage(
            "Max images count for animal is "),
        "animalName": MessageLookupByLibrary.simpleMessage("Nickname"),
        "animalPickCurator":
            MessageLookupByLibrary.simpleMessage("Pick curator"),
        "animalPrescriptions":
            MessageLookupByLibrary.simpleMessage("Prescriptions"),
        "animalQtyMonth": MessageLookupByLibrary.simpleMessage("Qty month"),
        "animalQtyYear": MessageLookupByLibrary.simpleMessage("Year qty"),
        "animalReceiptDate":
            MessageLookupByLibrary.simpleMessage("Receipt date"),
        "animalSex": MessageLookupByLibrary.simpleMessage("Sex"),
        "animalSocialLink": MessageLookupByLibrary.simpleMessage("Social link"),
        "animalSpecSigns":
            MessageLookupByLibrary.simpleMessage("Special signs"),
        "animalStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "animalStatusAndJoin":
            MessageLookupByLibrary.simpleMessage("Status and join"),
        "animalTransferAct":
            MessageLookupByLibrary.simpleMessage("Transfer act"),
        "animalUploadAct":
            MessageLookupByLibrary.simpleMessage("Upload transfer act"),
        "animalWeight": MessageLookupByLibrary.simpleMessage("Weight, kg"),
        "aninmalSize": MessageLookupByLibrary.simpleMessage("Size, cm"),
        "applicantAdd": MessageLookupByLibrary.simpleMessage("New applicant"),
        "applicantEdit": MessageLookupByLibrary.simpleMessage("Edit applicant"),
        "commentDeletingFail":
            MessageLookupByLibrary.simpleMessage("Comment deletion failed"),
        "commentTitleEdit":
            MessageLookupByLibrary.simpleMessage("Edit comment"),
        "commentTitleNew": MessageLookupByLibrary.simpleMessage("New comment"),
        "common": MessageLookupByLibrary.simpleMessage("common"),
        "commonAdd": MessageLookupByLibrary.simpleMessage("Add"),
        "commonAnimals": MessageLookupByLibrary.simpleMessage("Animals"),
        "commonBegin": MessageLookupByLibrary.simpleMessage("Begin"),
        "commonCalendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "commonDay": MessageLookupByLibrary.simpleMessage("day"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "commonDidNotImpl":
            MessageLookupByLibrary.simpleMessage("Did not implemented yet :("),
        "commonDone": MessageLookupByLibrary.simpleMessage("Done"),
        "commonDrugs": MessageLookupByLibrary.simpleMessage("Drugs"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "commonError": MessageLookupByLibrary.simpleMessage("Error"),
        "commonErrorStubMsg": MessageLookupByLibrary.simpleMessage(
            "Failed to load data.\nPlease try again."),
        "commonErrorStubTitle":
            MessageLookupByLibrary.simpleMessage("Oh, something went wrong..."),
        "commonErrorTryAgainMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Try again later."),
        "commonLoading": MessageLookupByLibrary.simpleMessage("Loading"),
        "commonMonth": MessageLookupByLibrary.simpleMessage("month"),
        "commonNDays": m0,
        "commonNMonth": m1,
        "commonNYears": m2,
        "commonNext": MessageLookupByLibrary.simpleMessage("Next"),
        "commonNotCompleted":
            MessageLookupByLibrary.simpleMessage("Not completed"),
        "commonReloadBtn": MessageLookupByLibrary.simpleMessage("Reload"),
        "commonReschedule": MessageLookupByLibrary.simpleMessage("Reschedule"),
        "commonSearch": MessageLookupByLibrary.simpleMessage("Search"),
        "commonSort": MessageLookupByLibrary.simpleMessage("Sort"),
        "commonToday": MessageLookupByLibrary.simpleMessage("Today"),
        "commonYear": MessageLookupByLibrary.simpleMessage("year"),
        "curatorAdd": MessageLookupByLibrary.simpleMessage("New curator"),
        "curatorEdit": MessageLookupByLibrary.simpleMessage("Edit curator"),
        "errorDefaultMsg": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Try again later."),
        "errorInternetFail":
            MessageLookupByLibrary.simpleMessage("No internet :("),
        "errorInternetFailMsg":
            MessageLookupByLibrary.simpleMessage("Try again later"),
        "loginAuthorizeError":
            MessageLookupByLibrary.simpleMessage("Wrong login or password"),
        "loginDescribeMsg": MessageLookupByLibrary.simpleMessage(
            "ACITS - Animal control\nin the shelter"),
        "loginEntryBtn": MessageLookupByLibrary.simpleMessage("Enter"),
        "loginForgetPass":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "loginLoginHint":
            MessageLookupByLibrary.simpleMessage("Enter your email or login"),
        "loginLoginLabel": MessageLookupByLibrary.simpleMessage("Login"),
        "loginPassLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "loginToRegistration":
            MessageLookupByLibrary.simpleMessage("Register now"),
        "mainAddAppointments":
            MessageLookupByLibrary.simpleMessage("Add appointments"),
        "mainAnimal": MessageLookupByLibrary.simpleMessage("Animal"),
        "mainAppoinment": MessageLookupByLibrary.simpleMessage("Appoinment"),
        "mainAppoinmentAuthor":
            MessageLookupByLibrary.simpleMessage("Appoinment author"),
        "mainAppointments":
            MessageLookupByLibrary.simpleMessage("Appointments"),
        "mainEmptyState": MessageLookupByLibrary.simpleMessage(
            "There are no appointments for today"),
        "mainTitle": MessageLookupByLibrary.simpleMessage("Today"),
        "onboardingDrugsMsg": MessageLookupByLibrary.simpleMessage(
            "We have prepared in advance the maximum number of medical appointments for shelters"),
        "onboardingDrugsTitle": MessageLookupByLibrary.simpleMessage(
            "Flexible system of work with appointments"),
        "onboardingFreeMsg": MessageLookupByLibrary.simpleMessage(
            "All functionality will be available to you in full, without restrictions"),
        "onboardingFreeTitle":
            MessageLookupByLibrary.simpleMessage("Absolutely free"),
        "onboardingNewsMsg": MessageLookupByLibrary.simpleMessage(
            "The map is maintained throughout the life of the animal and does not depend on the shelter"),
        "onboardingNewsTitle":
            MessageLookupByLibrary.simpleMessage("Unified card of the animal"),
        "onboardingPlanMsg": MessageLookupByLibrary.simpleMessage(
            "Allows you to clearly plan working hours and provide timely medical assistance to animals"),
        "onboardingPlanTitle": MessageLookupByLibrary.simpleMessage(
            "Summary of appointments for the current day"),
        "shelterSelectShelter":
            MessageLookupByLibrary.simpleMessage("Pick the shelter")
      };
}
