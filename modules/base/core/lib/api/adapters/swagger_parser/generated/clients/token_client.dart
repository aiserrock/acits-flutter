// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/token_obtain_pair.dart';
import '../models/token_refresh.dart';

part 'token_client.g.dart';

@RestApi()
abstract class TokenClient {
  factory TokenClient(Dio dio, {String? baseUrl}) = _TokenClient;

  /// Takes a set of user credentials and returns an access and refresh JSON web.
  /// token pair to prove the authentication of those credentials.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/token/')
  Future<TokenObtainPair> tokenCreate({
    @Body() required TokenObtainPair body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });

  /// Takes a refresh type JSON web token and returns an access type JSON web.
  /// token if the refresh token is valid.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/token/refresh/')
  Future<TokenRefresh> tokenRefreshCreate({
    @Body() required TokenRefresh body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
