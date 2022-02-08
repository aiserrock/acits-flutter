import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_applicant_screen.dart';

class SearchApplicantScreenRoute extends MaterialPageRoute<Applicant> {
  SearchApplicantScreenRoute() : super(builder: (_) => const SearchApplicantScreen());
}
