import 'package:core/api.dart';
import 'package:animals/animals.dart';
import 'package:injectable/injectable.dart';

/// DI-модуль фичи «Животные»: собирает data-слой модуля поверх стабильного
/// [AnimalApiPort] (зарегистрирован в AcitsApiRegister). Наружу отдаёт домен —
/// [AnimalRepository]; UI-фича резолвит его, а не конкретную реализацию.
@module
abstract class AnimalsRegister {
  AnimalRemoteDataSource animalRemoteDataSource(AnimalApiPort port) => AnimalRemoteDataSource(port);

  @Injectable(as: AnimalRepository)
  AnimalRepositoryImpl animalRepository(AnimalRemoteDataSource remote) => AnimalRepositoryImpl(remote);
}
