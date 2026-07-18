import 'dto/user_dto.dart';
import 'dto/user_write_dto.dart';

/// Stable port for the signed-in user's own profile (`/api/v1/users/me/`).
///
/// Expressed entirely in OUR DTOs — never the generated swagger_parser types.
/// All calls are authed and scoped by [shelterId] (the `x-current-shelter`
/// header), matching the prior chopper behaviour.
abstract interface class ProfileApiPort {
  /// `GET /api/v1/users/me/` — the caller's profile.
  Future<UserDto> me({int? shelterId});

  /// `PUT /api/v1/users/me/` — replaces the profile with [body]; returns it.
  Future<UserDto> updateMe(UserWriteDto body, {int? shelterId});

  /// `PUT /api/v1/users/me/change_password/` — changes the password. Succeeds
  /// silently; throws on failure.
  Future<void> changePassword(String oldPassword, String newPassword, {int? shelterId});
}
