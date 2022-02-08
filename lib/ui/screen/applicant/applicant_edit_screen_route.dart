import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/applicant/applicant_edit_screen.dart';

class ApplicantEditScreenRoute extends MaterialPageRoute<Applicant?> {
  ApplicantEditScreenRoute({int? applicantId})
      : super(builder: (_) => ApplicantEditScreen(applicantId: applicantId));
}
