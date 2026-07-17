/// Shared domain layer: entities, repository interfaces, the
/// [Transformable] mapper contract, and the RouterService base.
///
/// DTO-free by rule — this package never depends on `acits_api`.
library;

export 'src/entity/animal.dart';
export 'src/entity/animal_sex.dart';
export 'src/entity/applicant.dart';
export 'src/entity/current_shelter_role.dart';
export 'src/entity/curator.dart';
export 'src/entity/prescription.dart';
export 'src/entity/shelter.dart';
export 'src/mapper/transformable.dart';
export 'src/repository/animal_repository.dart';
export 'src/repository/prescription_repository.dart';
export 'src/router/router_service.dart';

// Re-export Result/Failure so features get them from the domain barrel.
export 'package:acits_core/acits_core.dart' show Result, Ok, Err, Failure;
