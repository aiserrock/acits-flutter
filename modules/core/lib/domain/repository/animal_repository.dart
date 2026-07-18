import 'package:base/base.dart';

import '../entity/animal.dart';

abstract interface class AnimalRepository {
  Future<Result<Failure, List<Animal>>> list({int? shelterId, String? search, int? limit, int? offset});

  Future<Result<Failure, Animal>> getById(int id);
}
