import 'package:acits_flutter/ui/screen/prescription/prescription_edit_screen.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';

class PrescriptionEditScreenRoute extends MaterialPageRoute<Prescription?> {
  PrescriptionEditScreenRoute({int? editPrescriptionId, Prescription? editPrescription})
      : super(
            builder: (_) => PrescriptionEditScreen(
                  editPrescriptionId: editPrescriptionId,
                  editPrescription: editPrescription,
                ));
}
