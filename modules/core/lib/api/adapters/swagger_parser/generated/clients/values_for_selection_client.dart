// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/values_for_selection.dart';

part 'values_for_selection_client.g.dart';

@RestApi()
abstract class ValuesForSelectionClient {
  factory ValuesForSelectionClient(Dio dio, {String? baseUrl}) = _ValuesForSelectionClient;

  /// View for choices values.
  ///
  /// [xCurrentShelter] - Set current shelter id.
  @GET('/api/v1/values-for-selection/')
  Future<ValuesForSelection> v1ValuesForSelectionRetrieve({
    @Header('x-current-shelter') int? xCurrentShelter = 2,
  });
}
