import 'package:dio/dio.dart';

import '../../ports/dto/user_dto.dart';
import '../../ports/dto/user_write_dto.dart';
import '../../ports/profile_api_port.dart';
import 'generated/clients/users_client.dart';
import 'generated/models/user_serializers.dart';

/// The ONLY place generated swagger_parser code is touched for the profile slice.
///
/// `me`/`updateMe` map cleanly onto the typed [UsersClient]. Change-password
/// goes through the raw [Dio] to preserve the exact chopper wire body: the
/// generated `UserChangePasswordSerializers` requires `id`, but the app has
/// always posted only `old_password`/`password`/`re_password`. Swapping
/// generators = replace this file with a new adapter implementing [ProfileApiPort].
class ProfileApiAdapter implements ProfileApiPort {
  const ProfileApiAdapter(this._dio, this._users);

  final Dio _dio;
  final UsersClient _users;

  Options _shelterHeader(int? shelterId) =>
      Options(headers: shelterId == null ? null : {'x-current-shelter': shelterId});

  @override
  Future<UserDto> me({int? shelterId}) async {
    final result = await _users.v1UsersMeRetrieve(xCurrentShelter: shelterId);
    return _mapUser(result);
  }

  @override
  Future<UserDto> updateMe(UserWriteDto body, {int? shelterId}) async {
    final result = await _users.v1UsersMeUpdate(body: _userBody(body), xCurrentShelter: shelterId);
    return _mapUser(result);
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword, {int? shelterId}) async {
    await _dio.put<Map<String, dynamic>>(
      '/api/v1/users/me/change_password/',
      data: {'old_password': oldPassword, 'password': newPassword, 're_password': newPassword},
      options: _shelterHeader(shelterId),
    );
  }

  // ── OUR write-DTO → generated body ──────────────────────────────────────────

  UserSerializers _userBody(UserWriteDto d) => UserSerializers(
    id: d.id,
    username: d.username,
    firstName: d.firstName,
    lastName: d.lastName,
    fathersName: d.fathersName,
    fullName: d.fullName,
    email: d.email,
    phoneNumber: d.phoneNumber,
    address: d.address,
    dateJoined: d.dateJoined,
    isVerified: d.isVerified,
    isOfferSigned: d.isOfferSigned,
  );

  // ── generated → OUR read DTO ────────────────────────────────────────────────

  /// Placeholder for the wire-required non-null `date_joined` that the relaxed
  /// generated model now types nullable. Real profiles always carry it.
  static final _epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  UserDto _mapUser(UserSerializers u) => UserDto(
    id: u.id ?? 0,
    username: u.username ?? '',
    firstName: u.firstName ?? '',
    lastName: u.lastName ?? '',
    fathersName: u.fathersName,
    fullName: u.fullName ?? '',
    email: u.email ?? '',
    phoneNumber: u.phoneNumber,
    address: u.address,
    dateJoined: u.dateJoined ?? _epoch,
    isVerified: u.isVerified ?? false,
    isOfferSigned: u.isOfferSigned,
  );
}
