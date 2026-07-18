/// Applicants + curators (staff) feature module: edit screens + their cubits,
/// and the [StaffService] application service on top of the stable
/// `StaffApiPort` (core api).
///
/// Public API barrel. DTOs stay in the data layer; UI screens, [StaffService]
/// (also used by the app's search paging adapter), and the port/router
/// contracts are exported for the root app to wire.
library;

export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
