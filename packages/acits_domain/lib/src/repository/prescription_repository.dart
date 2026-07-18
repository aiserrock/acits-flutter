import 'package:base/base.dart';

import '../entity/prescription.dart';

abstract interface class PrescriptionRepository {
  Future<Result<Failure, List<Prescription>>> listForAnimal(int animalId);
}
