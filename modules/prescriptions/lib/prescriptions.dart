/// Prescriptions + drugs feature module: today executions, prescription
/// edit screen, the animal-detail prescriptions tab cubit, drug search, and the
/// [PrescriptionRepository] (Result-returning) on top of the stable
/// `PrescriptionApiPort` (core api).
///
/// Public API barrel. DTOs stay in core (api ports); domain entities, the
/// repository contract + impl (used by the app shell, detail screen and edit
/// screen), the thin [PrescriptionService] wrapper for the media search paging
/// adapter, the port / router contracts, cubits, cards and screens are exported
/// for the root app to wire.
library;

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
