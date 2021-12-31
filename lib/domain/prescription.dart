import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/config/config_service.dart';

extension PrescriptionX on PrescriptionExecutionToday {
  String? get statusString {
    final _service = getIt<ConfigService>();
    return _service.getMyTypeName(myType);
  }
}
