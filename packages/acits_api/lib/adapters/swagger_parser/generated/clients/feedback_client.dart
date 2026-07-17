// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/feedback.dart';

part 'feedback_client.g.dart';

@RestApi()
abstract class FeedbackClient {
  factory FeedbackClient(Dio dio, {String? baseUrl}) = _FeedbackClient;

  /// Feedback create view.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @POST('/api/v1/feedback/')
  Future<Feedback> v1FeedbackCreate({
    @Body() required Feedback body,
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
