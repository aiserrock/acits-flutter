/// Applicants + curators (staff) feature module: edit screens + their cubits,
/// and the [StaffService] application service on top of the stable
/// `StaffApiPort` (acits_api).
///
/// Public API barrel. DTOs stay in the data layer; UI screens, [StaffService]
/// (also used by the app's search paging adapter), and the port/router
/// contracts are exported for the root app to wire.
library;

export 'data/staff_service.dart';
export 'domain/applicants_router_service.dart';
export 'domain/applicants_shelter_provider.dart';
export 'ui/applicant/applicant_edit_screen.dart';
export 'ui/applicant/cubit/applicant_edit_cubit.dart';
export 'ui/curator/cubit/curator_edit_cubit.dart';
export 'ui/curator/curator_edit_screen.dart';
