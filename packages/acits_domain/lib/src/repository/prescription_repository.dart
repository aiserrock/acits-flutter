import 'package:acits_core/acits_core.dart';

import '../entity/prescription.dart';

abstract interface class PrescriptionRepository {
  Future<Result<Failure, List<Prescription>>> listForAnimal(int animalId);
}
