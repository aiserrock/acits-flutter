import 'dto/current_shelter_dto.dart';
import 'dto/shelter_short_dto.dart';
import 'dto/token_pair_dto.dart';
import 'dto/token_refresh_dto.dart';
import 'dto/user_admin_dto.dart';
import 'dto/user_admin_write_dto.dart';
import 'dto/user_worker_dto.dart';
import 'dto/user_worker_write_dto.dart';

/// Stable port for the auth/session slice — expressed entirely in OUR DTOs.
///
/// Login / register / all-shelters are GUEST calls (no auth token); my-shelters
/// / set-current-shelter are AUTHED. The adapter routes each to the right
/// underlying client; the app depends only on this contract, never on the
/// generated swagger_parser types.
abstract interface class AuthApiPort {
  /// `POST /api/token/` — obtains an access+refresh pair from credentials (guest).
  Future<TokenPairDto> login(String username, String password);

  /// `POST /api/token/refresh/` — refreshes the access token. [refresh]/[access]
  /// are the current tokens (authed path uses the interceptor's token anyway).
  Future<TokenRefreshDto> refresh(String? refresh, String? access);

  /// `GET /api/v1/users/me/shelters/` — the caller's shelters (authed). Returns
  /// the unwrapped `results` list.
  Future<List<ShelterShortDto>> myShelters();

  /// `GET /api/v1/users/me/shelters/current/` — sets and returns the current
  /// shelter + role for [shelterId] (authed).
  Future<CurrentShelterDto> setCurrentShelter(int shelterId);

  /// `GET /api/v1/shelters/` — all shelters (guest), for registration picker.
  /// Returns the unwrapped `results` list.
  Future<List<ShelterShortDto>> allShelters({int? limit, int? offset, String? search});

  /// `POST /api/v1/users/admin-register/` — registers a shelter + admin (guest).
  Future<UserAdminDto> registerAdmin(UserAdminWriteDto body);

  /// `POST /api/v1/users/worker-register/` — registers a worker (guest).
  Future<UserWorkerDto> registerWorker(UserWorkerWriteDto body);
}
