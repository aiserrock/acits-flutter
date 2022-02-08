import 'package:acits_flutter/export.dart';

extension ApplicantX on Applicant {
  String? get fullName {
    return '$firstName $lastName';
  }
}
