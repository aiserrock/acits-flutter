import 'package:equatable/equatable.dart';

/// The current shelter and the signed-in user's role/permissions in it.
///
/// Domain view of `GET /api/v1/users/me/shelters/current/`. Holds the current
/// shelter id, the human-readable role label, and the edit/delete permission
/// flags the app gates UI on.
class CurrentShelterRole extends Equatable {
  const CurrentShelterRole({
    required this.currentShelterId,
    required this.role,
    required this.canEdit,
    required this.canDelete,
  });

  /// Id of the shelter currently scoping the session.
  final int currentShelterId;

  /// Human-readable role label (e.g. `ADMIN`, `WORKER`) as returned by the API.
  final String role;

  /// Whether the user may edit records in the current shelter.
  final bool canEdit;

  /// Whether the user may delete records in the current shelter.
  final bool canDelete;

  /// Convenience: may edit OR delete.
  bool get canEditOrDelete => canEdit || canDelete;

  @override
  List<Object?> get props => [currentShelterId, role, canEdit, canDelete];
}
