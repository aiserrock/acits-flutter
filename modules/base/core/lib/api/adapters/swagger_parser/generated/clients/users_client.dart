// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/email.dart';
import '../models/paginated_shelter_short_serializers_list.dart';
import '../models/paginated_user_short_serializers_list.dart';
import '../models/patched_user_change_password_serializers.dart';
import '../models/patched_user_serializers.dart';
import '../models/user_change_password_serializers.dart';
import '../models/user_current_shelter_serializers.dart';
import '../models/user_reset_password_complete.dart';
import '../models/user_serializers.dart';

part 'users_client.g.dart';

@RestApi()
abstract class UsersClient {
  factory UsersClient(Dio dio, {String? baseUrl}) = _UsersClient;

  /// List of available workers for the shelter.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/available-workers/')
  Future<PaginatedUserShortSerializersList> v1UsersAvailableWorkersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// User profile.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/me/')
  Future<UserSerializers> v1UsersMeRetrieve({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// User profile.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/users/me/')
  Future<UserSerializers> v1UsersMeUpdate({
    @Body() required UserSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// User profile.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/users/me/')
  Future<UserSerializers> v1UsersMePartialUpdate({
    @Body() PatchedUserSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Change password.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PUT('/api/v1/users/me/change_password/')
  Future<UserChangePasswordSerializers> v1UsersMeChangePasswordUpdate({
    @Body() required UserChangePasswordSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Change password.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @PATCH('/api/v1/users/me/change_password/')
  Future<UserChangePasswordSerializers> v1UsersMeChangePasswordPartialUpdate({
    @Body() PatchedUserChangePasswordSerializers? body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// List of user shelters.
  ///
  /// [limit] - Number of results to return per page.
  ///
  /// [offset] - The initial index from which to return the results.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/me/shelters/')
  Future<PaginatedShelterShortSerializersList> v1UsersMeSheltersList({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  /// User current shelter detail view.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/me/shelters/current/')
  Future<UserCurrentShelterSerializers> v1UsersMeSheltersCurrentRetrieve({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// A post method for performing password request.
  /// Returns 400 in case user is not found.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/users/reset-password/')
  Future<void> v1UsersResetPasswordCreate({
    @Body() required Email body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// A post method extracts new password, token, uidb64.
  /// and calls PasswordResetService service.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/users/reset-password/complete/')
  Future<void> v1UsersResetPasswordCompleteCreate({
    @Body() required UserResetPasswordComplete body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// A view to verify credentials for the following password reset.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/reset-password/confirm/{uidb64}/{token}/')
  Future<void> v1UsersResetPasswordConfirmRetrieve({
    @Path('token') required String token,
    @Path('uidb64') required String uidb64,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
