/// Prescriptions + drugs feature module: today executions, prescription
/// edit screen, the animal-detail prescriptions tab cubit, drug search, and the
/// [PrescriptionService] application service on top of the stable
/// `PrescriptionApiPort` (acits_api).
///
/// Public API barrel. DTOs stay in acits_api; domain entities, the service (also
/// used by the app shell, detail screen, and search paging adapter), the port /
/// router contracts, cubits, cards and screens are exported for the root app to
/// wire.
library;

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
