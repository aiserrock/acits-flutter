import 'package:dio/dio.dart';

import '../../ports/auth_api_port.dart';
import '../../ports/dto/current_shelter_dto.dart';
import '../../ports/dto/shelter_short_dto.dart';
import '../../ports/dto/token_pair_dto.dart';
import '../../ports/dto/token_refresh_dto.dart';
import '../../ports/dto/user_admin_dto.dart';
import '../../ports/dto/user_admin_write_dto.dart';
import '../../ports/dto/user_worker_dto.dart';
import '../../ports/dto/user_worker_write_dto.dart';
import 'generated/clients/shelters_client.dart';
import 'generated/clients/token_client.dart';
import 'generated/clients/users_client.dart';
import 'generated/clients/users_registration_client.dart';
import 'generated/models/role_enum.dart';
import 'generated/models/shelter_serializers.dart';
import 'generated/models/shelter_short_serializers.dart';
import 'generated/models/token_refresh.dart';
import 'generated/models/user_shelter_admin_serializers.dart';
import 'generated/models/user_shelter_worker_serializers.dart';

/// The ONLY place generated swagger_parser code is touched for the auth slice.
///
/// Guest vs authed split mirrors the app's `_acitsClient`/`_acitsGuestClient`:
///  • guest clients (over a Dio WITHOUT the auth interceptor) — [login],
///    [allShelters], [registerAdmin], [registerWorker];
///  • authed clients (over the shared authed Dio) — [myShelters],
///    [setCurrentShelter], and token [refresh].
///
/// Each generated client is constructed in root DI over the appropriate Dio and
/// injected here. Swapping generators = replace this file with a new adapter
/// implementing [AuthApiPort]; ports/DTOs/AuthService stay unchanged.
class AuthApiAdapter implements AuthApiPort {
  const AuthApiAdapter({
    required Dio guestDio,
    required TokenClient authedTokenClient,
    required UsersClient usersClient,
    required SheltersClient guestSheltersClient,
    required UsersRegistrationClient guestRegistrationClient,
  }) : _guestDio = guestDio,
       _authedTokenClient = authedTokenClient,
       _usersClient = usersClient,
       _guestSheltersClient = guestSheltersClient,
       _guestRegistrationClient = guestRegistrationClient;

  final Dio _guestDio;
  final TokenClient _authedTokenClient;
  final UsersClient _usersClient;
  final SheltersClient _guestSheltersClient;
  final UsersRegistrationClient _guestRegistrationClient;

  @override
  Future<TokenPairDto> login(String username, String password) async {
    // Raw POST вместо генерённого tokenCreate: ответ `/api/token/` содержит
    // только access/refresh, а генерённый TokenObtainPair.fromJson требует
    // non-null username/password (write-only поля запроса) → падал на касте
    // `null as String`. Парсим ответ напрямую.
    final response = await _guestDio.post<Map<String, dynamic>>(
      '/api/token/',
      data: <String, dynamic>{'username': username, 'password': password},
    );
    final data = response.data ?? const <String, dynamic>{};
    return TokenPairDto(access: (data['access'] as String?) ?? '', refresh: (data['refresh'] as String?) ?? '');
  }

  @override
  Future<TokenRefreshDto> refresh(String? refresh, String? access) async {
    final result = await _authedTokenClient.tokenRefreshCreate(
      body: TokenRefresh(access: access ?? '', refresh: refresh ?? ''),
    );
    // SimpleJWT without ROTATE_REFRESH_TOKENS returns refresh=null (or '') —
    // surface it as null so AuthService keeps the previously used refresh token.
    final newRefresh = result.refresh;
    return TokenRefreshDto(
      access: result.access ?? '',
      refresh: (newRefresh == null || newRefresh.isEmpty) ? null : newRefresh,
    );
  }

  @override
  Future<List<ShelterShortDto>> myShelters() async {
    final page = await _usersClient.v1UsersMeSheltersList();
    final results = page.results ?? const <ShelterShortSerializers>[];
    return results.map(_mapShelter).toList(growable: false);
  }

  @override
  Future<CurrentShelterDto> setCurrentShelter(int shelterId) async {
    final result = await _usersClient.v1UsersMeSheltersCurrentRetrieve(xCurrentShelter: shelterId);
    return CurrentShelterDto(
      currentShelter: result.currentShelter ?? 0,
      currentShelterUserRole: result.currentShelterUserRole ?? '',
      isUserCanEdit: result.isUserCanEdit ?? false,
      isUserCanDelete: result.isUserCanDelete ?? false,
    );
  }

  @override
  Future<List<ShelterShortDto>> allShelters({int? limit, int? offset, String? search}) async {
    final page = await _guestSheltersClient.v1SheltersList(limit: limit, offset: offset, search: search);
    final results = page.results ?? const <ShelterShortSerializers>[];
    return results.map(_mapShelter).toList(growable: false);
  }

  @override
  Future<UserAdminDto> registerAdmin(UserAdminWriteDto body) async {
    final result = await _guestRegistrationClient.v1UsersAdminRegisterCreate(body: _mapAdminWrite(body));
    return UserAdminDto(
      id: result.id ?? 0,
      firstName: result.firstName ?? '',
      lastName: result.lastName ?? '',
      fathersName: result.fathersName,
      email: result.email ?? '',
      phoneNumber: result.phoneNumber,
      address: result.address,
      isOfferSigned: result.isOfferSigned ?? false,
      shelter: result.shelter == null ? const {} : Map<String, dynamic>.from(result.shelter!.toJson()),
    );
  }

  @override
  Future<UserWorkerDto> registerWorker(UserWorkerWriteDto body) async {
    final result = await _guestRegistrationClient.v1UsersWorkerRegisterCreate(body: _mapWorkerWrite(body));
    return UserWorkerDto(
      firstName: result.firstName ?? '',
      lastName: result.lastName ?? '',
      fathersName: result.fathersName,
      email: result.email ?? '',
      phoneNumber: result.phoneNumber,
      address: result.address,
      shelter: result.shelter,
      role: result.role?.json,
      isOfferSigned: result.isOfferSigned ?? false,
    );
  }

  // ── mapping helpers ─────────────────────────────────────────────────────────

  ShelterShortDto _mapShelter(ShelterShortSerializers s) => ShelterShortDto(id: s.id ?? 0, name: s.name ?? '');

  UserShelterAdminSerializers _mapAdminWrite(UserAdminWriteDto d) => UserShelterAdminSerializers(
    // `id` is required by the generated write model but read-only server-side;
    // 0 is a harmless placeholder that DRF ignores on create.
    id: 0,
    firstName: d.firstName,
    lastName: d.lastName,
    fathersName: d.fathersName,
    email: d.email,
    phoneNumber: d.phoneNumber,
    address: d.address,
    password: d.password,
    rePassword: d.rePassword,
    isOfferSigned: d.isOfferSigned,
    shelter: ShelterSerializers(
      // Same as above: id is read-only, placeholder ignored on create.
      id: 0,
      name: d.shelter.name,
      country: d.shelter.country,
      city: d.shelter.city,
      region: d.shelter.region,
    ),
  );

  UserShelterWorkerSerializers _mapWorkerWrite(UserWorkerWriteDto d) => UserShelterWorkerSerializers(
    firstName: d.firstName,
    lastName: d.lastName,
    fathersName: d.fathersName,
    email: d.email,
    phoneNumber: d.phoneNumber,
    address: d.address,
    password: d.password,
    rePassword: d.rePassword,
    shelter: d.shelter ?? 0,
    role: RoleEnum.fromJson(d.role),
    isOfferSigned: d.isOfferSigned,
  );
}
