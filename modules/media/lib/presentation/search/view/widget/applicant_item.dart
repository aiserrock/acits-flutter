import 'package:core/domain.dart' show Applicant;
import 'package:flutter/material.dart';

class ApplicantListItem extends StatelessWidget {
  const ApplicantListItem({required this.applicant, super.key});

  final Applicant applicant;

  static Widget builder(Applicant applicant) => ApplicantListItem(applicant: applicant);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(applicant.fullName));
  }
}
