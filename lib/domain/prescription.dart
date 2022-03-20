import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/config/config_service.dart';


extension PrescriptionShortX on PrescriptionShort {
  String? get typeString {
    final _service = getIt<ConfigService>();
    return _service.getMyTypeName(myType);
  }
}

extension MyTypeEnumX on MyTypeEnum {
  String? get typeString {
    final _service = getIt<ConfigService>();
    return _service.getMyTypeName(this);
  }
}
