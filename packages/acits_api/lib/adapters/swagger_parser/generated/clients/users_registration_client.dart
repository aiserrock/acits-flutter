// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user_shelter_admin_serializers.dart';
import '../models/user_shelter_worker_serializers.dart';

part 'users_registration_client.g.dart';

@RestApi()
abstract class UsersRegistrationClient {
  factory UsersRegistrationClient(Dio dio, {String? baseUrl}) = _UsersRegistrationClient;

  /// Register admin with shelter after captcha validation.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/users/admin-register/')
  Future<UserShelterAdminSerializers> v1UsersAdminRegisterCreate({
    @Body() required UserShelterAdminSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Verify email.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/verify-email/{uidb64}/{sidb64}/{token}/')
  Future<void> v1UsersVerifyEmailRetrieve({
    @Path('sidb64') required String sidb64,
    @Path('token') required String token,
    @Path('uidb64') required String uidb64,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Verify worker to shelter by admin view.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/users/verify-worker/{uidb64}/{sidb64}/{token}/')
  Future<void> v1UsersVerifyWorkerRetrieve({
    @Path('sidb64') required String sidb64,
    @Path('token') required String token,
    @Path('uidb64') required String uidb64,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Register worker after captcha validation.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/users/worker-register/')
  Future<UserShelterWorkerSerializers> v1UsersWorkerRegisterCreate({
    @Body() required UserShelterWorkerSerializers body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
