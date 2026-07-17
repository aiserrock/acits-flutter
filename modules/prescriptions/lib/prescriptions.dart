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

export 'data/prescription_service.dart';
export 'domain/prescription_animal_loader.dart';
export 'domain/prescription_barrel.dart';
export 'domain/prescription_type_labels.dart';
export 'domain/prescriptions_shelter_provider.dart';
export 'domain/router/prescriptions_router_service.dart';
export 'ui/animal_prescriptions/cubit/animal_prescriptions_cubit.dart';
export 'ui/animal_prescriptions/cubit/animal_prescriptions_state.dart';
export 'ui/drugs/drugs_screen.dart';
export 'ui/prescription_edit/cubit/prescription_edit_cubit.dart' show PrescriptionEditCubit, TreatmentPeriod;
export 'ui/prescription_edit/prescription_edit_screen.dart';
export 'ui/widgets/animal_prescription_card.dart';
export 'ui/widgets/prescription_card.dart';
