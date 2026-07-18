/// Shared domain layer: entities, repository interfaces, the
/// [Transformable] mapper contract, and the RouterService base.
///
/// DTO-free by rule — the domain layer never depends on the api layer.
library;

export 'domain/entity/animal.dart';
export 'domain/entity/animal_sex.dart';
export 'domain/exception/exception.dart';
export 'domain/entity/applicant.dart';
export 'domain/entity/current_shelter_role.dart';
export 'domain/entity/curator.dart';
export 'domain/entity/prescription.dart';
export 'domain/entity/shelter.dart';
export 'domain/mapper/transformable.dart';
export 'domain/repository/animal_repository.dart';
export 'domain/repository/prescription_repository.dart';
export 'domain/router/router_service.dart';

// Re-export Result/Failure so features get them from the domain barrel.
export 'package:base/base.dart' show Result, Ok, Err, Failure;
